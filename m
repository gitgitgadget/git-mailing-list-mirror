From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 1/5] Documentation: removed some uses of the passive
	voice in git-bisect.txt.
Date: Tue, 24 Mar 2009 18:02:01 -0400
Message-ID: <20090324220201.GM19389@fieldses.org>
References: <1237770017-7168-2-git-send-email-dmellor@whistlingcat.com> <20090323031906.85EB117A4B@sandstone.whistlingcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: "David J. Mellor" <dmellor@whistlingcat.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:04:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmEjH-0007RT-Ld
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099AbZCXWCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 18:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbZCXWCJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:02:09 -0400
Received: from mail.fieldses.org ([141.211.133.115]:42155 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbZCXWCH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 18:02:07 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1LmEh7-0006Kq-SY; Tue, 24 Mar 2009 18:02:01 -0400
Content-Disposition: inline
In-Reply-To: <20090323031906.85EB117A4B@sandstone.whistlingcat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114497>

On Sun, Mar 22, 2009 at 08:11:10PM -0700, David J. Mellor wrote:
> 
> Signed-off-by: David J. Mellor <dmellor@whistlingcat.com>
> ---
> Amended to drop spurious uses of "you" as suggested in:
> 
> http://article.gmane.org/gmane.comp.version-control.git/114210
> 
>  Documentation/git-bisect.txt |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
> index 93d9fc0..a356a2b 100644
> --- a/Documentation/git-bisect.txt
> +++ b/Documentation/git-bisect.txt
> @@ -81,7 +81,7 @@ will have been left with the first bad kernel revision in "refs/bisect/bad".
>  Bisect reset
>  ~~~~~~~~~~~~
>  
> -To return to the original head after a bisect session, you issue the
> +To return to the original head after a bisect session, issue the
>  following command:
>  
>  ------------------------------------------------
> @@ -95,8 +95,8 @@ the bisection state).
>  Bisect visualize
>  ~~~~~~~~~~~~~~~~
>  
> -To see the currently remaining suspects in 'gitk', the following command
> -is issued during the bisection process:
> +To see the currently remaining suspects in 'gitk', issue the following
> +command during the bisection process:
>  
>  ------------
>  $ git bisect visualize
> @@ -115,7 +115,7 @@ $ git bisect view --stat
>  Bisect log and bisect replay
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -After having marked revisions as good or bad, you issue the following
> +After having marked revisions as good or bad, issue the following
>  command to show what has been done so far:
>  
>  ------------
> @@ -135,7 +135,7 @@ $ git bisect replay that-file
>  Avoiding testing a commit
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> -If in the middle of a bisect session, you know that the next suggested
> +If, in the middle of a bisect session, you know that the next suggested
>  revision is not a good one to test (e.g. the change the commit
>  introduces is known not to work in your environment and you know it
>  does not have anything to do with the bug you are chasing), you may
> @@ -151,8 +151,8 @@ $ git reset --hard HEAD~3		# try 3 revisions before what
>  					# was suggested
>  ------------
>  
> -Then compile and test the chosen revision. Afterwards the revision
> -is marked as good or bad in the usual manner.
> +Then you compile and test the chosen revision. Afterwards you mark

Two "you"'s got added here?

> +the revision as good or bad in the usual manner.
>  
>  Bisect skip
>  ~~~~~~~~~~~~
> @@ -175,8 +175,8 @@ using the "'<commit1>'..'<commit2>'" notation. For example:
>  $ git bisect skip v2.5..v2.6
>  ------------
>  
> -The effect of this would be that no commit between `v2.5` excluded and
> -`v2.6` included could be tested.
> +This tells the bisect process that no commit between `v2.5` excluded and
> +`v2.6` included should be tested.

Slightly more straightforward: "This tells git not to test any commit in
the range v2.5..v2.6."  (But I'm assuming they already know git's
defition of ranges: if you think the reminder's necessary, some other
way to word it might be better; the "exlcuded"/"included" thing is a
little odd.  Maybe replace by "exclusive"/"inclusive", or do something
like "after v2.5, up to and including v2.6".)

--b.

>  
>  Note that if you also want to skip the first commit of the range you
>  would issue the command:
> @@ -185,8 +185,8 @@ would issue the command:
>  $ git bisect skip v2.5 v2.5..v2.6
>  ------------
>  
> -This would cause the commits between `v2.5` included and `v2.6` included
> -to be skipped.
> +This tells the bisect process that the commits between `v2.5` included
> +and `v2.6` included should be skipped.
>  
>  
>  Cutting down bisection by giving more parameters to bisect start
> -- 
> 1.6.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
