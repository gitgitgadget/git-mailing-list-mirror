From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH 2/4] [trivial] Fix typo in Documentation
Date: Wed, 13 Nov 2013 00:17:43 +0900
Message-ID: <1384269465-23352-2-git-send-email-standby24x7@gmail.com>
References: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
Cc: Masanari Iida <standby24x7@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 16:19:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgFke-0003pO-Da
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 16:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab3KLPS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 10:18:57 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:64827 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab3KLPSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 10:18:16 -0500
Received: by mail-pb0-f48.google.com with SMTP id mc17so4739955pbc.21
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 07:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UUNzq8+n6xaBRc1oaSbPxB6W42fgHXfH/0KJ6PvEMKg=;
        b=GLG2JRWTokUvJ92lq0/fAncMkQotO3K2BAd4WXZ7hRkZpDGzSTWrXSP0y2Cja5X6Sb
         J+gBq0eo5TSWmtm0alYuJE7pU865/95IPgkiqr2uKwRnBjLriStBCCn9KBgC+YiwPxfm
         p1S+rUwVfrQOupWSL+5Iy1fJMUrJyvMcO9KQIXgD1Cci4+CDKzdUUfKjeidU1YrAbeEw
         c3LlpVhkoD6saa/joXybbqBUTn8+pLUbQqj6Mpf8UzbzLGR2iq0dEbZrL1t0frhGl9GQ
         NmXkTScgY3moPwlFi9e6fzQYqkX+BKr80LU0ooHq0bafBLdo3lkXVsNHeJ7/1YzGScMj
         7X1A==
X-Received: by 10.66.193.66 with SMTP id hm2mr37284134pac.122.1384269495957;
        Tue, 12 Nov 2013 07:18:15 -0800 (PST)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by mx.google.com with ESMTPSA id pu5sm44588842pac.21.2013.11.12.07.18.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 07:18:13 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
	id D806A62800; Wed, 13 Nov 2013 00:18:09 +0900 (JST)
X-Mailer: git-send-email 1.8.5.rc1.17.g0ecd94d
In-Reply-To: <1384269465-23352-1-git-send-email-standby24x7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237715>

Correct spelling typo in Documentation

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/technical/http-protocol.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index caf941a..d21d77d 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -307,7 +307,7 @@ Clients MUST first perform ref discovery with
    S: ....ACK %s, continue
    S: ....NAK
 
-Clients MUST NOT reuse or revalidate a cached reponse.
+Clients MUST NOT reuse or revalidate a cached response.
 Servers MUST include sufficient Cache-Control headers
 to prevent caching of the response.
 
@@ -468,7 +468,7 @@ Clients MUST first perform ref discovery with
    S:
    S: ....
 
-Clients MUST NOT reuse or revalidate a cached reponse.
+Clients MUST NOT reuse or revalidate a cached response.
 Servers MUST include sufficient Cache-Control headers
 to prevent caching of the response.
 
-- 
1.8.5.rc1.17.g0ecd94d
