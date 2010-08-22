From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v5 5/5] parse-options: clarify PARSE_OPT_NOARG description
Date: Sun, 22 Aug 2010 21:56:38 +0530
Message-ID: <1282494398-20542-6-git-send-email-artagnon@gmail.com>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 22 18:30:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnDR8-00047i-AT
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 18:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab0HVQ3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 12:29:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:48844 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab0HVQ3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 12:29:15 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1976160pxi.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 09:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=QkgtU8+3zMRA/hg8X5xfjxepgefYz8LVCrGcNHNPX78=;
        b=VCJ99yzWyISxyL//VBY3YMy8K5C5XaKP343cjhxhbIphscrne42zjeRXx8rfD0+raG
         C41nukfdQgyD+QmggEIIAVtGm1o3imsZAU8mbX8qMJ0oyGsfCitwT/gz5MlOdpovBk4w
         cV2vKeLRsuiGHyJ33BZdK1VzUvq2luO2fWW6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=H/X3a1yxQy18vhqQqBntwlD2cwyzw1NYurO3MboyG9X/pPUJLY8R+F4ZVqUTXSW1zH
         izvWwovIfH9sL2Ih0wsOs9guj27fVGaRUN6Wwgf4qGAinwZ1gZzNSr5pxzIdKQlTN/Gs
         p9GddzQmovs0CSKlJpjKJ9sRuqKhzdaLRqq6E=
Received: by 10.142.135.11 with SMTP id i11mr3446304wfd.9.1282494555357;
        Sun, 22 Aug 2010 09:29:15 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id y16sm7089065wff.14.2010.08.22.09.29.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Aug 2010 09:29:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154186>

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
