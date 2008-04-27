From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Remove 'header' from --signoff option description
Date: Sat, 26 Apr 2008 19:43:20 -0500
Message-ID: <1209257000-19292-1-git-send-email-dpmcgee@gmail.com>
References: <7vbq3wmije.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Dan McGee <dpmcgee@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 27 02:44:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpv03-0006oj-TR
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 02:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757928AbYD0An0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 20:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757847AbYD0An0
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 20:43:26 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:47625 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757654AbYD0AnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 20:43:25 -0400
Received: by py-out-1112.google.com with SMTP id u52so6806813pyb.10
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 17:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YdBmlvlCov8eP5+jxEXBY1GpqViXuw05ZiSSHzP0tYc=;
        b=lPqOB21HJPq0RMf2cT79OJPq6/zj2RLXzdlyxsJplt+9p0rJG2Kqv2dPlsg5+RJiK+rJAN3xhNFLlS6Fr0p4g5Wz1GhwySgcGdIKu8iPIZw6QphF1BRFWBUk52NN+bTW2kpw20ZnKvlsdw62PsrEGUZfn2OvC3jqa7vbFJNKI/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tuUEpQsNBm0bj/S899PRQsFFhnTDnegat0neOPG8eh5QLWB5eeZYsxJshmd/6MX1C9SLjgc9oYV3Qz0M/QQHwMnw4wtk0v9C64+c7z78h4sGTgohwzg0zC5h6dYbMuTjVRgceqYqzfaDlAGi5MfZG1Vee/8NzduXYMaLlnCyEtU=
Received: by 10.35.105.18 with SMTP id h18mr10368350pym.49.1209257002922;
        Sat, 26 Apr 2008 17:43:22 -0700 (PDT)
Received: from localhost ( [76.193.177.245])
        by mx.google.com with ESMTPS id f51sm4911906pyh.10.2008.04.26.17.43.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Apr 2008 17:43:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <7vbq3wmije.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80402>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin-commit.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index b41d4a3..256181a 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -90,7 +90,7 @@ static struct option builtin_commit_options[] = {
 	OPT_CALLBACK('m', "message", &message, "MESSAGE", "specify commit message", opt_parse_m),
 	OPT_STRING('c', "reedit-message", &edit_message, "COMMIT", "reuse and edit message from specified commit "),
 	OPT_STRING('C', "reuse-message", &use_message, "COMMIT", "reuse message from specified commit"),
-	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by: header"),
+	OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 	OPT_STRING('t', "template", &template_file, "FILE", "use specified template file"),
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 
-- 
1.5.5.1
