From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 3/3] grep: disable threading in all but worktree case
Date: Wed, 7 Dec 2011 09:11:07 +0100
Message-ID: <201112070911.08079.trast@student.ethz.ch>
References: <cover.1322830368.git.trast@student.ethz.ch> <4ED8F9AE.8030605@lsrfire.ath.cx> <4EDE9BBA.2010409@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Eric Herman <eric@freesa.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Dec 07 09:11:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYCay-0007Ob-7H
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 09:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721Ab1LGILL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 03:11:11 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:10917 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab1LGILK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 03:11:10 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Dec
 2011 09:11:07 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 7 Dec
 2011 09:11:09 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4EDE9BBA.2010409@lsrfire.ath.cx>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186441>

Ren=E9 Scharfe wrote:
> Am 02.12.2011 17:15, schrieb Ren=E9 Scharfe:
> > How about adding a parameter to control the number of threads=20
> > (--threads?) instead that defaults to eight (or five) for the workt=
ree=20
> > and one for the rest? That would also make benchmarking easier.
>=20
> Like this:
>=20
> -- >8 --
> Subject: grep: add parameter --threads
>=20
> Allow the number of threads to be specified by the user.  This makes
> benchmarking the performance impact of different numbers of threads
> much easier.

Sounds good, though in the end we would also want to have a config
variable for the poor OS X users who have to tune their threads
*down*... :-)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
