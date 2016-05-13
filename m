From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation: fix a typo
Date: Thu, 12 May 2016 17:20:29 -0700
Message-ID: <20160513002029.7834-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 13 02:20:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b10qT-0007yY-5u
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 02:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbcEMAUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 20:20:35 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:32934 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbcEMAUe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 20:20:34 -0400
Received: by mail-pf0-f172.google.com with SMTP id 206so36096791pfu.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 17:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=9WrQgnnRAv99VI/DuB5vHggLgQN5e7x1HeWqvQjZtmI=;
        b=NDeyrGqm1QbP9IzG73CJiPXa6pVdh+XERBv26kym5TEWZiZqc5AATNZ7ixz4pa6OT1
         j/qwvfiJMZ+RuQTrBM1hZgFwi+cBAyFOpXlV7tM4G99dSoQilwNHftcJMcdXLTTl1ZFj
         i/Ew8K3GzBiHtteCXgVjI9iptk/+0BQBOhZFcv0Sc46XR4lIXx2HPqdacxf0T6ZsARim
         RisTvQk3MWqQ91k5ozM2mYOJtzZ6FnZG//FCF3KVKRM7AItaR5GcRxIhG4uhvbpOywrp
         c72qJs1daw1oz/oNfWyPstimCH0qvqL7w5KKCWDfg26eNCGHQY9x0E9+34Viv0/st+16
         0n0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9WrQgnnRAv99VI/DuB5vHggLgQN5e7x1HeWqvQjZtmI=;
        b=R8K4lWk7KQ/6dLl1hK3mN489uFOfAlBiSP1tIm9HHda358HA1QexZFyD4XyreZ45Ez
         5mtMipPXGDv9MkDLBOszo59qO98Z4MgbGsG6vAot+lTgOCQ3aqnhJO6ACpb0vTgjR/0m
         7pq8E4OkOePqcWoaQjP/0Hi74zKWS5j4pPPXfDyatPbMiukkO+JFVFggZjrFvUrK/KbL
         GRLZKDFi52UkJ62+t6H+XABrIYveo3JBZr3xbJY+lVNhYr8ZlwqYMTDokDi3kDc4JWWc
         CqvsyZ8cyizjgGL4z1hhpFqm6aEUYaQTh54CEcJbTmcechx3gfUlyeTbg035mW5H53gV
         UeLA==
X-Gm-Message-State: AOPr4FW+2mzdbrKT9GNgHsQEnEjj7Iw8odfH3N/96UjfGXacXqxRmoBg+UIpQhKKwfAu3EHj
X-Received: by 10.98.17.153 with SMTP id 25mr18180842pfr.105.1463098833461;
        Thu, 12 May 2016 17:20:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c9fc:8b37:8cb7:4400])
        by smtp.gmail.com with ESMTPSA id s23sm22451156pfj.86.2016.05.12.17.20.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 May 2016 17:20:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.400.g8bfb85c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294497>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index e3b1de8..af2c682 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -86,7 +86,7 @@ is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
-Sometimes you would need to override an setting of an attribute
+Sometimes you would need to override a setting of an attribute
 for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
-- 
2.8.2.400.g8bfb85c.dirty
