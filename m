From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/5] ls-remote: fix synopsis
Date: Tue, 19 Jan 2016 00:20:48 +0100
Message-ID: <1453159250-21298-4-git-send-email-t.gummerer@gmail.com>
References: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 00:21:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLJ78-0006ow-9W
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 00:21:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667AbcARXVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 18:21:23 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33710 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbcARXUr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 18:20:47 -0500
Received: by mail-wm0-f66.google.com with SMTP id u188so19464264wmu.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 15:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i0ColAjLx+gElqkrBJ3kQh45C3EEGSZmAwBXhEwSZ1c=;
        b=W5INa66x2dybudzH5ELVK7L6ErsLpiW+Lpzi/LLtkuiE0fvDhcogJaom/LF8lrdIXy
         9ZIKZ+TBDZ0pSjkj/nXS68JRBYsPS0jJssxQVPkP5q37vr6pLekTCQJmQCzP+lLp/z2S
         /kFW8nplav7cZuHAUxC9MpDzubTX9b/f3zvrwnRceqRWl4KwT3c6wTG8IUNNslF9Fh3q
         HPv4SGoqWCjxZvrJE5Z7y+6Q+OWo1Km5ArWxUeypquLTzBy9J/Fv6rJcsqEqzssp1odD
         sdPPckBu3ksZSQG+WGFYSSXf83IzXIdL9vBRzdwazXN0qCl8tZN8aGItap3it1pQ3oWy
         M9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i0ColAjLx+gElqkrBJ3kQh45C3EEGSZmAwBXhEwSZ1c=;
        b=mX1Sj2r5VIZyh24V+3oq8H4Of5srUCSMGF/fMXAyyf5VrzoIMtB3g6e6QoJlft4QuO
         Bjq/Qw8yXOAizhJEsjlfbAgxhFL6/u5TwpzioOKWEwXnOgNy0kTPfAehlBg7kPWVUKKR
         uLwgAdB54PrJ1UdiSdvBcF2qT6FFz2qjy2ylGH4bQksBYdzHWA/cuyGKgwrq6lNvzj7z
         lLGONcoTQwv7JEuiNcaYgJenKPqz1x6n+fYm1Si9EswcJPeg8ailzM0bSlvAQP1Fh2dN
         wutrY1VncwzWCjQT7QMC0cu/UHD7egOc+6RO4v3HPswS/Paaah0AGHNGH1iMQekQelmA
         BWVA==
X-Gm-Message-State: ALoCoQlLA0VJ/jt+yO7LZ3387k8p4P225dNz2/UA/FtFLas7HpYtorNgSTOnhvdJoIozQxWPEi1B+FS2QPnlnctebKn9lKkfdQ==
X-Received: by 10.194.203.228 with SMTP id kt4mr26480643wjc.58.1453159246534;
        Mon, 18 Jan 2016 15:20:46 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id uo9sm25822823wjc.49.2016.01.18.15.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 15:20:45 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.g56a8654.dirty
In-Reply-To: <1453159250-21298-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284341>

git ls-remote takes an optional get-url argument, and specifying the
repository is optional.  Fix the synopsis in the documentation to
reflect this.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 7467162..453e93c 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
-	      [-q | --quiet] [--exit-code] <repository> [<refs>...]
+	      [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]
 
 DESCRIPTION
 -----------
-- 
2.7.0.30.g56a8654.dirty
