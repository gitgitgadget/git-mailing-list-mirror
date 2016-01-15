From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3 18/20] svn: learn ref-storage argument
Date: Fri, 15 Jan 2016 12:34:20 +0100
Message-ID: <1452857660-26026-1-git-send-email-szeder@ira.uka.de>
References: <1452788777-24954-19-git-send-email-dturner@twopensource.com>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 12:34:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK2eN-0002Xl-52
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 12:34:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbcAOLef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 06:34:35 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:44100 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754466AbcAOLee (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2016 06:34:34 -0500
Received: from x590d6cbc.dyn.telefonica.de ([89.13.108.188] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aK2eG-00033E-0Y; Fri, 15 Jan 2016 12:34:33 +0100
X-Mailer: git-send-email 2.7.0.rc2.34.g28a1f98
In-Reply-To: <1452788777-24954-19-git-send-email-dturner@twopensource.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1452857673.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284162>

Hi,

The third and last "squash request" for the completion script.

------ >8 ------

Subject: completion: git svn (init|clone) --ref-storage=
---

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 743d8509a69f..9e48d069f07a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2461,7 +2461,7 @@ _git_svn ()
 			--branches= --stdlayout --minimize-url
 			--no-metadata --use-svm-props --use-svnsync-props
 			--rewrite-root= --prefix= --use-log-author
-			--add-author-from $remote_opts
+			--add-author-from --ref-storage= $remote_opts
 			"
 		local cmt_opts="
 			--edit --rmdir --find-copies-harder --copy-similarity=
