From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 1/7] show-branch: minor style fix
Date: Fri, 23 Jan 2015 17:07:24 +0600
Message-ID: <1422011244-3900-1-git-send-email-kuleshovmail@gmail.com>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:07:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEc5R-00019H-Sw
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754848AbbAWLHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:07:34 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:55577 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbAWLHc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:07:32 -0500
Received: by mail-lb0-f173.google.com with SMTP id p9so2119689lbv.4
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 03:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PXMuFMFtB6eYFmb8/p+dwjwM+1uXeWAP43vlMPX/0K4=;
        b=Q3AddXiy1aaMwIatRp0MLMkvOhB/lPd300P7SIe3igPLtYHK1+0pmdirfEeN8tbSG0
         Wni12E3zW6qYB4FeHaTcsSFPWzQki2Vk1UNlGaDbkpgPeMrH3icZTEpMeVl8/ATkTxZI
         ssxpKst4eMvJfWmZ1zDKIBXMhMlwos2O4ifHNB5F1r/DgzKeF4mvwIpSVJiICeB6Yikt
         h6hm1r7BfgoB+yEq9NaQPTm44/Auodn/vqiqZaxQu87kSJjw/H6BgjZZaBkYClPBEI6k
         PGvGaA5Yw8Z3zWzlp2fkjhfgYwFlDKalN/uj2s8kxvHsbx/AxwM9AO5sUufslqPI5RMU
         jeow==
X-Received: by 10.112.51.44 with SMTP id h12mr6700822lbo.5.1422011251538;
        Fri, 23 Jan 2015 03:07:31 -0800 (PST)
Received: from localhost.localdomain ([5.63.126.22])
        by mx.google.com with ESMTPSA id t19sm370096laz.13.2015.01.23.03.07.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 03:07:30 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360
In-Reply-To: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262907>

Asterisk must be next with variable

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/show-branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 3a7ec55..e7684c8 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -6,7 +6,7 @@
 #include "parse-options.h"
 #include "commit-slab.h"

-static const char* show_branch_usage[] = {
+static const char *show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
        "		[--current] [--color[=<when>] | --no-color] [--sparse]\n"
        "		[--more=<n> | --list | --independent | --merge-base]\n"
--
2.3.0.rc1.275.g028c360
