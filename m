From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v9 03/19] index-helper: new daemon for caching index and related stuff
Date: Tue, 10 May 2016 12:13:15 +0200
Message-ID: <20160510101315.32403-1-szeder@ira.uka.de>
References: <1462826929-7567-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 12:13:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b04fk-0003aq-OE
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 12:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbcEJKNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 06:13:44 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:55845 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751364AbcEJKNn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2016 06:13:43 -0400
Received: from x4db0dd69.dyn.telefonica.de ([77.176.221.105] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1b04fa-0002qJ-0S; Tue, 10 May 2016 12:13:39 +0200
X-Mailer: git-send-email 2.8.2.356.ge684b1d
In-Reply-To: <1462826929-7567-4-git-send-email-dturner@twopensource.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1462875219.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294116>

This patch adds a new plumbing command, which then will show up in
completion after 'git <TAB>'.  Could you please squash in this
oneliner to exclude index-helper from porcelain commands in the
completion script?


---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 34024754d929..9264ab919a6a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -684,6 +684,7 @@ __git_list_porcelain_commands ()
 		for-each-ref)     : plumbing;;
 		hash-object)      : plumbing;;
 		http-*)           : transport;;
+		index-helper)     : plumbing;;
 		index-pack)       : plumbing;;
 		init-db)          : deprecated;;
 		local-fetch)      : plumbing;;
-- 
2.8.2.356.ge684b1d
