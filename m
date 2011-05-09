From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH v3 1/6] grep: Fix a typo in a comment
Date: Mon,  9 May 2011 23:52:03 +0200
Message-ID: <1304977928-7142-2-git-send-email-michal.kiedrowicz@gmail.com>
References: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 23:53:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYO6-0000Ry-0J
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 23:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755218Ab1EIVwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2011 17:52:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62598 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab1EIVwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 17:52:37 -0400
Received: by wya21 with SMTP id 21so4231859wya.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 14:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=8cYWHTxhwpell5EI61wuEEWh2CHT7qtGnqnFEhXgh/E=;
        b=AhEBWs2AHrTYzwVmsPKulvFsLKJtvU47hWP+91bYS8jdehqkk9+i2yJ/URIul2HZrw
         eFf1eZvvfcPMkwtmDLIXhR8qvkNEbB04HDJTgcX4vXtoAyKSxSovBquQwJ1h90ARO1Vi
         VVccvyKJvnWZDe9yJR+lPTFrwYLcFEGo6uQZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=L5S4XqBn8DrCQUSSKB2Hza589gHHGhHizzUjEMazOQk6SF1YX9XKMVO1FLbofXz5F9
         ldIE9fVnOJF23+V5l2O/8KSHhMx+PGWcyqOYsqEgFy3ETWiq45ODPyYUGcGXl2j7QrJU
         Uoz6Y9oLDa46b1nc/FPyQ7NbrRVSc2NoZHUI8=
Received: by 10.216.145.195 with SMTP id p45mr801519wej.61.1304977956513;
        Mon, 09 May 2011 14:52:36 -0700 (PDT)
Received: from localhost (85-177-78-94.net.stream.pl [94.78.177.85])
        by mx.google.com with ESMTPS id n2sm3239081wej.22.2011.05.09.14.52.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 14:52:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1304977928-7142-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173262>


Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 grep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index d67baf9..250462e 100644
--- a/grep.c
+++ b/grep.c
@@ -898,7 +898,7 @@ static int grep_buffer_1(struct grep_opt *opt, cons=
t char *name,
 		int hit;
=20
 		/*
-		 * look_ahead() skips quicly to the line that possibly
+		 * look_ahead() skips quickly to the line that possibly
 		 * has the next hit; don't call it if we need to do
 		 * something more than just skipping the current line
 		 * in response to an unmatch for the current line.  E.g.
--=20
1.7.3.4
