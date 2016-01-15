From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v3 17/20] refs: allow ref backend to be set for clone
Date: Fri, 15 Jan 2016 12:32:30 +0100
Message-ID: <1452857550-25887-1-git-send-email-szeder@ira.uka.de>
References: <1452788777-24954-18-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 12:33:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK2d6-0001ih-Dt
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 12:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbcAOLdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 06:33:06 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43766 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751095AbcAOLdF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2016 06:33:05 -0500
Received: from x590d6cbc.dyn.telefonica.de ([89.13.108.188] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aK2cn-0002yq-Ot; Fri, 15 Jan 2016 12:33:03 +0100
X-Mailer: git-send-email 2.7.0.rc2.34.g28a1f98
In-Reply-To: <1452788777-24954-18-git-send-email-dturner@twopensource.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1452857583.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284160>

Hi,

This change is more about 'git clone' than about refs, therefore
I think the subject line would be better as:

  clone: allow setting alternate ref backend

Could you please squash this in to keep the completion script up to date?
Is there or will there be a way to list available ref backends, so we
could complete possible options for --ref-storage=<TAB>, too?

------ >8 ------

Subject: completion: git clone --ref-storage=
---
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ab4da7f97917..c970d3c0d0a3 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1092,6 +1092,7 @@ _git_clone ()
 			--depth
 			--single-branch
 			--branch
+			--ref-storage=
 			"
 		return
 		;;
