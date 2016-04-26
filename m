From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/15] submodule doc: write down what we want to achieve in this series
Date: Tue, 26 Apr 2016 13:50:20 -0700
Message-ID: <1461703833-10350-3-git-send-email-sbeller@google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:51:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wi-0006WI-R8
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697AbcDZUut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:50:49 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35752 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcDZUur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id n1so12600367pfn.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=epSgxEk1TbfWSH15W1f7/TPo9Mnq+UYHtJqUgUEx4bU=;
        b=DTtrn/qTVYf3U7W9gtGxxKg3xEN6RRAS6Ns2FOMFoNae+vXqPRqjgGij4fEhswtUXY
         c2dqhW2QDkdxiuO95pPtA7NT1hdoJEy4l91zHpvM+fM1fBqafKHUUp2cWvbuhZ1qLVYk
         5U4QuryUwtpQfy+WPYCvwWtqWfdHzHLWWd3m0tK4TrutRmsrVB9KtNltbmvo+6O1aBcF
         HalUc1a9IWaMYg8Hvi4cZMg6PUYD/+BcpI+VWSwwLKrJ1KI9GGSU1JnK2ybib+IT+WhR
         iZTIAfoN+ivghyt/koEtw/94DpexkaVzaZjq8Oi04LbI2SLwARJ4do5nkTtaXkbJi+JN
         J/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=epSgxEk1TbfWSH15W1f7/TPo9Mnq+UYHtJqUgUEx4bU=;
        b=fUf+Ng6NXF2bJMf8C2DteVtuw2MujdPkWxVEaWn3V9/2IbYcO0bwoXlMJJK9HU3YeM
         pp6KE/weTVuWVyPb5lKJYbwQsbQtOjmFQGwzYs0gU+iio4WsnqqKmkFvDYeXJx5f9sFO
         rOo+ylnqfjebtXK5k+QiIZ+LuLbryO9ieSf4PpiYzEL2CKRiYH1ngl4Pas0o17YYGyes
         CE6uBNaBLCeRHhstysy7eFI5eIY7FVF0OKkc0WYPK1cGnwglJFF+PyftGdVLRx3vldcz
         jFShJQxFhQCuNuy+So/QDvH7CZzJi4ZFT14IBP7mT6hNDhmPVdzmEwLQyO2FZbnlNkRk
         HAYw==
X-Gm-Message-State: AOPr4FXzwf2RYZWEoDyz+c2Gklg+z9duEhJP2un/xQNCNQ84vvoIuRfxPQvRPcCebYTvP4qm
X-Received: by 10.98.64.144 with SMTP id f16mr6483405pfd.159.1461703846216;
        Tue, 26 Apr 2016 13:50:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id v189sm449286pfb.85.2016.04.26.13.50.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:45 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292668>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/config.txt        | 4 ++++
 Documentation/git-submodule.txt | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 59d7046..c5b6a4e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2735,6 +2735,10 @@ submodule.fetchJobs::
 	in parallel. A value of 0 will give some reasonable default.
 	If unset, it defaults to 1.
 
+submodule.defaultGroup::
+	Specifies the group of submodules to be operated on
+	in a command if no submodules were specified in the command.
+
 tag.sort::
 	This variable controls the sort ordering of tags when displayed by
 	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 13adebf..8c4bbe2 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -37,6 +37,14 @@ these will not be checked out by default; the 'init' and 'update'
 subcommands will maintain submodules checked out and at
 appropriate revision in your working tree.
 
+When operating on submodules you can either give paths to specify the
+desired submodules or give no paths at all to apply the command to the
+default group of submodules. By default all submodules are included in
+the default group. You can change the default group by configuring
+submodule.defaultGroup. Once the default group is configured any
+submodule operation without a specified set of submodules will use
+the default group as the set to operate on.
+
 Submodules are composed from a so-called `gitlink` tree entry
 in the main repository that refers to a particular commit object
 within the inner repository that is completely separate.
-- 
2.8.0.41.g8d9aeb3
