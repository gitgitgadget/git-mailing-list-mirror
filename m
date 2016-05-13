From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/5] Documentation: fix a typo
Date: Fri, 13 May 2016 16:13:22 -0700
Message-ID: <20160513231326.8994-2-sbeller@google.com>
References: <20160513231326.8994-1-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, git@vger.kernel.org,
	Jens.Lehmann@web.de, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat May 14 01:13:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1MH5-00085Y-1L
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 01:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753432AbcEMXNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 19:13:35 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32955 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076AbcEMXNe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 19:13:34 -0400
Received: by mail-pa0-f53.google.com with SMTP id xk12so45331961pac.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PvdvYlazO2x9cBesB8gYu+QTxQNrYjqydocy450XjUY=;
        b=EhOuLn8MgzNkHAnjteTtW1SN2v9y0ddL3nxU3y1jMqQYP57R1I+gSjC17EBRiBw3Sb
         34OWnbS4MIaGeDIbUVavoPgWYrNUNWv3M4Dhwk2g0b6gP5edQqjsuVqp/wUWl96AQHtL
         BxDEbvLUSCaI4qhdCB2I+EicVGuFTgEi6RkPB5W8cbemqIhZSy0Jgp+ZMskRRNeGStum
         VTzdV9z3/73tddLZc/9Fe0MmFo/OpK16dMjm5PDlQiKi09QqHFSVdbxWLZ65wO77uVob
         t+Id6VdZ04jrnOAmsmx9Q0fkhCRKzLDmwFn+48wF/ghhElinWDWsQ5h351OjyXQ5yGQ4
         RRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PvdvYlazO2x9cBesB8gYu+QTxQNrYjqydocy450XjUY=;
        b=A9lVGPyC4L0Jy6mbotHbkDEcFBR6JD0la7qRM4jeUCX04Z1Vz4th+CkuRTkzPki/S7
         XrrET4wzn2OZz47+Z4Kp3Gow8YJMq3nBjO+aqc+ZL7gHliBdGOv1H21ejkQi7gOQ939T
         elegB/AXj1bJINWN441eHfxASw1g3DS40vThBovnzpmcacRKhtd7OBnramzpnke3ZvVH
         zEgdxUrytjbcDBvHEt7pc0F+J/HH+HWL6WStmCQ+2ilyk2n8f3cC+L++UI8sMlCD5V93
         0DlxOkFeSVeECPRULIIzrOr84//C5kPpCgnB4Aa3iWuWUpb5POFiDZbnozqvpAFWlZg4
         2hLA==
X-Gm-Message-State: AOPr4FXNtOLW6/xoacHmCLDymKvdMwBZTrREGh8/lnMjrhXgv6dysTfYF0r4K6ew5c01q03f
X-Received: by 10.66.52.112 with SMTP id s16mr27204493pao.35.1463181213721;
        Fri, 13 May 2016 16:13:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e84e:cb12:277e:4f09])
        by smtp.gmail.com with ESMTPSA id k77sm29836549pfb.52.2016.05.13.16.13.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 May 2016 16:13:33 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.g6647087.dirty
In-Reply-To: <20160513231326.8994-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294593>

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
2.8.2.401.g6647087.dirty
