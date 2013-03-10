From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 19/23] contrib/subtree: Document list command
Date: Sun, 10 Mar 2013 23:41:27 +0000
Message-ID: <1362958891-26941-20-git-send-email-pcampbell@kemitix.net>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
Cc: David Greene <greened@obbligato.org>,
	Herman van Rink <rink@initfour.nl>,
	Paul Campbell <pcampbell@kemitix.net>,
	"Peter Jaros" <pjaros@pivotallabs.com>,
	"Matt Hoffman" <matt.hoffman@quantumretail.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Wayne Walter" <wayne@tickzoom.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 11 00:45:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEpw6-00055w-Sc
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 00:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465Ab3CJXpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 19:45:24 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:45801 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab3CJXpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 19:45:23 -0400
Received: by mail-wg0-f53.google.com with SMTP id fn15so4262958wgb.8
        for <git@vger.kernel.org>; Sun, 10 Mar 2013 16:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=DSoZDQwMwo+37UFrjAZXhrPDFE728CjvxbjKaT+Q7LQ=;
        b=opmqcWi7hKTnYTQQHbHuBwWIxD7jwvVMdrg0QFjfFNmXK4X8sT4zBO/RiI6utvpykb
         +q9wLeh26pQCMcg8cgTg3K/MGLDDr2zcMPqWONdIE/ZgcSa2crB06qHvAMIK6OU5lsE7
         rPxjAxQZAk6voogpus77s7X07QenuChlHtjgPpdcQSVoGSIO3nHbewqVo1ickgh4YT/+
         uueH5GH1VYJkUF/qtTlzd7G1gGDkc+Krxu6MFRzjCYkBwsLWN8vnwqXUtyeSkg65tPAC
         bScdK/Tji0zH/f0jd8nklSKI5vckfi63DxCwNsSEKVuaJ0WS9N/AdV2gjuIXSkdxqP44
         KoTA==
X-Received: by 10.194.77.129 with SMTP id s1mr15713053wjw.17.1362959122004;
        Sun, 10 Mar 2013 16:45:22 -0700 (PDT)
Received: from coyote.home (host-2-102-87-75.as13285.net. [2.102.87.75])
        by mx.google.com with ESMTPS id r7sm13757148wiz.2.2013.03.10.16.45.17
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 10 Mar 2013 16:45:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.rc1
In-Reply-To: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
X-Gm-Message-State: ALoCoQnwshAQSh/DiHtiiwCZUproyjdZdHmyBjT8pA7suX6erfl9LexdoRhjAx5nkYx1KeWBvBdC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217839>

From: Herman van Rink <rink@initfour.nl>

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>

Conflicts:
	git-subtree.sh
---
 contrib/subtree/git-subtree.sh  | 1 +
 contrib/subtree/git-subtree.txt | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 84c90c7..4605203 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -15,6 +15,7 @@ git subtree pull  --prefix=<prefix> <repository> <refspec...>
 git subtree pull-all
 git subtree push-all
 git subtree push  --prefix=<prefix> <repository> <refspec...>
+git subtree list
 git subtree split --prefix=<prefix> <commit...>
 git subtree diff  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree from-submodule --prefix=<prefix>
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index b485ab5..385bde8 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 'git subtree' pull-all
 'git subtree' push-all
 'git subtree' push  --prefix=<prefix> [<repository> [<refspec>...]]
+'git subtree' list
 'git subtree' split --prefix=<prefix> <commit...>
 'git subtree' from-submodule --prefix=<prefix>
 'git subtree' prune
@@ -108,6 +109,9 @@ push::
 push-all::
 	Perform a pull operation on all in .gittrees registered subtrees.
 
+list::
+	Show a list of the in .gittrees registered subtrees
+
 split::
 	Extract a new, synthetic project history from the
 	history of the <prefix> subtree.  The new history
-- 
1.8.2.rc1
