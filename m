From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/9] gitweb: Use undef for die_error to use default first (status) parameter value
Date: Sat, 05 Aug 2006 12:56:42 +0200
Organization: At home
Message-ID: <eb1tfv$6kf$3@sea.gmane.org>
References: <200608050036.06490.jnareb@gmail.com> <200608050038.20534.jnareb@gmail.com> <7vu04sghr0.fsf@assigned-by-dhcp.cox.net> <eb0oiu$sj1$1@sea.gmane.org> <44d47813.36251c31.2553.3cf7@mx.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Aug 05 13:00:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9JtF-0000FT-MF
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 13:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161427AbWHELAS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 07:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161481AbWHELAS
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 07:00:18 -0400
Received: from main.gmane.org ([80.91.229.2]:9158 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161427AbWHELAQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Aug 2006 07:00:16 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G9Jsv-0000Bi-SH
	for git@vger.kernel.org; Sat, 05 Aug 2006 13:00:04 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:00:01 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 13:00:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24901>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
For consistency.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6feec28..9b9bf37 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2320,7 +2320,7 @@ sub git_history {
 
 sub git_search {
        if (!defined $searchtext) {
-               die_error("", "Text field empty.");
+               die_error(undef, "Text field empty.");
        }
        if (!defined $hash) {
                $hash = git_read_head($project);
-- 
1.4.1.1
