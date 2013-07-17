From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/6] blame-options.txt: place each -L option variation on its own line
Date: Wed, 17 Jul 2013 17:25:31 -0400
Message-ID: <1374096332-7891-6-git-send-email-sunshine@sunshineco.com>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 23:26:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzZEv-0003yB-Uh
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 23:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757429Ab3GQV0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 17:26:19 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:58082 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757400Ab3GQV0N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 17:26:13 -0400
Received: by mail-oa0-f42.google.com with SMTP id j6so3289469oag.15
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 14:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Z5PBEBckMK41TbHF6SEtiNFUgsc8MOw5VJpI8OpA4NA=;
        b=k0LXy0t21ZosHTekI6XJbSSeV1L80w/JWEQnZGa3ZSHPODOgd66qtsQBWYvktDUbYk
         uqcPaEVLZMjy0nRC6qiLlET4htZlYpe1wOzkKSMy7qhPG3wK1j7iQsjztsQcS4/2Tw3k
         pwWfonbiaa+87wGg7eFVSdmAGtcgIDDU8tHkkFEZ9m77W5VkxTT9E2/rwXnp91AdzMle
         u+V5Hd5cRryJxHtZYjj5+vZUVNg1x6Igqt/puua610QxuhOVnzcSFe/K6dUTcy0OwTqu
         wln1FJeLVLg/XSpKC3f4LJ4ztSVuExcTi9MAHDzcsm94Q4d5RG0nmSkxFV8j37iJW2pZ
         8m9w==
X-Received: by 10.182.130.228 with SMTP id oh4mr4682623obb.38.1374096373302;
        Wed, 17 Jul 2013 14:26:13 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ps5sm10308187oeb.8.2013.07.17.14.26.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 14:26:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.1016.g4f0baba
In-Reply-To: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230656>

Standard practice in Git documentation is for each variation of an
option (such as: -p / --porcelain) to be placed on its own line in the
OPTIONS table. The -L option does not follow suit. It cuddles
"-L <start>,<end>" and "-L :<regex>", separated by a comma. This is
inconsistent and potentially confusing since the comma separating them
is typeset the same as the comma in "<start>,<end>". Fix this by placing
each variation on its own line.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/blame-options.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index e9f984b..624b353 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -9,7 +9,8 @@
 --show-stats::
 	Include additional statistics at the end of blame output.
 
--L <start>,<end>, -L :<regex>::
+-L <start>,<end>::
+-L :<regex>::
 	Annotate only the given line range.  <start> and <end> can take
 	one of these forms:
 
-- 
1.8.3.3.1016.g4f0baba
