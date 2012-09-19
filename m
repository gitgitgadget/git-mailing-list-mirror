From: Drew Northup <n1xim.email@gmail.com>
Subject: [PATCH] Documentation/git-blame.txt: --follow is a NO-OP
Date: Tue, 18 Sep 2012 22:48:25 -0400
Message-ID: <1348022905-10048-1-git-send-email-n1xim.email@gmail.com>
References: <20120906151317.GB7407@sigill.intra.peff.net>
Cc: Drew Northup <n1xim.email@gmail.com>, <Matthieu.Moy@imag.fr>,
	<andy@aeruder.net>, <chriscool@tuxfamily.org>,
	<dmellor@whistlingcat.com>, <dpmcgee@gmail.com>, <fonseca@diku.dk>,
	<freku045@student.liu.se>, <gitster@pobox.com>, <kevin@sb.org>,
	<marius@trolltech.com>, <namhyung@gmail.com>, <peff@peff.net>,
	<rene.scharfe@lsrfire.ath.cx>, <s-beyer@gmx.net>,
	<trast@inf.ethz.ch>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 04:49:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEALw-00016F-Lp
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 04:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab2ISCtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 22:49:21 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:52776 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435Ab2ISCtB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 22:49:01 -0400
Received: by qaas11 with SMTP id s11so604007qaa.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 19:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7mste0QLt6mPB+vE5gWMS2Ki1jyB3o8ZQd6+PwoVlHo=;
        b=JHyv4ytbWCJFhcrEn5uAFC589ny6DWP6k2Iz5gL+UllENk6UIPcoosrD2UwIqNFJdq
         MHRfLoDOeLxvOJKDUQmcmJrPojQvHAbpluPp7ps3oT6g9puxaHoCYoOv1g6ILC8XXP9r
         AxWXvRbnKDHLJOuoQK9rvI6CVsxM7On2k/bSJKlV7EbBgI+l8Foa0X6wENcIiP+7L1xh
         dTauPK+I0dsBvR+NhvD3Wu53BjFSdsY/LMVFCmFl7ERIj7nLtW09xytN6em7cdJnkNTK
         zC4dXOJiD6c0h1xwp43Kn2/nFhXhnnPtWNjuoNzVppSSTre1svlf7tfEBX1vGRzY+S/t
         hI8w==
Received: by 10.229.134.202 with SMTP id k10mr1196151qct.71.1348022940961;
        Tue, 18 Sep 2012 19:49:00 -0700 (PDT)
Received: from atom.sys-os.org (66-252-50-27.dyn-adsl.midmaine.net. [66.252.50.27])
        by mx.google.com with ESMTPS id ha5sm2311727qab.1.2012.09.18.19.48.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Sep 2012 19:49:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.54.g9e2116a
In-Reply-To: <20120906151317.GB7407@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205900>

Make note that while the --follow option is accepted by git blame it does
nothing.

Signed-off-by: Drew Northup <n1xim.email@gmail.com>
---
 Documentation/git-blame.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 7ee9236..7465bd8 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental] [-L n,m]
-	    [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>] [--abbrev=<n>]
+	    [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>] [--abbrev=<n>] [--follow]
 	    [<rev> | --contents <file> | --reverse <rev>] [--] <file>
 
 DESCRIPTION
@@ -78,6 +78,9 @@ include::blame-options.txt[]
 	abbreviated object name, use <n>+1 digits. Note that 1 column
 	is used for a caret to mark the boundary commit.
 
+--follow::
+        NO-OP accepted due to using the option parser also used by
+        'git log'
 
 THE PORCELAIN FORMAT
 --------------------
-- 
1.7.12.rc0.54.g9e2116a
