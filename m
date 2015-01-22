From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v4 33/33] Document the exit status of guilt push and
 guilt pop.
Date: Thu, 22 Jan 2015 09:31:49 -0500
Message-ID: <20150122143148.GE101460@meili.jeffnet.31bits.net>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
 <1400450409-30998-34-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 15:32:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEIng-0000wM-EQ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 15:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbbAVOby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 09:31:54 -0500
Received: from josefsipek.net ([71.174.113.7]:1698 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbbAVObw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 09:31:52 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id C61025567A;
	Thu, 22 Jan 2015 09:31:50 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1400450409-30998-34-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262837>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


Ok, I think this is all of the patches.  I'll wait for you to tell me if the
cmd() echo to printf change breaks anything for you.  If not, I'll pull your
series (via git), tag a 0.36-rc1, and push the whole thing to repo.or.cz. :)

Sorry for making this take so long :(

Jeff.

On Mon, May 19, 2014 at 12:00:09AM +0200, Per Cederqvist wrote:
> ---
>  Documentation/guilt-pop.txt  | 3 +++
>  Documentation/guilt-push.txt | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/guilt-pop.txt b/Documentation/guilt-pop.txt
> index 36fea9e..b0b89cc 100644
> --- a/Documentation/guilt-pop.txt
> +++ b/Documentation/guilt-pop.txt
> @@ -26,6 +26,9 @@ OPTIONS
>  
>  If no patchname is given, pop the top-most patch.
>  
> +Exit with a non-zero exit status if requested to pop more patches
> +than there are on the stack.
> +
>  Author
>  ------
>  Written by Josef "Jeff" Sipek <jeffpc@josefsipek.net>
> diff --git a/Documentation/guilt-push.txt b/Documentation/guilt-push.txt
> index 6ee86b9..6439f21 100644
> --- a/Documentation/guilt-push.txt
> +++ b/Documentation/guilt-push.txt
> @@ -26,6 +26,9 @@ OPTIONS
>  
>  If no patchname is given, push the next patch in the series onto the tree.
>  
> +Exit with a non-zero exit status if requested to push more patches
> +than there are in the series.
> +
>  Author
>  ------
>  Written by Josef "Jeff" Sipek <jeffpc@josefsipek.net>
> -- 
> 1.8.3.1
> 

-- 
Computer Science is no more about computers than astronomy is about
telescopes.
		- Edsger Dijkstra
