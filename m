From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/5] Documentation: correct typo in example for querying attributes
Date: Mon, 16 May 2016 11:05:36 -0700
Message-ID: <20160516180539.4114-3-sbeller@google.com>
References: <20160516180539.4114-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon May 16 20:06:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MuV-0005og-ST
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 20:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbcEPSGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 14:06:20 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33777 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbcEPSGT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 14:06:19 -0400
Received: by mail-pf0-f182.google.com with SMTP id 206so70299400pfu.0
        for <git@vger.kernel.org>; Mon, 16 May 2016 11:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wefqfG604WAgL1tB6TAbzUDpjPOJahtaqssOISnrkVc=;
        b=llPAPqLlnfCpwNYEGuzDLAE3agiKCyqL8ExT9/DgIOtmLM6tBd3js8zPmabcl3JcTJ
         DfGF14pZKKGLN1lBfw1yMld5kt/w0f2E27FPD/7MnOaTbC1VOysw4qNempBpm0aF4bCx
         8kXqA392D5y/mQi8pphIwvtZQNTS6rtAVrtvTWuyGvAG71w6Ne4pDuYuDIlrM4BP/nvY
         POedsOqlJwEsteHuApSS47gQQFTl/ZiRUDqdP7Q1JSvF46h2goX9X4GeTJT0BwuNlb+3
         pt3sBqHO+wgLW5JilfrZF3+ZbloOj3RbbgJMDgzen6T4SOFdYkJXSL0w2k9x1d3CiliV
         7MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wefqfG604WAgL1tB6TAbzUDpjPOJahtaqssOISnrkVc=;
        b=F2BqlDQCEKTXNeRhNyyLxbU8PiPQs5aBx8wAToaOjhYxj2DKg1+zIqoI3awVsSrLu2
         HJrTscwdyCo2lwRJMWM0QDuk0gQXP4zgEGiqbkqRBIgrQDd65LaJDTfNrL5NNa/YUgBx
         aCG6MqWxFRfFe1KWMwNvjZx9zsQJYGhOoEiSGdKGyxWQ51Mr7fLpJIcuoQy2LN2aS/4V
         HFGf/5Iwc1Rq60vBN7lDmt0h6OOSp/S6ctmh4fWN7zCoRQVaMt6UO0gnJdHVJnU8CwDW
         YPeFujleLrJLyciaTO1RNFP/e/ab75U66RaHXvrQ526D70wODEH0KGRtMH2sooKOgLYK
         35gg==
X-Gm-Message-State: AOPr4FU0jLdF4A+BQVJ3cqDE01ryPMzlfnKyXFa6mA1uTBLU00bzI+HjaPP8c/3TX5glhh4B
X-Received: by 10.98.78.132 with SMTP id c126mr47033448pfb.129.1463421945404;
        Mon, 16 May 2016 11:05:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d9b2:8bac:9e16:6023])
        by smtp.gmail.com with ESMTPSA id x64sm48778896pfx.95.2016.05.16.11.05.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 16 May 2016 11:05:44 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.401.gb49ffe6.dirty
In-Reply-To: <20160516180539.4114-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294772>

The introductory text of the example has a typo in the
specification which makes it harder to follow that example.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/technical/api-gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 2602668..36fc9af 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -61,7 +61,7 @@ Querying Specific Attributes
 Example
 -------
 
-To see how attributes "crlf" and "indent" are set for different paths.
+To see how attributes "crlf" and "ident" are set for different paths.
 
 . Prepare an array of `struct git_attr_check` with two elements (because
   we are checking two attributes).  Initialize their `attr` member with
-- 
2.8.2.401.gb49ffe6.dirty
