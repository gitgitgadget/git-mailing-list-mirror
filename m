From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2 2/3] Documentation: config: improve word ordering for http.cookieFile
Date: Wed,  4 May 2016 11:42:14 -0700
Message-ID: <1462387335-57937-2-git-send-email-computersforpeace@gmail.com>
References: <1462387335-57937-1-git-send-email-computersforpeace@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Brian Norris <computersforpeace@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 20:42:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay1lA-0000qE-LM
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 20:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbcEDSmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 14:42:53 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33281 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbcEDSmv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 14:42:51 -0400
Received: by mail-pf0-f180.google.com with SMTP id 206so28339411pfu.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zu0UVA/XKi7JqJeYWwrqrR/9BixG2z3wLWQfYWnxIkQ=;
        b=jcpjDbP9NDQJm5DXN3xPpGhKMakofrJ1eGBqTSXmmvgPEqbFgJrIS5b9uribg480kr
         /bPlZzPubFQOLzrTnObSN4DuuX4v7PrF92WhakjcXmvKeGJjMZknVOFwnCZil6aJzQvg
         AajQaELaBPovnnauCbjv1oBr6RJQMLeFU6fCMLHUaRqygpe+g9zyo+RW4H+456WNlM4L
         m4UoJxQcWZJMBs0y5zhtY7FDyR8B3RLINpguxdNEL+SCln4weY9eHBNk1gydQdMvjxFJ
         4o7RWjSsFWbzBWE81uwSFbmCjmm9IWDy6pp6pw6evonj05PMS42wJOwlwpW2xyVcuFye
         4AYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zu0UVA/XKi7JqJeYWwrqrR/9BixG2z3wLWQfYWnxIkQ=;
        b=anM8LJcIHlgOg9vzXCCwL1ahSpFmY9nY3548OQe0Oqg4hC2AkF6b8oMi4amPGrO4LR
         hxvoZFpijkuDAlXZRVF6iB+t2bJ9d5Tb5IRbDxYPxWtF+DrZE6OSf8Fal8+7pg+K61Tp
         sdIwVzMtNAGc/tZY9AGXOt3JWpNDwmgXCpMsoz43QKdKc5of5pDfV78+C30sEXPYn0yd
         PmtbdiLQaLuM2MaFPqmLDA49NyAI78L3sr7+ZOpQMbAOTqz+dO8erwtF/ePzvTf8hyCp
         RrljBx+GucrslcutMUR1KP8pQQwSGs0sg5sAahO+gX07LTfdsyFwR4d+m7VpHyaj0OPi
         jHjg==
X-Gm-Message-State: AOPr4FU1CZx2QA4qc0BHomT57LgbF2/9jmPZ9Fkhfda9nQO/kurPYZF1Q2PSovxougGldA==
X-Received: by 10.98.87.220 with SMTP id i89mr14018461pfj.107.1462387370517;
        Wed, 04 May 2016 11:42:50 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([172.22.64.120])
        by smtp.gmail.com with ESMTPSA id k78sm7785955pfk.70.2016.05.04.11.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 May 2016 11:42:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1462387335-57937-1-git-send-email-computersforpeace@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293562>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
v2: no change

 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7264abf7f85e..e655b9729a7d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1668,7 +1668,7 @@ http.cookieFile::
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
-	NOTE that the file specified with http.cookieFile is only used as
+	NOTE that the file specified with http.cookieFile is used only as
 	input unless http.saveCookies is set.
 
 http.saveCookies::
-- 
2.8.0.rc3.226.g39d4020
