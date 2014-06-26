From: Alan Franzoni <mailing@franzoni.eu>
Subject: [PATCH] Fix: wrong offset for CET timezone
Date: Thu, 26 Jun 2014 15:53:32 +0200
Message-ID: <1403790812-29174-1-git-send-email-mailing@franzoni.eu>
Cc: Alan Franzoni <username@franzoni.eu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 15:54:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0A7x-0006BO-FS
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 15:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbaFZNyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 09:54:08 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51159 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaFZNyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 09:54:07 -0400
Received: by mail-wi0-f178.google.com with SMTP id n15so1071769wiw.17
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 06:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+mJJN+nlBEvYs35NfNuonU7tqNdDDneBBz0LhMpaDbo=;
        b=SUqmTkv5ezwzXdaSsigO8iFVcUkvw8wx8gZW45qLkzSPGo+GLSOEF80wuzUuD5yPXd
         zVwKnINZ+a5t7z/cEy8gwrGShwHNUvgKA/yi+5Roe+Dh8Nulbb+dS15XGnwT1BRujjCW
         NRYUNOvztItbXUoHZrMStH09ww8XBgaPQwJ+kYZFVw/ocA2jrJa+3lYwkvptje/y0oNf
         dqzMlICdKnXr1bsYuygIxsX3NiE/TbBo3Q8HIjJAVrVwTQkZPdHSfzjsRrHN0dHaGqil
         Kf9GvuK8PUHnmUoy0AMfv0s61zbQJZSa+Kx7/DgaPftqXlvgnY8HwUBGfEjNwtbtllAk
         L3LA==
X-Gm-Message-State: ALoCoQlDYKTPfqWZg9WtbA6lCquoPwO7AGYqhCgxDYM/APG5cxJ6wU/Yt8xrCCQEY49K7tXaXr/O
X-Received: by 10.180.105.68 with SMTP id gk4mr4555594wib.24.1403790839319;
        Thu, 26 Jun 2014 06:53:59 -0700 (PDT)
Received: from afrastation.intranet ([195.14.103.53])
        by mx.google.com with ESMTPSA id o3sm66138175wiz.24.2014.06.26.06.53.57
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 06:53:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252500>

From: Alan Franzoni <username@franzoni.eu>

Signed-off-by: Alan Franzoni <username@franzoni.eu>
---
 Documentation/date-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index ccd1fc8..284308a 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -11,7 +11,7 @@ Git internal format::
 	It is `<unix timestamp> <time zone offset>`, where `<unix
 	timestamp>` is the number of seconds since the UNIX epoch.
 	`<time zone offset>` is a positive or negative offset from UTC.
-	For example CET (which is 2 hours ahead UTC) is `+0200`.
+	For example CET (which is 1 hour ahead UTC) is `+0100`.
 
 RFC 2822::
 	The standard email format as described by RFC 2822, for example
-- 
2.0.0
