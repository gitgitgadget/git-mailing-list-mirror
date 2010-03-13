From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH/RFC 08/12] http-fetch docs: use <commit-id> consistently
Date: Fri, 12 Mar 2010 23:53:00 -0500
Message-ID: <1268455984-19061-9-git-send-email-lodatom@gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 13 05:54:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqJMh-0007qX-IZ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 05:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933535Ab0CMExj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 23:53:39 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:38262 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339Ab0CMExU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 23:53:20 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so1844181qyk.5
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 20:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xOjaUKyMEeRve30bxFJgKNo/k8iXpBwom8mYm2DdRwI=;
        b=YIlwlu+66pqP/ZThwhbNPMJnj6iBcv2Hik1YZlTLOELLa3zrduf74NY/SFd0qMDFZh
         8ECq0o8wI9e2zH9ZDNl5f4yQ+alUtgtOOqdSj6huyliBWLD9T65lERkphDNHLHnF4Kt9
         adOOZ11dCQQ8yKNAFRKQ6dt2kz8HpurpiIuGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Rqi0V68mXCOkZrAg/KKoRpzVbYaJqRI078HaiVDLzOGnM9Lkbwlemi0ZBYBSHDcAVW
         4+0rUbfpc9rvFfkjtZvNPiNIc1VTX/V2infqKgmP2fIuvHjYIEOQcZxumneMoSSAGvFX
         +5eNwFwRzq2gFHj6DlVSoQAvfzmzTC3Q7Ix8Y=
Received: by 10.224.79.74 with SMTP id o10mr769002qak.217.1268455999750;
        Fri, 12 Mar 2010 20:53:19 -0800 (PST)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id 22sm1694110qyk.10.2010.03.12.20.53.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:53:19 -0800 (PST)
X-Mailer: git-send-email 1.7.0.2
In-Reply-To: <1268455984-19061-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142081>

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
It says that it can be "the filename under ...", but I couldn't get that 
to work.  Can anyone explain how to use something other than a SHA-1?

 Documentation/git-http-fetch.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index d91cb7f..93449fd 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -8,7 +8,7 @@ git-http-fetch - Download from a remote git repository via HTTP
 
 SYNOPSIS
 --------
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
+'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit-id> <url>
 
 DESCRIPTION
 -----------
@@ -16,7 +16,7 @@ Downloads a remote git repository via HTTP.
 
 OPTIONS
 -------
-commit-id::
+<commit-id>::
         Either the hash or the filename under [URL]/refs/ to
         pull.
 
-- 
1.7.0.2
