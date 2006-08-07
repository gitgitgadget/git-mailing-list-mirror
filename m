From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Remove unused variables in git_shortlog_body and git_heads
Date: Tue, 8 Aug 2006 01:15:05 +0200
Message-ID: <200608080115.05684.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 08 01:25:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAETZ-0007YT-O8
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 01:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbWHGXZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 19:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWHGXZe
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 19:25:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:4841 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932336AbWHGXZd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 19:25:33 -0400
Received: by nf-out-0910.google.com with SMTP id x37so12456nfc
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 16:25:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=PqD9pwLdmcxVFdySEUN/pacLetAWScv3J3N64ehpyGfu2n/7Gc3BS8YWr7vodA+l0sAbSiHtftb1+YOIkyP76lfBOBZJw27gusq6s7W0ZJfJv7sTIOMuEVuFmPJzEa2yeAjPLdtPf4kPSXDI8RlYI0jIsjjWcBr0sua4TSYfO7M=
Received: by 10.48.242.19 with SMTP id p19mr85272nfh;
        Mon, 07 Aug 2006 16:15:00 -0700 (PDT)
Received: from host-81-190-31-92.torun.mm.pl ( [81.190.31.92])
        by mx.gmail.com with ESMTP id z73sm22486nfb.2006.08.07.16.14.59;
        Mon, 07 Aug 2006 16:14:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25053>


Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Cleanup.

 gitweb/gitweb.perl |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b3bfc6b..eabece7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1065,7 +1065,6 @@ sub git_shortlog_body {
 		#my $ref = defined $refs ? git_get_referencing($refs, $commit) : '';
 		my $ref = git_get_referencing($refs, $commit);
 		my %co = git_read_commit($commit);
-		my %ad = date_str($co{'author_epoch'});
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
@@ -1638,7 +1637,6 @@ sub git_heads {
 	git_header_div('summary', $project);
 
 	my $taglist = git_read_refs("refs/heads");
-	my $alternate = 0;
 	if (defined @$taglist) {
 		git_heads_body($taglist, $head);
 	}
-- 
1.4.1.1
