From: Brian Foster <brian.foster@maxim-ic.com>
Subject: Re: [Q] Determing if a commit is reachable from the HEAD ?
Date: Tue, 24 Jan 2012 09:56:15 +0100
Message-ID: <201201240956.15624.brian.foster@maxim-ic.com>
References: <201201201433.30267.brian.foster@maxim-ic.com> <201201231020.04041.brian.foster@maxim-ic.com> <7vk44i9z99.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 09:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpcBV-0003jQ-7b
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 09:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347Ab2AXI4r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 03:56:47 -0500
Received: from antispam02.maxim-ic.com ([205.153.101.183]:39815 "EHLO
	antispam02.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755332Ab2AXI4p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2012 03:56:45 -0500
X-ASG-Debug-ID: 1327395404-02256b66101dc210001-QuoKaX
Received: from maxdalex02.maxim-ic.internal (maxdalex02.maxim-ic.internal [10.16.15.104]) by antispam02.maxim-ic.com with ESMTP id heOxzykVaNFm8Ojh; Tue, 24 Jan 2012 02:56:44 -0600 (CST)
X-Barracuda-Envelope-From: brian.foster@maxim-ic.com
Received: from maxsvlex02.maxim-ic.internal (10.32.112.18) by
 maxdalex02.maxim-ic.internal (10.16.15.104) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Tue, 24 Jan 2012 02:56:44 -0600
Received: from bfoster-57.localnet (10.201.0.19) by
 maxsvlex02.maxim-ic.internal (10.32.112.18) with Microsoft SMTP Server (TLS)
 id 8.3.192.1; Tue, 24 Jan 2012 00:56:43 -0800
X-ASG-Orig-Subj: Re: [Q] Determing if a commit is reachable from the HEAD ?
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
In-Reply-To: <7vk44i9z99.fsf@alter.siamese.dyndns.org>
X-Barracuda-Connect: maxdalex02.maxim-ic.internal[10.16.15.104]
X-Barracuda-Start-Time: 1327395404
X-Barracuda-URL: http://192.168.10.183:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at maxim-ic.com
X-Barracuda-Spam-Score: 0.12
X-Barracuda-Spam-Status: No, SCORE=0.12 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=CN_BODY_332
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.86540
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.12 CN_BODY_332            BODY: CN_BODY_332
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189043>

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
> i.e. the commit at HEAD says "parent x" in it, and your [repository]
> lacks "x" for whatever reason, Y..HEAD is not fully connected.

 Ah, Ok.  Thanks!  Then YES, I misunderstood =E2=80=98--quiet=E2=80=99.
 The man page caused me to think it was functionally
 equivalent to =E2=80=98git rev-list STUFF >/dev/null=E2=80=99.

cheers!
	-blf-

--=20
Brian Foster
Principal MTS, Software        |  La Ciotat, France
Maxim Integrated Products      |  Web:  http://www.maxim-ic.com/
