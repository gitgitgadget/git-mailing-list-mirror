From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 10/16] git-checkout: pass --submodules option to git-read-tree
Date: Sat, 19 May 2007 02:36:55 +0200
Message-ID: <20070519003655.GB4489@pasky.or.cz>
References: <11795163053812-git-send-email-skimo@liacs.nl> <11795163073176-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 02:37:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCwQ-0005gZ-Fx
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbXESAg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 20:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbXESAg5
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:36:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48299 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbXESAg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 20:36:57 -0400
Received: (qmail 23964 invoked by uid 2001); 19 May 2007 02:36:55 +0200
Content-Disposition: inline
In-Reply-To: <11795163073176-git-send-email-skimo@liacs.nl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47697>

On Fri, May 18, 2007 at 09:24:59PM CEST, skimo@liacs.nl wrote:
> From: Sven Verdoolaege <skimo@kotnet.org>
> 
> Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
> ---
>  git-checkout.sh |   20 +++++++++++++++-----
>  1 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/git-checkout.sh b/git-checkout.sh
> index 6b6facf..cbb1f00 100755
> --- a/git-checkout.sh
> +++ b/git-checkout.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -USAGE='[-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
> +USAGE='[-q] [-f] [--submodules] [--no-submodules] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
>  SUBDIRECTORY_OK=Sometimes
>  . git-sh-setup
>  require_work_tree

Thus Documentation/git-checkout.txt needs to be updated as well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
