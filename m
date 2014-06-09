From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH/RFC v1 2/5] add strbuf_set operations documentation
Date: Mon,  9 Jun 2014 01:36:26 -0700
Message-ID: <ce477667323a531b4b3c39724160e66360061816.1402301816.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 10:37:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtv5F-0007CV-76
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 10:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755036AbaFIIhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 04:37:33 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34442 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955AbaFIIhb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 04:37:31 -0400
Received: by mail-pa0-f45.google.com with SMTP id hz1so519678pad.4
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 01:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=pSueJDI673YmO6Od+rlAR9vnR2+asuQ22HUIoomZiMM=;
        b=MGWGfxtd8XmP4eiVoL/KNT+IXRT4l0wD4Hl4l8M9UjQRekPTonF4ativGwg+hrZrFD
         PmV56JQ9MM9fh055RAhDlIv4qmYNcRsFg6xPuJayGTmSOHBFJvp07Vg98jdaapFGbZjk
         ZsEWmRMZ8BwcpNIG1LjpCEg6WCBgRplutGGmO9Q60fyIUH9ry7tIUnQoMaG9o8usVMz2
         PpbG+ZkPPgSx5w0KG384tjaUTaa32TOVMC0rIz2V4IHbwNnFh3eZP0tinIltyE6KD+qJ
         /dDnbNSys3/JUNHiJgcmmz1o3Dm//CoLWOFn4k/mBwQvy0SpFS7y/qb8guiX93Kmkn4C
         VGBw==
X-Received: by 10.68.133.229 with SMTP id pf5mr3036550pbb.115.1402303051081;
        Mon, 09 Jun 2014 01:37:31 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id av2sm62734470pbc.16.2014.06.09.01.37.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 01:37:29 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 01:37:27 -0700
X-Mailer: git-send-email 2.0.0.573.ged771ce.dirty
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251061>

Add documentation of the strbuf_set operations to
technical/api-strbuf.txt.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 077a709..ab430d9 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -149,6 +149,24 @@ Functions
 	than zero if the first buffer is found, respectively, to be less than,
 	to match, or be greater than the second buffer.
 
+* Setting the buffer
+
+`strbuf_set`::
+
+    Set the buffer to some data up to a given length.
+
+`strbuf_setstr`::
+
+	Set the buffer to a NUL-terminated string.
+
+`strbuf_setf`::
+
+	Set the buffer to a formatted string.
+
+`strbuf_setbuf`::
+
+	Set the current buffer to the contents of some other buffer.
+
 * Adding data to the buffer
 
 NOTE: All of the functions in this section will grow the buffer as necessary.
-- 
2.0.0.573.ged771ce.dirty
