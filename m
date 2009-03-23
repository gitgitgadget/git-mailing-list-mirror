From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/3] completion: add --cc and --no-attachment option to format-patch
Date: Mon, 23 Mar 2009 03:26:50 -0700
Message-ID: <1237804011-15419-3-git-send-email-bebarino@gmail.com>
References: <1237804011-15419-1-git-send-email-bebarino@gmail.com>
 <1237804011-15419-2-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 11:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhOU-0003Bn-8C
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbZCWK1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbZCWK1E
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:27:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:24659 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbZCWK1B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:27:01 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1443082wah.21
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=3bqAdBAONlN61qeEpLuVksoWEXnK3/Fo7ffn+AzJh9s=;
        b=M1EYTRoz2ongnTic/iskmcffX2WMsXeH9u2f9wy1GV6u7fMEfMmZeDxEIuX+iHEb7i
         tR/hQ8S/RK/OzoBYZuheeNzcKZpkPDD/HrfQhg+jj1mBnHGtARURePGSakF11f1SQz1Y
         pXaFxc6qaK4wK7O2RrUvCt5KM/fQCjvfLAsHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MpqYHRvTBc5Y5csf7nz9629lwwUVDwAXrJB+f3+MryeU762iUtHqHhaBXjpL8mK8KZ
         Za5WEKvDGk+cQnXz9sQSyv/DjgNshoM2R3azmL9giI0tzDLl+1n/JiQJDGOg0h27l/9u
         FqqlxkoSzDWxrzRetFWt8VJVlhz+G9piHKzYQ=
Received: by 10.114.234.13 with SMTP id g13mr4703951wah.64.1237804019625;
        Mon, 23 Mar 2009 03:26:59 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id l37sm5248691waf.3.2009.03.23.03.26.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 03:26:59 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Mon, 23 Mar 2009 03:26:57 -0700
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1237804011-15419-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114273>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8719242..b96458f 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -932,13 +932,13 @@ _git_format_patch ()
 	case "$cur" in
 	--*)
 		__gitcomp "
-			--stdout --attach --thread
+			--stdout --attach --no-attach --thread
 			--output-directory
 			--numbered --start-number
 			--numbered-files
 			--keep-subject
 			--signoff
-			--in-reply-to=
+			--in-reply-to= --cc=
 			--full-index --binary
 			--not --all
 			--cover-letter
-- 
1.6.2
