From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] git-gui: fix typo in lib/blame.tcl
Date: Thu, 27 Sep 2007 14:53:25 +0200
Message-ID: <200709271453.25772.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 27 14:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iasp3-0006PA-Bb
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 14:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbXI0MuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 08:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbXI0MuV
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 08:50:21 -0400
Received: from slim-3c.inet.it ([213.92.5.125]:60770 "EHLO slim-3c.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754911AbXI0MuU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 08:50:20 -0400
Received: from host110-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.110]) by slim-3c.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.110+cUTmcw7jU9G; Thu, 27 Sep 2007 14:50:09 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59294>

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 lib/blame.tcl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index a911c3c..00ecf21 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -905,7 +905,7 @@ method _open_tooltip {cur_w} {
 		set author_time {}
 		catch {set author_name $header($cmit,author)}
 		catch {set summary     $header($cmit,summary)}
-		catch {set author_time [foramt_date $header($cmit,author-time)]}
+		catch {set author_time [format_date $header($cmit,author-time)]}
 
 		$tooltip_t insert end [strcat [mc "Originally By:"] "\n"] section_header
 		$tooltip_t insert end "commit $cmit\n"
-- 
1.5.3
