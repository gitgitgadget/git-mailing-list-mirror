From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 02/14] Add define guards to compat/win32.h
Date: Tue, 15 Sep 2009 15:44:05 +0200
Message-ID: <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com>
 <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	raa.lkml@gmail.com, snaury@gmail.com,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Tue Sep 15 15:44:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnYKw-0007Be-Ru
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 15:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbZIONoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 09:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753995AbZIONoh
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 09:44:37 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:49262 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbZIONof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 09:44:35 -0400
Received: by ey-out-2122.google.com with SMTP id 25so789017eya.19
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=MBKRKj5IZGpYDkTjC7dmJC0KPjJsQwdA2ermmNznTmE=;
        b=H4IkPaCM+SiaHGdqEBHjXGeIQMcoX3qRwN5RaRVrbvfwY46kpFyBuZjUBwa+MiE/m8
         6lbqo3mh34DoGBRbwmj+QkmRZkZMcfaPyoDOg2h5TWmUeW530eE5ML9M9WzWcZUF3jia
         zivr3kVJdxDj86K0wDFsfH8z5AMoUfV4bpqdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SiK3mwMbHME11TnoeAOZrhmVl3v06cqU1hg+e1abjSycJwYdjktwph0Pjpo5EM8DWn
         r1Vrh6vI4oJgRv7No7GzMXf6JeZEMcmHBoUgW0waejXfbuJsDXfflsMeSzEEGXqDxYBw
         9DpXM8iRlCzRK8EXgA/IQxDKpcgY5k554BlAw=
Received: by 10.211.154.17 with SMTP id g17mr838983ebo.32.1253022278442;
        Tue, 15 Sep 2009 06:44:38 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104])
        by mx.google.com with ESMTPS id 7sm81939eyg.4.2009.09.15.06.44.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 06:44:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com>
In-Reply-To: <cover.1253021728.git.mstormo@gmail.com>
References: <cover.1253021728.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128545>

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
