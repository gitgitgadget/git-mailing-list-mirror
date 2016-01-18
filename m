From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 1/5] ls-remote: document --quiet option
Date: Mon, 18 Jan 2016 17:57:14 +0100
Message-ID: <1453136238-19448-2-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 17:57:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLD7L-0003S4-5O
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 17:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775AbcARQ5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 11:57:13 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34347 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793AbcARQ5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 11:57:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id b14so17777391wmb.1
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 08:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KEanfpP/Pv/1kPsNLbBs8HFwvOr/bU8ooWhgmixq/js=;
        b=oPya2LpnCElwAaKiuajt0YiPBO/PskTMVPWgTXPKiuaGDF8oMeXFssLSRlNi8j8qdq
         DQ8u41HV22ztkLKiU0Jak9ecWImoBSuu4xKSFaRRSFb0OZePQkLL5euJc8o2TUAleQML
         pMu/oaW/D0yBNG2ueG9cH5nx9ANZWPFXT+7OhbwWRk7adfdeohJexPaZA9kkyVSxt1xo
         LMk6GDbQulcRg1UlGT5psz44124mmG/ULbyN7ZMM51/iPbk37BJfsoLKlXqTANH1vhQe
         vBp4NOCtbfo3ZE035Jlx7VRhoVtR/c0zzcS3XIcfVWnfqsA6A86J6ONmfIZ/B0s4DfJD
         t1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KEanfpP/Pv/1kPsNLbBs8HFwvOr/bU8ooWhgmixq/js=;
        b=iQ94kPptzbk9mMwEWqXALcms58L+Bej7dlwjPwoEEfH2Yed3/SeXdAuyFuSNAecRPI
         yr0/0qIBmD4DALYy64fb/imtECx6dPxVx61SRfg+LvwkwH+5Vp/y1Bcsq2sno/31qrfB
         XaNwu9/xFm4LKlkNrTLa3wIC/OiRTxZsLO+ROwjjNZK9M/fphORmjpNkQQqJQRk/l70o
         ssFUn2/f70U49CujsRIPjc58NPJRA/BE4c5y7AehYT1Zxwd03S/EIL2g7vQV/cRzgZzQ
         pE3D8bBAU7N/jjvyoKzDJJ2YEIT3PXcQBMSRSrq252C4VYJGG+rysutP6rfxeDLSjkDa
         yq3w==
X-Gm-Message-State: AG10YOR9ZvY/sxK1qfu1TUifdpKgy7aS6gPYJqkQp0kkw/M/QfeqdOdnovQvUKW5gRrUNw==
X-Received: by 10.28.225.132 with SMTP id y126mr14860701wmg.98.1453136227612;
        Mon, 18 Jan 2016 08:57:07 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id q75sm16612591wmd.6.2016.01.18.08.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 08:57:06 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.gd0a78e9.dirty
In-Reply-To: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284297>

cefb2a5e3 ("ls-remote: print URL when no repo is specified") added a
quiet option to ls-remote, but didn't add it to the documentation.  Add
it.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index d510c05..27380de 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags]  [--upload-pack=<exec>]
-	      [--exit-code] <repository> [<refs>...]
+	      [-q | --quiet] [--exit-code] <repository> [<refs>...]
 
 DESCRIPTION
 -----------
@@ -29,6 +29,10 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.
 
+-q::
+--quiet::
+	Do not print remote URL to stderr.
+
 --upload-pack=<exec>::
 	Specify the full path of 'git-upload-pack' on the remote
 	host. This allows listing references from repositories accessed via
-- 
2.7.0.30.gd0a78e9.dirty
