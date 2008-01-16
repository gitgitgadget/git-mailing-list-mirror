From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix and clarify grammar in git-merge docs.
Date: Wed, 16 Jan 2008 11:07:29 -0800
Message-ID: <7vd4s1r3m6.fsf@gitster.siamese.dyndns.org>
References: <1200460565-16797-1-git-send-email-dave@krondo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: dave@krondo.com
X-From: git-owner@vger.kernel.org Wed Jan 16 20:08:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFDcV-00020t-1k
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 20:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbYAPTHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 14:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752485AbYAPTHg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 14:07:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbYAPTHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 14:07:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 71F4E2EA0;
	Wed, 16 Jan 2008 14:07:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D25732E7F;
	Wed, 16 Jan 2008 14:07:31 -0500 (EST)
In-Reply-To: <1200460565-16797-1-git-send-email-dave@krondo.com>
	(dave@krondo.com's message of "Tue, 15 Jan 2008 21:16:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70723>

dave@krondo.com writes:

> From: Dave Peticolas <dave@krondo.com>
>
>
> Signed-off-by: Dave Peticolas <dave@krondo.com>
> ---
>  Documentation/git-merge.txt |   25 ++++++++++++-------------
>  1 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index ed3a924..abf63fe 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -74,19 +74,18 @@ it happens.  In other words, `git-diff --cached HEAD` must
>  report no changes.
>  
>  [NOTE]
> -This is a bit of lie.  In certain special cases, your index are
> -allowed to be different from the tree of `HEAD` commit.  The most
> -notable case is when your `HEAD` commit is already ahead of what
> -is being merged, in which case your index can have arbitrary
> -difference from your `HEAD` commit.  Otherwise, your index entries
> -are allowed have differences from your `HEAD` commit that match
> -the result of trivial merge (e.g. you received the same patch
> -from external source to produce the same result as what you are
> -merging).  For example, if a path did not exist in the common
> -ancestor and your head commit but exists in the tree you are
> -merging into your repository, and if you already happen to have
> -that path exactly in your index, the merge does not have to
> -fail.
> +This is a bit of a lie.  In certain special cases, your index is
> +allowed to be different from the tree of the `HEAD` commit.  The
> +most notable case is when your `HEAD` commit is already ahead of
> +what is being merged, in which case your index can have arbitrary
> +differences from your `HEAD` commit.  Also, your index entries may
> +have differences from your `HEAD` commit that match the result of
> +a trivial merge (e.g., you received the same patch from an external
> +source to produce the same result as what you are merging).  For example,
> +if a path did not exist in the common ancestor and your head commit
> +but exists in the tree you are merging into your repository, and if
> +you already happen to have that path exactly in your index, the merge
> +does not have to fail.

While checking and fixing the grammatical errors is very much
appreciated, line re-wrapping is not.  It makes it unnecessarily
cumbersome to see what got really changed.

Thanks anyway.  The changes look good.
