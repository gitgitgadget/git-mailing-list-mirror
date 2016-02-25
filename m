From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] fetch: mark a file-local symbol as static
Date: Thu, 25 Feb 2016 02:21:53 +0000
Message-ID: <56CE6541.7090609@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 03:22:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYlZD-0002x5-Ss
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 03:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759307AbcBYCWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 21:22:05 -0500
Received: from avasout01.plus.net ([84.93.230.227]:56024 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759222AbcBYCWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 21:22:03 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout01 with smtp
	id NSMy1s0054mu3xa01SN0tm; Thu, 25 Feb 2016 02:22:00 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=DT2vRQv2zoQgcDZAVAUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287312>


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Duy,

If you need to re-roll your 'nd/shallow-deepen' branch, could
you please squash this into the relevant patch (ie "fetch: define 
shallow boundary with --shallow-exclude", 23-02-2016).

Thanks!

ATB,
Ramsay Jones


 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1cf15d0..9bec031 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -42,7 +42,7 @@ static enum transport_family family;
 static const char *depth;
 static const char *deepen_since;
 static const char *upload_pack;
-struct string_list deepen_not = STRING_LIST_INIT_NODUP;
+static struct string_list deepen_not = STRING_LIST_INIT_NODUP;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
-- 
2.7.0
