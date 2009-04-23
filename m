From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 7/8] config.txt: clarify sentences in the configuration and syntax sections
Date: Thu, 23 Apr 2009 02:38:01 -0700
Message-ID: <1240479482-31366-8-git-send-email-bebarino@gmail.com>
References: <1240479482-31366-1-git-send-email-bebarino@gmail.com>
 <1240479482-31366-2-git-send-email-bebarino@gmail.com>
 <1240479482-31366-3-git-send-email-bebarino@gmail.com>
 <1240479482-31366-4-git-send-email-bebarino@gmail.com>
 <1240479482-31366-5-git-send-email-bebarino@gmail.com>
 <1240479482-31366-6-git-send-email-bebarino@gmail.com>
 <1240479482-31366-7-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 23 11:40:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwvQA-0001FG-Rz
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 11:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbZDWJid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 05:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbZDWJic
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 05:38:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:7604 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbZDWJia (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 05:38:30 -0400
Received: by rv-out-0506.google.com with SMTP id f9so392313rvb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=qIzFvcOQTwo77lBEapwpOweghflzLNOgAGUi2el9VVo=;
        b=XoMtHDbDXOAIuWokkZNI/5Y+eJGnhQ6ucJZwoDu+1z3qlfJvrjPD6guQ8ImbyeHCSU
         Ay1CkIioubsNli1vZ84F830fqe9R1e5YFcH9CQ/c+OBHiySOXkU5SyhU9cLWfwGNYTMy
         DEgGGOqRtFZsWMew1Ysl8qIiWld/J3fQpyMkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PIN1CLAwGlylzl5MCZbmZcMO3nWlhgU/XlNtoDjymJZq4fsBkp2fxKtBMewSfH0BMu
         8Sb7Ajcrnp4aGUCHHZdw5LlrKlkFY1hJduMrBmvtl85fHR2NjzsQsqoAQ0M9ioMRGB05
         oh4cwZbLAFSOBocpu4hsQ9AijZPUgIqc4EZ98=
Received: by 10.142.217.17 with SMTP id p17mr284175wfg.201.1240479510788;
        Thu, 23 Apr 2009 02:38:30 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 22sm2633633wfi.12.2009.04.23.02.38.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 02:38:30 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 02:38:26 -0700
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <1240479482-31366-7-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117320>


Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/config.txt |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1f17e7a..acd9b31 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -8,9 +8,9 @@ is used to store the information for that repository, and
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store system-wide defaults.
 
-They can be used by both the git plumbing
-and the porcelains. The variables are divided into sections, where
-in the fully qualified variable name the variable itself is the last
+The configuration variables are used by both the git plumbing
+and the porcelains. The variables are divided into sections, wherein
+the fully qualified variable name of the variable itself is the last
 dot-separated segment and the section name is everything before the last
 dot. The variable names are case-insensitive and only alphanumeric
 characters are allowed. Some variables may appear multiple times.
@@ -38,9 +38,9 @@ in the section header, like in the example below:
 
 --------
 
-Subsection names can contain any character except newline (doublequote
-`"` and backslash have to be escaped as `\"` and `\\`,
-respectively) and are case sensitive.  Section headers cannot span multiple
+Subsection names are case sensitive and can contain any characters except
+newline (doublequote `"` and backslash have to be escaped as `\"` and `\\`,
+respectively).  Section headers cannot span multiple
 lines.  Variables may belong directly to a section or to a given subsection.
 You can have `[section]` if you have `[section "subsection"]`, but you
 don't need to.
-- 
1.6.2.3
