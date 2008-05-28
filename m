From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 11:46:24 +0200
Message-ID: <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 11:49:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1IGt-0004XH-Ex
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 11:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbYE1Jrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 05:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbYE1Jrr
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 05:47:47 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:54537 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbYE1Jrq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 05:47:46 -0400
Received: from cuzco.lan (156.pool85-53-26.dynamic.orange.es [85.53.26.156])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4S9kPTf028998
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 28 May 2008 05:46:27 -0400
In-Reply-To: <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83085>

El 28/5/2008, a las 8:12, Junio C Hamano escribi=F3:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> As this commit is part of the published master branch, I am not sure
>> the correct resolution: leaving this commit in place means that any
>> commit between it and a commit fixing this will always cause an erro=
r
>> on Cygwin / Windows. Of course, it *is* on the published master =20
>> branch.
>
> Some broken filesystems may not be capable of checking out and using
> project files.  Too bad.
>
> It's not a big deal.  It is not limited to this project.  We just =20
> fix them
> or work them around and move on.
>
> Perhaps we should remove the infamous gitweb/test/M=E4rchen file whil=
e =20
> we
> are at it?  I do not think the file is ever used.

I for one would love to see it go, seeing as I live in the ghetto that =
=20
is HFS+ and am constantly annoyed by it cluttering up my status output =
=20
with spurious content.

I understand that the reason it lives in the tree is precisely to =20
discover problems with such filesystems, but the problem is well and =20
truly discovered by now and I'd much rather see this kind of thing =20
tested from within the test suite rather than every time I do "git =20
status" or "git checkout".

Cheers,
Wincent
