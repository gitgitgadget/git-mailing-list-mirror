From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: git-send-email
Date: Thu, 22 Feb 2007 22:13:14 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070222211313.GA23674@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 22:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKLFh-0002Ba-Uo
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 22:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbXBVVNT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 22 Feb 2007 16:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbXBVVNT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 16:13:19 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:55327 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751897AbXBVVNS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Feb 2007 16:13:18 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HKLFc-0003Wi-QK
	for git@vger.kernel.org; Thu, 22 Feb 2007 22:13:16 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l1MLDExm024418
	for <git@vger.kernel.org>; Thu, 22 Feb 2007 22:13:14 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l1MLDE3H024417
	for git@vger.kernel.org; Thu, 22 Feb 2007 22:13:14 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40393>

Hello,

again my '=F6' is an issue here, sorry J=F6h=E4nn=EBs :-)

I just tried to send out some patches with git-send-email specifying
--suppress-from.

send-email added me to Cc: anyhow.  Here come the last line of output:

	(mbox) Adding cc: =3D?utf-8?q?Uwe_Kleine-K=3DC3=3DB6nig?=3D <ukleinek@=
informatik.uni-freiburg.de> from line 'From: =3D?utf-8?q?Uwe_Kleine-K=3D=
C3=3DB6nig?=3D <ukleinek@informatik.uni-freiburg.de>'
	OK. Log says:
	Date: Thu, 22 Feb 2007 21:42:49 +0100
	Sendmail: /home/zeisberg/bin/usendmail
	From: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de>
	Subject: [PATCH] Determine system clock from PLL settings
	Cc: =3D?utf-8?q?Uwe_Kleine-K=3DC3=3DB6nig?=3D <ukleinek@informatik.uni=
-freiburg.de>
	To: cft.project.parkeon@digi.com

Probably send-email thought =3D?utf-8?q?Uwe_Kleine-K=3DC3=3DB6nig?=3D b=
eing
different from Uwe Kleine-K=F6nig?  I didn't got a Cc of the introducto=
ry
message.

Moreover for each patch the following line was added:

	From: Uwe Kleine-K=F6nig <ukleinek@informatik.uni-freiburg.de> - unquo=
ted

which should not be necessary, too.

BTW: Maybe this is related to the problem Russell King has with Perl an=
d
rfc2047:

	http://article.gmane.org/gmane.linux.ports.arm.kernel/30178/

?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

exit vi, lesson II:
: w q ! <CR>

NB: write the current file
