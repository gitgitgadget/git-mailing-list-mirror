From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/6] Documentation/git-tools: improve discoverability of Git wiki
Date: Tue, 28 Jul 2015 16:06:12 -0400
Message-ID: <1438113975-4915-4-git-send-email-sunshine@sunshineco.com>
References: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 22:06:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB9N-0001aN-Kj
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbbG1UGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:06:49 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37837 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbG1UGr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:06:47 -0400
Received: by igbpg9 with SMTP id pg9so137347253igb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kev5F9N3eJVvrG3Hdij96FbRtO7eE6DDuVjFhABZuHw=;
        b=ad3eJZm2nK0OAcQ5p0htruAD1gbXf6WXb9Mm3GLdqjVMOW8PoZyn6CbX062bCd9o6O
         oHGysDdt2o8LcXNAkEOHMBjbq0WnXwu7LqgeyK85GPzLL27xF/vXyxkqdx0Pj0A6PIia
         MSS8ov5UbJTcYt8i1udbbFqGZhKf3Jq97m0n0PMlacPK1pocIhm3uWY39r3K5+dHvx1s
         RWlPDvavm5NEPSubisVsHEmlGvE5+phyCPTTNq/iSMByvapiVhFpd3UOAP8bR8bEuk/G
         C0/9FnsZxtEjq6n5Wtr1zmXfmUgwKNdBQ33o+OknbaWUw51j/FD8uUHs/+CPpEJVHkVA
         WCFg==
X-Received: by 10.50.132.70 with SMTP id os6mr10147936igb.27.1438114007362;
        Tue, 28 Jul 2015 13:06:47 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id r16sm15195896ioe.19.2015.07.28.13.06.46
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 13:06:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.490.g8c70279
In-Reply-To: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274830>

These days, the best way to find Git-related tools is via a search
engine. The Git wiki may be a distant second, and git-tools.txt falls in
last place. Therefore, promote the Git wiki reference to the top of
git-tools.txt so the reader will encounter it first, rather than hiding
it away at the very bottom.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1: reword commit message slightly

 Documentation/git-tools.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 78a0d95..129b8c0 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -6,10 +6,11 @@ Introduction
 ------------
 
 Apart from Git contrib/ area there are some others third-party tools
-you may want to look.
-
+you may want to look at.
 This document presents a brief summary of each tool and the corresponding
 link.
+For a more comprehensive list, see:
+http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
 
 
 Alternative/Augmentative Porcelains
@@ -112,7 +113,3 @@ Others
    This is an Emacs interface for Git. The user interface is modelled on
    pcl-cvs. It has been developed on Emacs 21 and will probably need some
    tweaking to work on XEmacs.
-
-
-http://git.or.cz/gitwiki/InterfacesFrontendsAndTools has more
-comprehensive list.
-- 
2.5.0.rc3.490.g8c70279
