From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git push (mis ?)behavior
Date: Thu, 4 Oct 2007 19:49:23 +0200
Message-ID: <E9EA8C5A-B56F-4A27-ACC8-0D6686D51BEF@wincent.com>
References: <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com> <20071003104943.GA3017@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031550490.28395@racer.site> <20071003160731.GA7113@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031718110.28395@racer.site> <20071003162816.GA17403@artemis.corp> <Pine.LNX.4.64.0710031742400.28395@racer.site> <20071003170241.GA7571@diana.vm.bytemark.co.uk> <717D7260-CE23-4397-8B13-264309094423@zib.de> <204B0DD6-54B0-4436-AFC6-ABDA4510E5D5@wincent.com> <04A74C2E-272B-4F5C-9254-11C9244091AF@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 19:51:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdUqc-00013j-1d
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 19:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148AbXJDRuo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 13:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758138AbXJDRuo
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 13:50:44 -0400
Received: from wincent.com ([72.3.236.74]:51482 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757533AbXJDRun convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Oct 2007 13:50:43 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l94HnWoE022933;
	Thu, 4 Oct 2007 12:49:32 -0500
In-Reply-To: <04A74C2E-272B-4F5C-9254-11C9244091AF@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59990>

El 4/10/2007, a las 18:24, Steffen Prohaska escribi=F3:

> On Oct 4, 2007, at 5:54 PM, Wincent Colaiuta wrote:
>
>>> I do not find it very intuitive to mangle the push behaviour into =20
>>> the
>>> naming of the local branch. I think it would be a good idea if the
>>> two commands above would either both setup a pull/push relation
>>> or both would setup a pull-only relation. If pull-only would be the
>>> default another switch could be provided to establish a pull/push
>>> relation, like
>>>
>>>    git checkout --track --push -b mynext origin/next
>>>
>>> Comments?
>>
>> Interesting. To me that doesn't seem to be intuitive at all. I =20
>> actually think it makes a lot of sense for the relationship to be =20
>> "one way" in the absence of matching ref names.
>>
>> Basically, the distributed model works because you know that if =20
>> you have the same commit hash in two repositories you're talking =20
>> about the same thing. Same thing goes for branches; if you expect =20
>> to be able to push back upstream then it's natural to expect that =20
>> that should only work if you have the same ref name to identify =20
>> the "what" that you're actually pushing to.
>
> But how do multiple remotes fit into your model? Maybe my example
> above was a bit to simple. How about this one:
>
>    git checkout --track --push -b masterA remoteA/master
>    git checkout --track --push -b masterB remoteB/master
>
> I understand what it means because I devised my local naming model.
> The model could look totally wrong to you, but it's in my repository.
> You'd never see it. But if it fits my mental model, why should git
> enforce its master-means-always-master-and-must-not-be-named-=20
> differently
> model?

I think I'll leave it up to someone who knows a bit more than me to =20
answer that one... It's not a use case I've ever sought out as I =20
usually only work with one upstream remote. Sorry I don't have =20
anything intelligent to add.

Cheers,
Wincent
