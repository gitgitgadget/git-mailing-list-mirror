From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Sun, 26 Dec 2010 11:46:35 +0100
Message-ID: <201012261146.35961.trast@student.ethz.ch>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Dec 26 11:46:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWo7f-00062A-B0
	for gcvg-git-2@lo.gmane.org; Sun, 26 Dec 2010 11:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794Ab0LZKqi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Dec 2010 05:46:38 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:5430 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735Ab0LZKqh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Dec 2010 05:46:37 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 26 Dec
 2010 11:46:35 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 26 Dec
 2010 11:46:36 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc6-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164187>

Junio C Hamano wrote:
> * yd/dir-rename (2010-10-29) 5 commits
>  - Allow hiding renames of individual files involved in a directory r=
ename.
>  - Unified diff output format for bulk moves.
>  - Add testcases for the --detect-bulk-moves diffcore flag.
>  - Raw diff output format for bulk moves.
>  - Introduce bulk-move detection in diffcore.
>=20
> Need to re-queue the reroll.

This BTW does not even compile on OS X because of its use of memrchr.

(I recently set up a Darwin 10.5 smoke tester that reports to =C6var's
site.)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
