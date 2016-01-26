From: Paul Wagland <paul@kungfoocoder.org>
Subject: [PATCH v2 1/2] completion: complete show-branch "--date-order"
Date: Tue, 26 Jan 2016 10:36:16 +0100
Message-ID: <20160126093616.GB77046@wagland.net>
References: <20160123012316.GA27965@wagland.net>
 <20160126093429.GA77046@wagland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 10:36:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO030-0001PT-M1
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 10:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934041AbcAZJgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 04:36:23 -0500
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:58811 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756351AbcAZJgU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2016 04:36:20 -0500
Received: from cpsps-ews15.kpnxchange.com ([10.94.84.182]) by cpsmtpb-ews02.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Tue, 26 Jan 2016 10:35:16 +0100
Received: from CPSMTPM-CMT102.kpnxchange.com ([195.121.3.18]) by cpsps-ews15.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Tue, 26 Jan 2016 10:35:15 +0100
Received: from kruimel.wagland.net ([86.85.102.39]) by CPSMTPM-CMT102.kpnxchange.com over TLS secured channel with Microsoft SMTPSVC(7.0.6002.18264);
	 Tue, 26 Jan 2016 10:36:19 +0100
Received: from wagland.net (net06.redwood.com [91.233.6.246])
	by kruimel.wagland.net (Postfix) with ESMTPSA id 137F861C961;
	Tue, 26 Jan 2016 10:36:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160126093429.GA77046@wagland.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on kruimel
X-OriginalArrivalTime: 26 Jan 2016 09:36:19.0302 (UTC) FILETIME=[02B2C060:01D1581D]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284793>


Signed-off-by: Paul Wagland <paul@kungfoocoder.org>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ab4da7f..63754bc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2369,7 +2369,7 @@ _git_show_branch ()
 	case "$cur" in
 	--*)
 		__gitcomp "
-			--all --remotes --topo-order --current --more=
+			--all --remotes --topo-order --date-order --current --more=
 			--list --independent --merge-base --no-name
 			--color --no-color
 			--sha1-name --sparse --topics --reflog
-- 
2.7.0
