From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 5/5] parse-options: clarify PARSE_OPT_NOARG description
Date: Sat, 21 Aug 2010 15:28:19 +0530
Message-ID: <1282384699-16477-6-git-send-email-artagnon@gmail.com>
References: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 12:00:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omksd-0004zP-TT
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab0HUKAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:00:41 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39425 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab0HUKAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:00:40 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so1588171pzk.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 03:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QkgtU8+3zMRA/hg8X5xfjxepgefYz8LVCrGcNHNPX78=;
        b=eyLRhyF9IZK/STD+8LUzTGN4xAd8iNUoPUenFAbS2qDxEHOfiYuz4t9iTwaVjU5drp
         5/MNPzQyZTjstmoXWRdKssq9+sZsL0EtkDJFx0hHJvWIu2a05g7/HFi3YE6uPnXkxeOQ
         EW61SF6f39WjdyR9dkOm6UbMduo7wZ9tmdsF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=A0WqSdP208lVAI/QcIrTmtJ59BQ6d19UIwdu6wrdJDEt6GlxPpI6fDDNsQZfpAgiwT
         zEfWz32Jju1tQL/7RWEqAgd1syclyKxDDFoG4R93j6rmWEIL9QBTAQUjkd96HYaJ2q+f
         deWTUbut3v9WYKQxVGSe0QODLSuzA9mD5f1eQ=
Received: by 10.142.200.21 with SMTP id x21mr2118202wff.84.1282384840482;
        Sat, 21 Aug 2010 03:00:40 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id b19sm4641270wff.7.2010.08.21.03.00.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 03:00:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154131>

From: Jonathan Nieder <jrnieder@gmail.com>

Here "takes no argument" means "does not take an argument".  The
latter phrasing might make it clearer that PARSE_OPT_NOARG does not
make an option with an argument that can optionally be left off.

Noticed-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 parse-options.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parse-options.h b/parse-options.h
index d3b1932..f5ee3a0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -69,7 +69,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  * `flags`::
  *   mask of parse_opt_option_flags.
  *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
- *   PARSE_OPT_NOARG: says that this option takes no argument
+ *   PARSE_OPT_NOARG: says that this option does not take an argument
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN: this option is skipped in the default usage, and
  *                     shown only in the full usage.
-- 
1.7.2.2.409.gdbb11.dirty
