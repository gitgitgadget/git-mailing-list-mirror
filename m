From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual.txt: fix a few mistakes
Date: Wed, 14 Nov 2007 13:18:58 -0500
Message-ID: <20071114181858.GH14254@fieldses.org>
References: <87bq9x7w4d.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 19:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsMpm-00085w-Da
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 19:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082AbXKNSTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 13:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbXKNSTA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 13:19:00 -0500
Received: from mail.fieldses.org ([66.93.2.214]:49364 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686AbXKNSS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 13:18:59 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IsMpG-0007WE-JK; Wed, 14 Nov 2007 13:18:58 -0500
Content-Disposition: inline
In-Reply-To: <87bq9x7w4d.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64995>

On Tue, Nov 13, 2007 at 09:19:39PM +0300, Sergei Organov wrote:
> 
> Signed-off-by: Sergei Organov <osv@javad.com>
> ---
>  Documentation/user-manual.txt |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index d99adc6..a169ef0 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -475,7 +475,7 @@ Bisecting: 3537 revisions left to test after this
>  If you run "git branch" at this point, you'll see that git has
>  temporarily moved you to a new branch named "bisect".  This branch
>  points to a commit (with commit id 65934...) that is reachable from
> -v2.6.19 but not from v2.6.18.  Compile and test it, and see whether
> +"master" but not from v2.6.18.  Compile and test it, and see whether
>  it crashes.  Assume it does crash.  Then:
>  
>  -------------------------------------------------
> @@ -1367,7 +1367,7 @@ If you make a commit that you later wish you hadn't, there are two
>  fundamentally different ways to fix the problem:
>  
>  	1. You can create a new commit that undoes whatever was done
> -	by the previous commit.  This is the correct thing if your
> +	by the old commit.  This is the correct thing if your
>  	mistake has already been made public.
>  
>  	2. You can go back and modify the old commit.  You should
> @@ -1567,8 +1567,8 @@ old history using, for example,
>  $ git log master@{1}
>  -------------------------------------------------
>  
> -This lists the commits reachable from the previous version of the head.
> -This syntax can be used to with any git command that accepts a commit,

I actually prefer "head" here.  On something like:

		 A--B--C
		/
	o--o--o
		\
		 o--o--o


The term "branch" could be used to refer to the whole line of
development consisting of A, B, and C.  The term "head", on the other
hand, refers to either C or a ref that points to it.  We also use the
terms "branch head" or just "branch" for that case, but I think "head"
is more precise.

> +This lists the commits reachable from the previous version of the branch.
> +This syntax can be used with any git command that accepts a commit,
>  not just with git log.  Some other examples:

(Otherwise looks fine, thanks!)

--b.
