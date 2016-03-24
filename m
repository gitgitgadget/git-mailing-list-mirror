From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 2/2] completion: add 'revisions' and 'everyday' to 'git help'
Date: Thu, 24 Mar 2016 19:27:14 +0100
Message-ID: <1458844034-12855-3-git-send-email-ralf.thielow@gmail.com>
References: <1458844034-12855-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 19:28:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9zX-0002nv-26
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbcCXS11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 14:27:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35285 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbcCXS1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 14:27:23 -0400
Received: by mail-wm0-f66.google.com with SMTP id s187so5229954wme.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IViyYlnvkDVUQxTgxRaiGQMPrkgiulBFMQkgWliWlLs=;
        b=uHajlavM0BsAh3Uwiv4ouUyH/rrBio5NFb6sYcS3L+JDETQaxvTZKtoaVgQD9LJbnQ
         K6Fx4LlOrQlhsRlGb9wkhX6AN2r1sLSMgs+sduHkNdxU930hvt3zLyF+OUqo3VHVdLpN
         XB95rBuyZhPo8X7t6zDOkL0mDPI5jFpDs8XJRFyMmsj3OiwUH+wXr4NXLQJmeHpZXucr
         FW1LkJgi0FSRUFXvMqPmn2HQNJD0nsG/wNT0zh8K0zoPSQAqDzf47Y0sesq2rpi+DrRz
         aqAMF0I6LBJ4mMXLb9GZLZyMETIk9XKnBhRiOBGv91PGAyhnb7aUAzChyMYPVcVbAjxh
         YolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IViyYlnvkDVUQxTgxRaiGQMPrkgiulBFMQkgWliWlLs=;
        b=XwBEo7KUd6h+ZkMhnlyse2RC0AtJSZ8llujfy6PnHP90ACZYDypBhICElOu63qoI8Z
         v14crNvNGo12JXn89ZiNuxDfv/FqBhifXsPH1brxSUrJeOkSfXfHxo+In27vLjiRz/qr
         b3fD4L5jUAANr/5rCpy8bNz/u/to/1bLbHPFRRp1Wipcj4gOJ7sZhqKEMtPvqF0Oz+8l
         U/3hOrKeF65rBPgJOK2pFbmzHxok5Bf1samYw8Mi2GFszcXwWnNNuC4i3by8KlG3Xcel
         4ICFbnbjEWNWyaZDGqIPwjbrkJRXzMymxbur0mWxFTqPNxEEB4o21vcwJnttPqisiO3O
         nHLg==
X-Gm-Message-State: AD7BkJJDza1kz2209RiCTVilCi/NzQ1+VLFqZ5MKGkwdpbQmYKwUH2mXmm5+gWhIEcN8SQ==
X-Received: by 10.194.248.163 with SMTP id yn3mr11141915wjc.179.1458844041270;
        Thu, 24 Mar 2016 11:27:21 -0700 (PDT)
Received: from localhost (cable-82-119-18-125.cust.telecolumbus.net. [82.119.18.125])
        by smtp.gmail.com with ESMTPSA id c71sm8885329wmd.4.2016.03.24.11.27.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 11:27:20 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.7.g35d7ca9.dirty
In-Reply-To: <1458844034-12855-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289782>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 70f4171..ffe6004 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1346,8 +1346,8 @@ _git_help ()
 	__git_compute_all_commands
 	__gitcomp "$__git_all_commands $(__git_aliases)
 		attributes cli core-tutorial cvs-migration
-		diffcore gitk glossary hooks ignore modules
-		namespaces repository-layout tutorial tutorial-2
+		diffcore everyday gitk glossary hooks ignore modules
+		namespaces repository-layout revisions tutorial tutorial-2
 		workflows
 		"
 }
-- 
2.8.0.rc4.7.g35d7ca9.dirty
