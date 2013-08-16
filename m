From: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
Subject: [PATCH] CET is only one hour ahead of UTC, it even says so in date.c
Date: Fri, 16 Aug 2013 12:43:20 +0200
Message-ID: <1376649800-442-1-git-send-email-maandree@operamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Mattias=20Andr=C3=A9e?= <maandree@operamail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 12:43:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAHVO-0004HA-1v
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 12:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743Ab3HPKng convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 06:43:36 -0400
Received: from smtp-4.sys.kth.se ([130.237.48.193]:53689 "EHLO
	smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab3HPKnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 06:43:35 -0400
Received: from mailscan-1.sys.kth.se (mailscan-1.sys.kth.se [130.237.32.91])
	by smtp-4.sys.kth.se (Postfix) with ESMTP id 4789F2009;
	Fri, 16 Aug 2013 12:43:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at kth.se
Received: from smtp-4.sys.kth.se ([130.237.48.193])
	by mailscan-1.sys.kth.se (mailscan-1.sys.kth.se [130.237.32.91]) (amavisd-new, port 10024)
	with LMTP id 7P2RxuMko1iA; Fri, 16 Aug 2013 12:43:33 +0200 (CEST)
X-KTH-Auth: maandree [193.150.208.92]
X-KTH-mail-from: maandree@member.fsf.org
Received: from localhost.localdomain (c193-150-208-92.bredband.comhem.se [193.150.208.92])
	by smtp-4.sys.kth.se (Postfix) with ESMTPSA id E6EB12007;
	Fri, 16 Aug 2013 12:43:28 +0200 (CEST)
X-Mailer: git-send-email 1.8.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232416>

Signed-off-by: Mattias Andr=C3=A9e <maandree@operamail.com>
---
 Documentation/date-formats.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-format=
s.txt
index c000f08..4dbaafa 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -11,11 +11,11 @@ Git internal format::
 	It is `<unix timestamp> <timezone offset>`, where `<unix
 	timestamp>` is the number of seconds since the UNIX epoch.
 	`<timezone offset>` is a positive or negative offset from UTC.
-	For example CET (which is 2 hours ahead UTC) is `+0200`.
+	For example CET (which is 1 hour ahead UTC) is `+0100`.
=20
 RFC 2822::
 	The standard email format as described by RFC 2822, for example
-	`Thu, 07 Apr 2005 22:13:13 +0200`.
+	`Thu, 07 Apr 2005 22:13:13 +0100`.
=20
 ISO 8601::
 	Time and date specified by the ISO 8601 standard, for example
--=20
1.8.3.4
