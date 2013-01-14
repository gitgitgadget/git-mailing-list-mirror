From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v2 1/3] git-completion.bash: Autocomplete --minimal and --histogram for git-diff
Date: Mon, 14 Jan 2013 20:58:09 +0100
Message-ID: <7a505aa58ac34d98d19cb33771108ccd9f87d6de.1358193364.git.mprivozn@redhat.com>
References: <cover.1358193364.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, peff@peff.net, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 20:58:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuqBJ-00037x-RQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757719Ab3ANT60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:58:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756858Ab3ANT6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:58:25 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0EJwHp3011881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 14 Jan 2013 14:58:17 -0500
Received: from bart.brq.redhat.com (dhcp-27-249.brq.redhat.com [10.34.27.249])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0EJwDVm009934;
	Mon, 14 Jan 2013 14:58:16 -0500
In-Reply-To: <cover.1358193364.git.mprivozn@redhat.com>
In-Reply-To: <cover.1358193364.git.mprivozn@redhat.com>
References: <cover.1358193364.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213525>

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
