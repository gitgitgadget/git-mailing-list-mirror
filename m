From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] bash completion: Remove dashed command completion support
Date: Tue, 15 Jul 2008 05:58:06 +0000
Message-ID: <20080715055806.GA3519@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 07:59:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIdZ7-0001Ob-7i
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 07:59:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbYGOF6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 01:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbYGOF6I
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 01:58:08 -0400
Received: from george.spearce.org ([209.20.77.23]:34377 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbYGOF6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 01:58:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 33C0F3836B; Tue, 15 Jul 2008 05:58:06 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88528>

Since only 'git' and 'gitk' are in the user's $PATH now we do not
expect users to need completion support for git-fetch, and expect
they will instead rely upon the completion support for 'git fetch'.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   53 --------------------------------
 1 files changed, 0 insertions(+), 53 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5844804..0e493a4 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1440,64 +1440,11 @@ _gitk ()
 
 complete -o default -o nospace -F _git git
 complete -o default -o nospace -F _gitk gitk
-complete -o default -o nospace -F _git_am git-am
-complete -o default -o nospace -F _git_apply git-apply
-complete -o default -o nospace -F _git_bisect git-bisect
-complete -o default -o nospace -F _git_branch git-branch
-complete -o default -o nospace -F _git_bundle git-bundle
-complete -o default -o nospace -F _git_checkout git-checkout
-complete -o default -o nospace -F _git_cherry git-cherry
-complete -o default -o nospace -F _git_cherry_pick git-cherry-pick
-complete -o default -o nospace -F _git_commit git-commit
-complete -o default -o nospace -F _git_describe git-describe
-complete -o default -o nospace -F _git_diff git-diff
-complete -o default -o nospace -F _git_fetch git-fetch
-complete -o default -o nospace -F _git_format_patch git-format-patch
-complete -o default -o nospace -F _git_gc git-gc
-complete -o default -o nospace -F _git_log git-log
-complete -o default -o nospace -F _git_ls_remote git-ls-remote
-complete -o default -o nospace -F _git_ls_tree git-ls-tree
-complete -o default -o nospace -F _git_merge git-merge
-complete -o default -o nospace -F _git_merge_base git-merge-base
-complete -o default -o nospace -F _git_name_rev git-name-rev
-complete -o default -o nospace -F _git_pull git-pull
-complete -o default -o nospace -F _git_push git-push
-complete -o default -o nospace -F _git_rebase git-rebase
-complete -o default -o nospace -F _git_config git-config
-complete -o default -o nospace -F _git_remote git-remote
-complete -o default -o nospace -F _git_reset git-reset
-complete -o default -o nospace -F _git_shortlog git-shortlog
-complete -o default -o nospace -F _git_show git-show
-complete -o default -o nospace -F _git_stash git-stash
-complete -o default -o nospace -F _git_submodule git-submodule
-complete -o default -o nospace -F _git_svn git-svn
-complete -o default -o nospace -F _git_log git-show-branch
-complete -o default -o nospace -F _git_tag git-tag
-complete -o default -o nospace -F _git_log git-whatchanged
 
 # The following are necessary only for Cygwin, and only are needed
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
 if [ Cygwin = "$(uname -o 2>/dev/null)" ]; then
-complete -o default -o nospace -F _git_add git-add.exe
-complete -o default -o nospace -F _git_apply git-apply.exe
 complete -o default -o nospace -F _git git.exe
-complete -o default -o nospace -F _git_branch git-branch.exe
-complete -o default -o nospace -F _git_bundle git-bundle.exe
-complete -o default -o nospace -F _git_cherry git-cherry.exe
-complete -o default -o nospace -F _git_describe git-describe.exe
-complete -o default -o nospace -F _git_diff git-diff.exe
-complete -o default -o nospace -F _git_format_patch git-format-patch.exe
-complete -o default -o nospace -F _git_log git-log.exe
-complete -o default -o nospace -F _git_ls_tree git-ls-tree.exe
-complete -o default -o nospace -F _git_merge_base git-merge-base.exe
-complete -o default -o nospace -F _git_name_rev git-name-rev.exe
-complete -o default -o nospace -F _git_push git-push.exe
-complete -o default -o nospace -F _git_config git-config
-complete -o default -o nospace -F _git_shortlog git-shortlog.exe
-complete -o default -o nospace -F _git_show git-show.exe
-complete -o default -o nospace -F _git_log git-show-branch.exe
-complete -o default -o nospace -F _git_tag git-tag.exe
-complete -o default -o nospace -F _git_log git-whatchanged.exe
 fi
-- 
1.5.6.2.393.g45096
