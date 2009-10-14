From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/4] fix indentation depth for git diff --submodule-summary
Date: Wed, 14 Oct 2009 20:31:10 +0200
Message-ID: <4AD618EE.8070102@web.de>
References: <7vfx9pmhae.fsf@alter.siamese.dyndns.org> <4AD61880.4040600@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 14 20:32:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1My8dn-0008HS-8h
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 20:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbZJNSbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 14:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbZJNSbs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 14:31:48 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55923 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbZJNSbr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 14:31:47 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id ECE24130AEAFB;
	Wed, 14 Oct 2009 20:31:10 +0200 (CEST)
Received: from [80.128.106.100] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1My8cw-0003Rn-00; Wed, 14 Oct 2009 20:31:10 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090812)
In-Reply-To: <4AD61880.4040600@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+E5CfAbk4iLnQpjWBGGS+4lwyv4q9Ga8G2XGSZ
	suznlC1gqgXDyQ2yFfxiQj8SLsetokbRqIXXH6Ci2VwZWMYkiU
	xKmxUsw3juP8NY2+Nm6Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130313>

Indentation depth was 4, but submodule summary uses 2 as other shortlogs
do too.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 submodule.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index 129583b..5076113 100644
--- a/submodule.c
+++ b/submodule.c
@@ -42,7 +42,7 @@ void show_submodule_summary(FILE *f, const char *path,
 	struct commit_list *merge_bases, *list;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
-	static const char *format = "    %m %s";
+	static const char *format = "  %m %s";
 	int fast_forward = 0, fast_backward = 0;

 	if (add_submodule_odb(path))
-- 
1.6.5.4.g707c
