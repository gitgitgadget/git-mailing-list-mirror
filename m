From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now incompatible with Cygwin (and probably Windows)
Date: Sat, 31 May 2008 19:37:48 +0200
Message-ID: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de>
References: <483AC2CE.7090801@gmail.com> <7vy75vvtxo.fsf@gitster.siamese.dyndns.org> <100A0CFD-EB6F-48F1-B917-811310CCFB6E@wincent.com> <alpine.DEB.1.00.0805291422210.13507@racer.site.net> <29FDE86E-5B83-4736-8CC6-9C5697B91B2C@wincent.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat May 31 19:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2V2N-0001dD-Sd
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 19:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbYEaRhq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 May 2008 13:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYEaRhq
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 13:37:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:58364 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbYEaRhp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 May 2008 13:37:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m4VHbJEa016970;
	Sat, 31 May 2008 19:37:24 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db83e93.pool.einsundeins.de [77.184.62.147])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m4VHbEtM007909
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 31 May 2008 19:37:18 +0200 (MEST)
In-Reply-To: <29FDE86E-5B83-4736-8CC6-9C5697B91B2C@wincent.com>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83396>


On May 29, 2008, at 4:58 PM, Wincent Colaiuta wrote:

> El 29/5/2008, a las 15:22, Johannes Schindelin escribi=F3:
>>
>>
>> On Wed, 28 May 2008, Wincent Colaiuta wrote:
>>
>>> El 28/5/2008, a las 8:12, Junio C Hamano escribi=F3:
>>>
>>>> Perhaps we should remove the infamous gitweb/test/M=E4rchen file =20
>>>> while we
>>>> are at it?  I do not think the file is ever used.
>>>
>>> I for one would love to see it go, seeing as I live in the ghetto =20
>>> that
>>> is HFS+ and am constantly annoyed by it cluttering up my status =20
>>> output
>>> with spurious content.
>>>
>>> I understand that the reason it lives in the tree is precisely to
>>> discover problems with such filesystems, but the problem is well an=
d
>>> truly discovered by now and I'd much rather see this kind of thing
>>> tested from within the test suite rather than every time I do "git
>>> status" or "git checkout".
>>
>> Probably you are not enoyed enough to just go and fix it.
>

[...]

>
> If the powers that be will accept a change that removes M=E4rchen I'l=
l =20
> be more than happy to whip up a patch.


Unicode normalization is tested in t/t0050-filesystem.sh, which
reports on HFS+:

*   still broken 8: rename (silent unicode normalization)
*   still broken 9: merge (silent unicode normalization)

I believe there is no value in keeping gitweb/test/M=E4rchen for the
reason of testing HFS+, so I vote for removing it, unless there
is another good reason for keeping it.

	Steffen
