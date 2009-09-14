From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 04/17] Add define guards to compat/win32.h
Date: Mon, 14 Sep 2009 15:11:17 +0200
Message-ID: <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
 <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>
 <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com>
 <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Sep 14 15:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBMM-0004Gq-Ui
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 15:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755398AbZINNMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 09:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755389AbZINNMf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 09:12:35 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:61613 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376AbZINNMc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 09:12:32 -0400
Received: by ewy2 with SMTP id 2so642503ewy.17
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=MBKRKj5IZGpYDkTjC7dmJC0KPjJsQwdA2ermmNznTmE=;
        b=Hp0Qh7SfOI8OXbSoMjW3f/pVQYWg0wH1Ftm4sFe1ZSlLFblHrQwG9Bq+K0sh/uFJYi
         FJEeLYYkPyKP+a+mw9GDT4OGSWk5nM123QhG0Kl6LU8uarknslBLfNXx3CDZzPeaRFCZ
         L4emTd8LJTvIb9vqPpgpx57lq4SwvhS5Okwx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VUOdKIW9XZJsQD8zE2dSR0g2gxKHrVtt9YEt9OEN8eWks85C5PcuL4EL76TwHl29hw
         xLMp7zk6e/kelO+MH5cI27fP6Ta8rymeHvwqtiWBlbC0C4Lr9ID2xsEX4Msq72GAn/6U
         UL9QmxaWBGDPSRMZDFg0sFLGUDyMEZZSyUcOA=
Received: by 10.211.159.3 with SMTP id l3mr3104251ebo.37.1252933954787;
        Mon, 14 Sep 2009 06:12:34 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.12.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 06:12:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128461>

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 compat/win32.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/compat/win32.h b/compat/win32.h
index c26384e..e8c178d 100644
--- a/compat/win32.h
+++ b/compat/win32.h
@@ -1,3 +1,6 @@
+#ifndef WIN32_H
+#define WIN32_H
+
 /* common Win32 functions for MinGW and Cygwin */
 #include <windows.h>
 
@@ -32,3 +35,5 @@ static inline int get_file_attr(const char *fname, WIN32_FILE_ATTRIBUTE_DATA *fd
 		return ENOENT;
 	}
 }
+
+#endif
-- 
1.6.2.1.418.g33d56.dirty
