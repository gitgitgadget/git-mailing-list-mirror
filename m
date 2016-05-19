From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 2/5] Documentation: fix a typo
Date: Wed, 18 May 2016 18:09:32 -0700
Message-ID: <20160519010935.27856-3-sbeller@google.com>
References: <20160519010935.27856-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu May 19 03:09:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3CTO-00057i-F6
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 03:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbcESBJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 21:09:51 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34832 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbcESBJs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 21:09:48 -0400
Received: by mail-pf0-f178.google.com with SMTP id b66so3267656pfb.2
        for <git@vger.kernel.org>; Wed, 18 May 2016 18:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GcUApF2xmV43El/52hXns6aUSTWWbGdRpxajGBeMnic=;
        b=WBiIOoj4qW+eoDuoJWZ/Pm1cnhT9yRTt4qDWIcHS4PISipyPd2B48hyIAmmHFgUNE8
         WqEad63ghHkS2zpiE9IvvUaQxcQwKNkF7zhMBmW0Ul8qFO3ZeAlg7UFp88XU4hEZF74D
         g3i+SFRM8ccYqgps8gwNOdNnKOQNqXZPFbH3z+PqVehaNAdXWcbwMFQ8rurxzq0o0mgc
         ktq/aTEy8X3RTgqI6Wp8Q2OlO+zpiwhAG7JcQhN4WpzflxBGzK6PAChUtmu5eE6mLboh
         OHE1j9E1YZWvZJhW81hT8Xl5nf2TD0cY8BBfryxeKPdB2ybOWIllHpF53tB2lKEdEU/6
         NW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GcUApF2xmV43El/52hXns6aUSTWWbGdRpxajGBeMnic=;
        b=kQNDWp5e30/VQzqHFVoJgEUWpmTK5HNpBO18jE7j09jOrIBXp4Aj394SCzR53yaYAF
         l0AZGwng//+SooJrEAAjpXU0oVWleHluoxVygRSLl0sdVRK2i56HpvFfcXwnyomkmuRw
         40ljIPHhx/e2Ks+6tWbgJOpIdJqAmWiKhb9aZx2opijjjnhhy6VMkt5c+6Dcpjodzk9/
         imdHB1LXGBHw0lrSzLs4nfuds4eG3ZFtUmhT5kZllJEbgxjhGmfLATvff8NuUhA2I1E0
         EwnNXqIBMgrD2NiUEXYZICqLcPQYGZIb93uztbCVW7gcX0DrrEh0LkUPS47HzrjYrN4x
         dVyA==
X-Gm-Message-State: AOPr4FXy6U281DuctILdzQVzFZ/4T/G6nxBma1uq+3JyfPZVrz83B4cQc1W/3k+8ieuy/f0y
X-Received: by 10.98.69.132 with SMTP id n4mr15182943pfi.53.1463620187919;
        Wed, 18 May 2016 18:09:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d468:afb3:b0f0:947e])
        by smtp.gmail.com with ESMTPSA id s124sm14986461pfb.63.2016.05.18.18.09.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 May 2016 18:09:47 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.123.g3bde101
In-Reply-To: <20160519010935.27856-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295033>

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
2.8.2.123.g3bde101
