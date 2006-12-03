X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document git-diff whitespace flags -b and -w
Date: Sun, 3 Dec 2006 20:10:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612032006580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11651630814064-git-send-email-jnareb@gmail.com>
 <Pine.LNX.4.63.0612031908020.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <ekv5k6$1ih$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 19:10:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <ekv5k6$1ih$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33130>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqwjB-0005IC-7K for gcvg-git@gmane.org; Sun, 03 Dec
 2006 20:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760011AbWLCTKO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 14:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760012AbWLCTKO
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 14:10:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:6317 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1760011AbWLCTKM (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 14:10:12 -0500
Received: (qmail invoked by alias); 03 Dec 2006 19:10:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 03 Dec 2006 20:10:10 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 3 Dec 2006, Jakub Narebski wrote:

> Alternate solution would be to fix documentation, to document existing 
> code. I used GNU diff documentation, perhaps it is better if we are GNU 
> diff compatibile...

Since the whole point of "-w/-b" is to steal the nice feature from GNU 
diff, it does not make any sense breaking compatibility.

BTW on top of my patch you need this, if you want the tests to pass 
(danger ahead: intentional white space at eol):

-- snip --
make tests pass for recent "diff -b" change

---

	Am I the only one finding it funny to read diffs of diffs, 
	especially when being used to combined diffs?

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 1bc5b7a..adf4993 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -109,12 +109,10 @@ index d99af23..8b32fb5 100644
 +	whitespace at beginning
  whitespace change
 -whitespace in the middle
--whitespace at end
 +white space in the middle
-+whitespace at end  
+ whitespace at end
  unchanged line
--CR at endQ
-+CR at end
+ CR at endQ
 EOF
 git-diff -b > out
