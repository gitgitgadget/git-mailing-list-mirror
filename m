From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] convert.c: mark a file-local function static
Date: Wed, 25 Nov 2015 21:50:01 +0000
Message-ID: <56562D09.70205@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 25 22:50:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1hxN-0003hq-Am
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 22:50:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbKYVu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 16:50:28 -0500
Received: from avasout08.plus.net ([212.159.14.20]:57574 "EHLO
	avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbKYVu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 16:50:27 -0500
Received: from [10.0.2.15] ([146.200.5.254])
	by avasout08 with smtp
	id lxq31r0035UqX4q01xq4rL; Wed, 25 Nov 2015 21:50:06 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bI7rW6KZ c=1 sm=1 tr=0
 a=GKs3PHufgjMgxBavMeQJCg==:117 a=GKs3PHufgjMgxBavMeQJCg==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=Ohs0rMpPL515yjzs9LoA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281745>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Torsten,

If you need to re-roll your 'tb/ls-files-eol' patch, could you
please squash this into the patch.

Thanks.

ATB,
Ramsay Jones

 convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/convert.c b/convert.c
index c99adcd..0595e21 100644
--- a/convert.c
+++ b/convert.c
@@ -118,7 +118,7 @@ static unsigned int gather_convert_stats(const char *data, unsigned long size)
 		return 0;
 }
 
-const char *gather_convert_stats_ascii(const char *data, unsigned long size)
+static const char *gather_convert_stats_ascii(const char *data, unsigned long size)
 {
 	unsigned int convert_stats = gather_convert_stats(data, size);
 
-- 
2.6.0
