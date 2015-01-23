From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 6/7] quote: minor style fix
Date: Fri, 23 Jan 2015 17:08:33 +0600
Message-ID: <1422011313-4224-1-git-send-email-kuleshovmail@gmail.com>
References: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 12:08:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEc6a-0001wg-RF
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 12:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbbAWLIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 06:08:42 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:43044 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbbAWLIk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 06:08:40 -0500
Received: by mail-la0-f48.google.com with SMTP id pv20so6645489lab.7
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 03:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qVyxmh0U7RO31VhPLlK890pEEAY5seAMuxW9XzddBuw=;
        b=VxRPvR+GWVdPpcwItdPn3u5/K+g4cUpQOfmhP9Pj7PaPVBVUXqdvfwMe04RCZa7H1D
         CcGrYLV9W2gB7V55K1PkJ5GU5ekVKXF9vwAn8VeztzfSTV6GlW5lxqqW5bx4sw/KrdxS
         Y620HyD91Tnw6t5lRB45cHoLy/lJdh0ZoGHimXtSterAWd8KRDeMiuRQkIc9EKgAebhH
         Qm8JQ621w6zerH9Y/V1HxGeCuTIy2PRBuWmSg1i4jlmJxohttVnUAMvYjVZdWWTPxfA7
         lLZF85xvvIANzhKe9rby057ByQmAmjxP/57/wY+bMaBkRYiS+XZgrajf9ZpZvV6CjVMi
         kf5A==
X-Received: by 10.112.8.41 with SMTP id o9mr6627183lba.40.1422011318733;
        Fri, 23 Jan 2015 03:08:38 -0800 (PST)
Received: from localhost.localdomain ([5.63.126.22])
        by mx.google.com with ESMTPSA id p10sm371884lap.10.2015.01.23.03.08.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 03:08:37 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360
In-Reply-To: <1422011208-3832-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262912>

Asterisk must be next with variable

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 quote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/quote.c b/quote.c
index 7920e18..02e9a3c 100644
--- a/quote.c
+++ b/quote.c
@@ -42,7 +42,7 @@ void sq_quote_buf(struct strbuf *dst, const char *src)
 	free(to_free);
 }

-void sq_quote_argv(struct strbuf *dst, const char** argv, size_t maxlen)
+void sq_quote_argv(struct strbuf *dst, const char **argv, size_t maxlen)
 {
 	int i;

--
2.3.0.rc1.275.g028c360
