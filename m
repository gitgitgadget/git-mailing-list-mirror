From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] tag.c: remove extern keyword from function definition
Date: Wed, 20 Apr 2016 16:34:25 +0100
Message-ID: <5717A181.1000603@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Wed Apr 20 17:34:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asu9D-0006Ha-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 17:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbcDTPec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 11:34:32 -0400
Received: from avasout08.plus.net ([212.159.14.20]:57541 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbcDTPeb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 11:34:31 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout08 with smtp
	id kfaT1s0032D2Veb01faU3k; Wed, 20 Apr 2016 16:34:29 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O6PEx0JW c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=bODdSWX3Sw0OpkgCeiIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292029>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Santiago,

If you need to re-roll your 'st/verify-tag' branch, could you
please squash this into the relevant patch (commit c5213b40,
"verify-tag: move tag verification code to tag.c", 19-04-2016).

Although not actually an error, it is very unusual for an extern
keyword to be used on a function definition (it seems to be getting
quite unusual on a function declaration these days!), which causes
sparse to issue a warning.

Thanks!

ATB,
Ramsay Jones

 tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tag.c b/tag.c
index ace619a..93c6ae6 100644
--- a/tag.c
+++ b/tag.c
@@ -30,7 +30,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-extern int gpg_verify_tag(const unsigned char *sha1,
+int gpg_verify_tag(const unsigned char *sha1,
 		const char *name_to_report, unsigned flags)
 {
 	enum object_type type;
-- 
2.8.0
