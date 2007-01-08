From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: clarify glossary definition of "reachable"
Date: Sun, 07 Jan 2007 17:44:01 -0800
Message-ID: <7vvejiz40u.fsf@assigned-by-dhcp.cox.net>
References: <20070108002839.GF18009@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 02:44:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3jYY-0006m3-76
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 02:44:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbXAHBoH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 20:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbXAHBoH
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 20:44:07 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:45275 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030416AbXAHBoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 20:44:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108014403.IMJQ15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 7 Jan 2007 20:44:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8RjD1W0071kojtg0000000; Sun, 07 Jan 2007 20:43:14 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070108002839.GF18009@fieldses.org> (J. Bruce Fields's message
	of "Sun, 7 Jan 2007 19:28:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36216>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> Clarify glossary definition of "reachable" (what chain?)
>
> Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
> ---
>  Documentation/glossary.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
> index 7c1a659..5886fa7 100644
> --- a/Documentation/glossary.txt
> +++ b/Documentation/glossary.txt
> @@ -236,7 +236,7 @@ push::
>  
>  reachable::
>  	An object is reachable from a ref/commit/tree/tag, if there is a
> -	chain leading from the latter to the former.
> +	chain of parent commits leading from the latter to the former.

That is better but the description is too commit centric.

        The set of reachable objects from a tag is the tag
        itself and the set of reachable objects from the object
        it tags.  The set of reachable objects from a commit is
        the commit itself, and the set of reachable objects from
        its parents and its tree.  The set of reachable objects
        from a tree is the tree itself, and the set of reachable
        objects from the trees and blobs contained within it.
        The set of reachable objects from a blob is the blob
        itself.

And that description is too verbose and too technical
(definition being recursive).  Better rewording?
