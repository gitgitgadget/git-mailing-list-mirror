From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v3 1/3] git-completion.bash: Autocomplete --minimal and --histogram for git-diff
Date: Wed, 16 Jan 2013 08:51:56 +0100
Message-ID: <6f036d7e14a214e770edf32cb0e015999ba98d85.1358322212.git.mprivozn@redhat.com>
References: <cover.1358322212.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 08:52:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvNnY-0006KG-74
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 08:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758675Ab3APHwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 02:52:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40589 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758657Ab3APHwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 02:52:14 -0500
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0G7q31K021858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 16 Jan 2013 02:52:03 -0500
Received: from bart.brq.redhat.com (dhcp-27-249.brq.redhat.com [10.34.27.249])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0G7pxJW019996;
	Wed, 16 Jan 2013 02:52:02 -0500
In-Reply-To: <cover.1358322212.git.mprivozn@redhat.com>
In-Reply-To: <cover.1358322212.git.mprivozn@redhat.com>
References: <cover.1358322212.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213734>

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
