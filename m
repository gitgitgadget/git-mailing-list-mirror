From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] user-manual: add global config section
Date: Sun, 11 Oct 2009 23:43:05 +0300
Message-ID: <1255293786-17293-2-git-send-email-felipe.contreras@gmail.com>
References: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 22:49:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5Lx-0001qp-W3
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 22:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbZJKUpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 16:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbZJKUpM
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:45:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:14957 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZJKUpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 16:45:09 -0400
Received: by fg-out-1718.google.com with SMTP id d23so285809fga.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cDsLcecrNm8VWha4hXBckQoiKgYMDb25bBeBWGLdj2o=;
        b=xNuWflPh3h4bAeAYZl3PPIe7cmvz8WKBI/daVEIkq/WlGxbsJCnMrMdwQyKL5fXd5h
         NTOQt6uRHYFyGUrYE7Rh53pnEqTKE7KlVgxyBIRjCkMVYIp4qMEFL5Qz2VsWNAc92zRJ
         wGpc/4aCRxFKO9XH+zcQBW/q91Sbz9VV4TOl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IGvQVXpAcef/ZyvrIFO+UR3tiKzmD2lx98xWSc+s25zya3q4HRqUU45Zjbm3oPsFuV
         Ko5YJSqK+92/JqhUHkJO+7Wf8GriOSkTvYsLOC55rEYmTli1DcjOrnmbkJtjjLHNFiZt
         ZyDZCF1dt/M5kI3or5QojpXHo9RzM2Wksrqs4=
Received: by 10.86.234.9 with SMTP id g9mr4631418fgh.39.1255293801054;
        Sun, 11 Oct 2009 13:43:21 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id d4sm3694084fga.21.2009.10.11.13.43.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 13:43:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.4.g31fc3
In-Reply-To: <1255293786-17293-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129954>

So that users get to know how to configure git from the get-to with good
practical example (color.ui = auto) that most people would probably like
anyway.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 67ebffa..ff2563a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -40,6 +40,33 @@ without any explanation.
 Finally, see <<todo>> for ways that you can help make this manual more
 complete.
 
+[[getting-started]]
+Getting started
+=============
+
+Git's configuration is distributed among different locations--this manual will
+only to deal with 'global' (for the user) and 'repository' variables, where
+'repository' variables take precedence over 'global' ones.
+
+You would probably want to start setting up something useful:
+------------------------------------------------
+$ git config --global color.ui auto
+------------------------------------------------
+
+This will make prettier the output of certain commands such as `git diff`, but
+that's not important; what is important here is that `color.ui` has been
+stored in the 'global' configuration.
+
+View and manually modify the configuration by opening `~/.gitconfig`:
+------------------------------------------------
+[color]
+        ui = auto
+------------------------------------------------
+
+Other locations are `/etc/gitconfig` (system), and `.git/config` (repository).
+
+More git configurations will be covered in the rest of the manual, if you want
+to learn more look at linkgit:git-config[1] for details.
 
 [[repositories-and-branches]]
 Repositories and Branches
-- 
1.6.5.4.g31fc3
