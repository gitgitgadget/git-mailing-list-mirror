From: James <jtp@nc.rr.com>
Subject: Re: git push refspec problem
Date: Wed, 7 Nov 2007 10:23:27 -0500
Message-ID: <EA230407-45F1-4F7E-8415-A43ECF940856@nc.rr.com>
References: <7B37E361-9606-447C-B853-001182688AFA@nc.rr.com> <Pine.LNX.4.64.0711071510480.4362@racer.site> <20071107152003.GL18057@artemis.corp>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:23:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipmkq-0000f6-Ah
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbXKGPXa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Nov 2007 10:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbXKGPX3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:23:29 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:42812 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbXKGPX3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Nov 2007 10:23:29 -0500
Received: from [192.168.1.252] (really [75.182.108.180])
          by cdptpa-omta02.mail.rr.com with ESMTP
          id <20071107152328.UXCU26419.cdptpa-omta02.mail.rr.com@[192.168.1.252]>;
          Wed, 7 Nov 2007 15:23:28 +0000
In-Reply-To: <20071107152003.GL18057@artemis.corp>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63823>

On Nov 7, 2007, at 10:20 AM, Pierre Habouzit wrote:

> On Wed, Nov 07, 2007 at 03:11:46PM +0000, Johannes Schindelin wrote:
>> Hi,
>>
>> On Wed, 7 Nov 2007, James wrote:
>>
>>>       fetch =3D +refs/heads/*:refs/remotes/origin/*
>>
>> This is a refspec.
>>
>>>       push =3D ssh://james@my.server.com/home/james/scm/git/project=
=2Egit/
>>
>> This is a URL.  It does not specify any refs.  But "push =3D" expect=
s =20
>> a URL.
>>
>> You probably want to setup a different remote if you want to push =20
>> to a
>> different URL than you are fetching from.
>
>  Oh, there is no way to pull through git:// and push to ssh://
> perfectly knowint it's the same physical repository so that the fetch
> doesn't have the ssh-handhshake-overhead ?


There has to be *some* way of pulling through git and pushing through =20
ssh with a simple "git push".  :-P  I'm doing it manually, after all.  =
=20
I could have sworn I've read how to do its somewhere but have since =20
forgotten.


> --=20
> =B7O=B7  Pierre Habouzit
> =B7=B7O                                                madcoder@debia=
n.org
> OOO                                                http://www.madism.=
org
