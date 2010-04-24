From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH] fast-import docs: LT is valid in email, GT is not
Date: Fri, 23 Apr 2010 20:45:44 -0400
Message-ID: <1272069944-20626-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 02:46:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5TVb-0005CJ-Qy
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 02:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab0DXAp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 20:45:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53728 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054Ab0DXAp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 20:45:56 -0400
Received: by vws17 with SMTP id 17so433332vws.19
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 17:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=L8ZYfGymoLlS08/OWMbOgKavRa01Clu44q28iJ361Uk=;
        b=QmN4zG4pW7sN8XUmCkOlK4RDel2+F7iQtYtVPdmrZXEqEBZuezBUZG5QdiK3zIId8b
         DOPiPF5Rh2QI51ZOOoei1lJIjZUwPLdxdNzgJHPH6IV/vo8dKb0oNvnkOfSbvsv/5TfM
         lMYF94WJF8aPS/aOe7tFgZrQiR+VY47G72WCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=M0ezVKCta73pc2TDtZfyzb5yV1gJ3cn/weYjav+qklZuRF/iwBuH9dt6zbEOvXZE32
         If6UpCCjlNEryNnFHaf2pML04PGA74YnoLhUL9F4dxcx/CQoinl6dZyd+gA75o/soJZQ
         +htbhzWOmdylAjaWxJrsLtXOCLv+Cw/+DLS/o=
Received: by 10.220.108.79 with SMTP id e15mr588957vcp.21.1272069955730;
        Fri, 23 Apr 2010 17:45:55 -0700 (PDT)
Received: from localhost.localdomain (c-68-50-174-152.hsd1.dc.comcast.net [68.50.174.152])
        by mx.google.com with ESMTPS id i29sm7427319vcr.0.2010.04.23.17.45.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Apr 2010 17:45:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145651>

In git-fast-import(1), fix a mistake that said LT and LF were the
invalid characters in email addresses.  This should have been GT and LF,
since the GT ends the email address and LF ends the command.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-fast-import.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 19082b0..6dcd583 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -394,7 +394,7 @@ Here `<name>` is the person's display name (for example
 and greater-than (\x3e) symbols.  These are required to delimit
 the email address from the other fields in the line.  Note that
 `<name>` is free-form and may contain any sequence of bytes, except
-`LT` and `LF`.  It is typically UTF-8 encoded.
+`GT` and `LF`.  It is typically UTF-8 encoded.
 
 The time of the change is specified by `<when>` using the date format
 that was selected by the \--date-format=<fmt> command line option.
-- 
1.7.0.2
