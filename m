From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 18:26:00 +0200
Message-ID: <FE701A99-E21C-48C3-BF08-25AE2E3665D6@wincent.com>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com> <20071003073554.GA8110@artemis.corp> <buobqbgmv6z.fsf@dhapc248.dev.necel.com> <83C5420A-528A-43F0-AF8C-699B85B7AD95@wincent.com> <20071003104943.GA3017@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710031550490.28395@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	Miles Bader <miles@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id73V-0002Nn-Jq
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 18:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828AbXJCQ02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 12:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753447AbXJCQ02
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 12:26:28 -0400
Received: from wincent.com ([72.3.236.74]:47902 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543AbXJCQ01 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 12:26:27 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l93GQ33i023252;
	Wed, 3 Oct 2007 11:26:04 -0500
In-Reply-To: <Pine.LNX.4.64.0710031550490.28395@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59855>

El 3/10/2007, a las 17:27, Johannes Schindelin escribi=F3:

> On Wed, 3 Oct 2007, Karl Hasselstr=F6m wrote:
>
>>   2. "push all branches" is the default, but the user intended to =20
>> push
>>      only the current branch. She ends up pushing a superset of what
>>      she wanted, which is not easily fixed if she can't be sure that
>>      no one else has pulled from the public repo before she notices
>>      what's happened.
>
> But that is not the default.  Not at all.
>
> The default is to push the refs which the remote and the local side =20
> have
> _in common_.

Yes, that's already been covered in this thread, probably in the =20
first or second post, and (at least I hope) we've all read it and =20
take it as given.

Replace "push all branches" with "push all refs that both sides have =20
in common", which is presumably what Karl meant, and the concerns are =20
still there.

> Maybe we should initialise the "remote.origin.push" variable to
> "completely-bogus-branchname" when you "git init --im-a-newbie"?

How is this comment supposed to help in any way? Please try to think =20
about the image you're putting across; as an relatively active and =20
prominent contributer in the Git community you are part of the "face" =20
of the community.

Cheers,
Wincent
