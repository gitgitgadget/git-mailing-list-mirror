From: "Brian O'Mahoney" <omb@khandalf.com>
Subject: Handover, Make
Date: Thu, 28 Jul 2005 01:08:03 +0200
Message-ID: <42E813D3.7020804@khandalf.com>
Reply-To: omb@bluewin.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jul 28 01:13:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dxv4u-00015G-0D
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 01:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVG0XLz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 27 Jul 2005 19:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVG0XJe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 19:09:34 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:15520 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261153AbVG0XHS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2005 19:07:18 -0400
Received: from 84-73-132-32.dclient.hispeed.ch. (84-73-132-32.dclient.hispeed.ch [84.73.132.32])
	(authenticated bits=0)
	by smtp.hispeed.ch (8.12.6/8.12.6/tornado-1.0) with ESMTP id j6RN7BKQ013329
	for <git@vger.kernel.org.>; Thu, 28 Jul 2005 01:07:11 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
    teraflex.teraflex-research.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP
    id j6RN83WT019910 for <git@vger.kernel.org>; Thu, 28 Jul 2005 01:08:03
    +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Md5-Body: ee9cd4dea243474ec3d839a107a92996
X-Transmit-Date: Thursday, 28 Jul 2005 1:8:9 +0200
X-Message-Uid: 0000b49cec9dd603000000020000000042e813d90003187d00000001000bd4ce
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@84-73-132-32.dclient.hispeed.ch.
Read-Receipt-To: omb@bluewin.ch
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on smtp-05.tornado.cablecom.ch
X-Virus-Status: Clean
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-05.tornado.cablecom.ch 32701; Body=1
	Fuz1=1 Fuz2=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

=46irst, congratulations Junio, on taking over this stuff, and all the =
best.

Second, the killer argument, in the 'Recursive Make ... harmful' is the
basic one that Recursive Makes breaks up the dependancy graph, and
almost guarentees that it is wrong unless you do a lot of work to fix
that artifact. Now git is small enough that make clean; make won't take
too long but git is also a basis for other layers, so there is good
reason to try to get it right.

--=20
mit freundlichen Gr=FC=DFen, Brian.
