From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Thu, 29 May 2008 16:58:21 +0200
Message-ID: <29FDE86E-5B83-4736-8CC6-9C5697B91B2C@wincent.com>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com> <alpine.DEB.1.00.0805291422210.13507@racer.site.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 17:07:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1jcQ-0005rC-Sp
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 17:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbYE2O7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 May 2008 10:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbYE2O7v
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 10:59:51 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:51470 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbYE2O7v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2008 10:59:51 -0400
Received: from cuzco.lan (157.pool85-53-24.dynamic.orange.es [85.53.24.157])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4TEwO1D004736
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 29 May 2008 10:58:27 -0400
In-Reply-To: <alpine.DEB.1.00.0805291422210.13507@racer.site.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83208>

El 29/5/2008, a las 15:22, Johannes Schindelin escribi=F3:
> Hi,
>
> On Wed, 28 May 2008, Wincent Colaiuta wrote:
>
>> El 28/5/2008, a las 8:12, Junio C Hamano escribi=F3:
>>
>>> Perhaps we should remove the infamous gitweb/test/M=E4rchen file =20
>>> while we
>>> are at it?  I do not think the file is ever used.
>>
>> I for one would love to see it go, seeing as I live in the ghetto =20
>> that
>> is HFS+ and am constantly annoyed by it cluttering up my status =20
>> output
>> with spurious content.
>>
>> I understand that the reason it lives in the tree is precisely to
>> discover problems with such filesystems, but the problem is well and
>> truly discovered by now and I'd much rather see this kind of thing
>> tested from within the test suite rather than every time I do "git
>> status" or "git checkout".
>
> Probably you are not enoyed enough to just go and fix it.

No, that's not actually the case. In reality I was pleasantly =20
surprised when Junio commented that "perhaps we should remove" that =20
file; I had always gotten the impression from this list that such a =20
change would be unwelcome because it's easier to just blame the users =20
of bad filesystems for choosing those filesystems. I also remember a =20
comment from Linus to the effect that that file was kept in the tree =20
precisely _because_ it helped us discover such file systems. =20
Unfortunately I can't find that message right now but I think it was =20
about 6 months ago.

If the powers that be will accept a change that removes M=E4rchen I'll =
=20
be more than happy to whip up a patch.

Wincent
