From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH 1/3] git-completion.bash: Autocomplete --minimal and --histogram for git-diff
Date: Sat, 12 Jan 2013 17:02:13 +0100
Message-ID: <362b9aec3329d669d910dd4081e12c21ea552b2f.1358006339.git.mprivozn@redhat.com>
References: <cover.1358006339.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: peff@peff.net, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 17:27:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu3vc-0003kK-Hl
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 17:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585Ab3ALQ1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 11:27:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:64214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab3ALQ1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 11:27:00 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0CGQoE4000476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sat, 12 Jan 2013 11:26:52 -0500
Received: from bart.redhat.com (vpn-225-209.phx2.redhat.com [10.3.225.209])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r0CG2MMC005316;
	Sat, 12 Jan 2013 11:02:26 -0500
In-Reply-To: <cover.1358006339.git.mprivozn@redhat.com>
In-Reply-To: <cover.1358006339.git.mprivozn@redhat.com>
References: <cover.1358006339.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213293>

Even though --patience was already there, we missed --minimal and
--histogram for some reason.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a4c48e1..383518c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1031,7 +1031,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--no-ext-diff
 			--no-prefix --src-prefix= --dst-prefix=
 			--inter-hunk-context=
-			--patience
+			--patience --histogram --minimal
 			--raw
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
-- 
1.8.0.2
