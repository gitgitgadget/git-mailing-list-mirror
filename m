From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] contrib/vim: add syntax highlighting file for commits
Date: Tue, 12 Sep 2006 23:12:08 -0700
Message-ID: <7vy7so9txj.fsf@assigned-by-dhcp.cox.net>
References: <20060911232249.GB29736@coredump.intra.peff.net>
	<20060912020813.GD26332@socrates.priv>
	<20060912023256.GA6596@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tom Prince <tom.prince@ualberta.net>
X-From: git-owner@vger.kernel.org Wed Sep 13 08:12:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNNyp-0000Jf-O3
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 08:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWIMGMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 02:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWIMGMJ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 02:12:09 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:18164 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751592AbWIMGMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 02:12:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913061208.QBTE6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 02:12:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MiBx1V0081kojtg0000000
	Wed, 13 Sep 2006 02:11:58 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060912023256.GA6596@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 11 Sep 2006 22:32:57 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26902>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 11, 2006 at 08:08:13PM -0600, Tom Prince wrote:
>
>> > +  1. Copy commit-syntax.vim to vim's syntax directory:
>> > +     $ cp commit-syntax.vim $HOME/.vim/syntax/gitcommit.vim
>> It would be more obvious if you could do cp gitcomit.vim $HOME/.vim/syntax/
>
> It would be with only one file, but you could just as easily have a
> .vim/ftplugin/gitcommit.vim file (I think there are others, too). If you
> want to give it the "proper" name, it should probably be
> syntax/gitcommit.vim.

I am not a vim user, but my reading of Tom's comment is that he
thinks it would have been nicer if the file the patch adds were
named gitcommit.vim, not commit-syntax.vim.  As you seem to
agree that the preferred name for this file when deployed is
gitcommit.vim, how about something like this on top of your
patch perhaps?


diff --git a/contrib/vim/README b/contrib/vim/README
index bad0a05..f574cc8 100644
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -1,6 +1,6 @@
 To syntax highlight git's commit messages, you need to:
-  1. Copy commit-syntax.vim to vim's syntax directory:
-     $ cp commit-syntax.vim $HOME/.vim/syntax/gitcommit.vim
+  1. Copy gitcommit.vim to vim's syntax directory:
+     $ cp gitcommit.vim $HOME/.vim/syntax/
   2. Auto-detect the editing of git commit files:
      $ cat >>$HOME/.vimrc <<'EOF'
      autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
diff --git a/contrib/vim/commit-syntax.vim b/contrib/vim/gitcommit.vim
similarity index 100%
rename from contrib/vim/commit-syntax.vim
rename to contrib/vim/gitcommit.vim
