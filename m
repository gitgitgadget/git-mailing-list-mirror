From: Jeff King <peff@peff.net>
Subject: [PATCH] git-annotate: remove extraneous debugging line
Date: Wed, 2 Aug 2006 12:34:44 -0400
Message-ID: <20060802163444.GB22107@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 18:42:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8JnS-0006kf-Qb
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 18:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWHBQmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 12:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWHBQmL
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 12:42:11 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:60828 "HELO
	peff.net") by vger.kernel.org with SMTP id S932098AbWHBQmK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 12:42:10 -0400
Received: (qmail 5164 invoked from network); 2 Aug 2006 12:34:09 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 2 Aug 2006 12:34:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed,  2 Aug 2006 12:34:44 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24656>

Signed-off-by: Jeff King <peff@peff.net>
---
 git-annotate.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/git-annotate.perl b/git-annotate.perl
index 6db2f48..505b5cc 100755
--- a/git-annotate.perl
+++ b/git-annotate.perl
@@ -317,7 +317,6 @@ sub _git_diff_parse {
 
 			$gotheader = 1;
 
-			printf("Copying from %d to %d\n", $ri, $remstart);
 			foreach my $parent (@$parents) {
 				for (my $i = $ri; $i < $remstart; $i++) {
 					$plines{$parent}[$pi{$parent}++] = $slines->[$i];
-- 
1.4.2.rc2.g59706-dirty
