From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/11] completion: add missing fetch options
Date: Thu, 19 May 2016 23:58:35 -0500
Message-ID: <1463720325-8853-2-git-send-email-felipe.contreras@gmail.com>
References: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 06:59:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3cWw-0001mJ-F2
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 06:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbcETE6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 00:58:49 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35764 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754419AbcETE6s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 00:58:48 -0400
Received: by mail-oi0-f66.google.com with SMTP id w198so21095651oiw.2
        for <git@vger.kernel.org>; Thu, 19 May 2016 21:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ziOfscq6QvMIjpzEdZpxHW9A6ckuiIixf6Q/gX5XXGE=;
        b=mMYAUkoNeUyKQ8iP6TCtrWnW+4dQb50+hL0RG1/cuUC52uc490+JWRxDnSuy8/TdcW
         opwwdWwy3Z/JPRCN9IDQXvLDis3ubOd+ZoSCVtiRuy0uQ0iFhrbc2kclNcIZSkh5g/UB
         PP93GuhPQiRNTjN+9JC3S4HPS1qOQnpUyyjrxCV+ifYKzWJIBSEY+UBrqh9wgvu8KOih
         DKWS6DNG7boE4VHnCC6AD2AC2JjGGF+MpEPOHmLV26qyikXDbLdNPa/p/Li40fi2jI/7
         sl3D3y4LML5Y8JAJIwuIGCo8dgo2k1eSgzX+CXFAgN71DxV5yAvsDYsxmODqI1WczBS0
         X3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ziOfscq6QvMIjpzEdZpxHW9A6ckuiIixf6Q/gX5XXGE=;
        b=J+KHPnPOU2eblXLKjXSd87P/+UwmQwgZy6RbATbK5KmvouLsLUGRKzCmSbOuAd6IOa
         eZto+KabdhdpxJS19Rw2/3bjZWWM/6AuLLWZBtpRe/JFjPs1YxShep1nhFPXiGrGEN2m
         ME4YGbR9BlGuAfbIKg5P2xpPEp4DX+ODas1qaLcACUpLY6Ca579w2pLiaWbEY5u2lORJ
         it+k7lg84GngoKjEMm2s+KSpOJTG6qFnxLG5ZAeHOwjdp8PB8DIxdJYKeuVz163pYouY
         Ko1qoMXpS6uQlbbWvZqjJvKl8+JS5wpcrh3Viv4VGYR+IMEEri99kDkaAFZp4MSW1TZL
         WINA==
X-Gm-Message-State: AOPr4FUTU9O1rIiBEoUnR4TQGK2b1OGYsdQMaQqpjgGNuCpchoT8dWxrenCsh67puK0UUA==
X-Received: by 10.157.18.179 with SMTP id g48mr505777otg.53.1463720327171;
        Thu, 19 May 2016 21:58:47 -0700 (PDT)
Received: from localhost ([189.208.111.205])
        by smtp.gmail.com with ESMTPSA id v16sm4882280oie.5.2016.05.19.21.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 May 2016 21:58:46 -0700 (PDT)
X-Mailer: git-send-email 2.8.0+fc1
In-Reply-To: <1463720325-8853-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295148>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3918c8..ecdf742 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1225,6 +1225,8 @@ __git_fetch_recurse_submodules="yes on-demand no"
 __git_fetch_options="
 	--quiet --verbose --append --upload-pack --force --keep --depth=
 	--tags --no-tags --all --prune --dry-run --recurse-submodules=
+	--no-recurse-submodules --unshallow --update-shallow --multiple
+	--submodule-prefix= --update-head-ok --progress
 "
 
 _git_fetch ()
-- 
2.8.0+fc1
