From: Stephen Kelly <steveire@gmail.com>
Subject: No way to resolve git am conflicts.
Date: Sat, 08 Jan 2011 14:11:54 +0100
Message-ID: <ig9nqq$4ib$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 14:12:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbYac-0003rx-Uq
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 14:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab1AHNMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 08:12:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:57242 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115Ab1AHNMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 08:12:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PbYaU-0003kC-Ty
	for git@vger.kernel.org; Sat, 08 Jan 2011 14:12:06 +0100
Received: from dslb-092-078-138-003.pools.arcor-ip.net ([92.78.138.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 14:12:06 +0100
Received: from steveire by dslb-092-078-138-003.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 14:12:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-092-078-138-003.pools.arcor-ip.net
User-Agent: KNode/4.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164819>


kde-devel@bishop:~/dev/src/git{master}$ curl -o the.patch 
http://download.gmane.org/gmane.comp.version-control.git/164809/164810 && 
git am the.patch
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  
Current
                                 Dload  Upload   Total   Spent    Left  
Speed
100 10438    0 10438    0     0  12046      0 --:--:-- --:--:-- --:--:-- 
13451
Applying: Introduce new configuation option to override committer 
information
error: patch failed: builtin/commit.c:1352
error: builtin/commit.c: patch does not apply
Patch failed at 0001 Introduce new configuation option to override committer 
information
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".
Qt( 4.7 ) KDE ( 4.6 ) 
kde-devel@bishop:~/dev/src/git{master}$ git diff
Qt( 4.7 ) KDE ( 4.6 ) 
kde-devel@bishop:~/dev/src/git{master}$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       p.patch
#       the.patch
nothing added to commit but untracked files present (use "git add" to track)
Qt( 4.7 ) KDE ( 4.6 ) 
kde-devel@bishop:~/dev/src/git{master}$ 

As git status doesn't tell me what the conflict is, I can't resolve it.
