From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Documentation: improve description of "git reset
	--keep"
Date: Tue, 9 Mar 2010 06:43:46 +0100
Message-ID: <20100309054345.GC4827@m62s10.vlinux.de>
References: <20100309015117.10202.28588.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:32:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyV7-0001Do-Db
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152Ab0CIFn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 00:43:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:47912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750737Ab0CIFn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 00:43:56 -0500
Received: (qmail invoked by alias); 09 Mar 2010 05:43:54 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp054) with SMTP; 09 Mar 2010 06:43:54 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19AYUZzQbJAlRR8tNOh2EoTG3ZUO0EqWAvRH3vg9L
	Ig5EyErE4bffns
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id EC32BD4001; Tue,  9 Mar 2010 06:43:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100309015117.10202.28588.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141811>

On Tue, Mar 09, 2010 at 02:51:16AM +0100, Christian Couder wrote:
> From: Junio C Hamano <gitster@pobox.com>
> 
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-reset.txt |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 58d9b4c..645f0c1 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -53,9 +53,12 @@ OPTIONS
>  	and the current commit in the working tree.
>  
>  --keep::
> -	Resets the index to match the tree recorded by the named commit,
> -	but keep changes in the working tree. Aborts if the reset would
> -	change files that are already modified in the working tree.
> +	Reset the index to the given commit, keeping local changes in
> +	the working tree since the current commit, while updating
> +	working tree files without local changes to what appears in
> +	the given commit.  If a file that is different between the
> +	current commit and the given commit has local changes, reset
> +	is aborted.
>  
>  -p::
>  --patch::

Acked-by: Peter Baumann <waste.manager@gmx.de>
