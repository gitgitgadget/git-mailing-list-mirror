From: Brian Foster <brian.foster@maxim-ic.com>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Tue, 24 Jan 2012 09:16:15 +0100
Message-ID: <201201240916.15630.brian.foster@maxim-ic.com>
References: <201201201433.30267.brian.foster@maxim-ic.com> <201201231020.04041.brian.foster@maxim-ic.com> <7vk44i9z99.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 09:17:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpbZ5-00034q-52
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 09:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab2AXIRJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 03:17:09 -0500
Received: from antispam02.maxim-ic.com ([205.153.101.183]:36372 "EHLO
	antispam02.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab2AXIRI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2012 03:17:08 -0500
X-ASG-Debug-ID: 1327393001-02256b3e03466b70005-QuoKaX
Received: from maxdalex01.maxim-ic.internal (maxdalex01.maxim-ic.internal [10.16.15.101]) by antispam02.maxim-ic.com with ESMTP id X8WAHxKDuszFeY6i; Tue, 24 Jan 2012 02:16:53 -0600 (CST)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex01.maxim-ic.internal (10.16.15.101) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Tue, 24 Jan 2012 02:16:44 -0600
Received: from bfoster-57.localnet (10.201.0.19) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Tue, 24 Jan 2012 00:16:43 -0800
X-ASG-Orig-Subj: Re: [Q] Determing if a commit is reachable from the HEAD ?
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vk44i9z99.fsf@alter.siamese.dyndns.org>
X-Barracuda-Connect: maxdalex01.maxim-ic.internal[10.16.15.101]
X-Barracuda-Start-Time: 1327393013
X-Barracuda-URL: http://192.168.10.183:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.86538
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189041>

On Monday 23 January 2012 17:09:38 Junio C Hamano wrote:
> Brian Foster <brian.foster@maxim-ic.com> writes:
> >  I am probably misunderstanding =E2=80=98--quiet=E2=80=99, which th=
e
> >  man page cryptically describes as =E2=80=9C... allow the
> >  caller to test the exit status to see if a range
> >  of objects is fully connected (or not).=E2=80=9D  What is
> >  meant here by =E2=80=9Cfully connected=E2=80=9D ?
>=20
> If the real history looks like this:
>=20
>  ---Y---x---HEAD
>=20
> i.e. the commit at HEAD says "parent x" in it, and your lacks "x"
> for whatever reason, Y..HEAD is not fully connected.

Junio, and my _what_ lacks "x"?  Sorry, it looks like
 you typo'ed, but I cannot decipher what you meant.

cheers!
	-blf-
--=20
Brian Foster
Principal MTS, Software        |  La Ciotat, France
Maxim Integrated Products      |  Web:  http://www.maxim-ic.com/
