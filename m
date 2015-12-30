From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] dir.h: remove orphaned declaration
Date: Wed, 30 Dec 2015 17:11:41 +0000
Message-ID: <5684104D.6000001@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 18:13:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEKJ5-0004Gh-Ui
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 18:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091AbbL3RNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 12:13:00 -0500
Received: from avasout07.plus.net ([84.93.230.235]:46955 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbbL3RM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 12:12:58 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id ztBj1r0064mu3xa01tBk4B; Wed, 30 Dec 2015 17:11:45 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MZKRwMLf c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=iSRSRv9M13OCdgcdhqwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283188>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Christian,

If you need to re-roll your 'cc/untracked' branch, could you
please squash this into your patches.

You seem to have only half applied my last fixup patch! ;-)
(I'm guessing that you had already renamed the function
locally before I sent the fixup).

Thanks!

ATB,
Ramsay Jones

 dir.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/dir.h b/dir.h
index 3e5114d..85286e5 100644
--- a/dir.h
+++ b/dir.h
@@ -307,7 +307,6 @@ void untracked_cache_add_to_index(struct index_state *, const char *);
 void free_untracked_cache(struct untracked_cache *);
 struct untracked_cache *read_untracked_extension(const void *data, unsigned long sz);
 void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
-void add_untracked_ident(struct untracked_cache *);
 void add_untracked_cache(void);
 void remove_untracked_cache(void);
 #endif
-- 
2.6.0
