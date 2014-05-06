From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 23/28] The log.decorate setting should not influence
 guilt rebase.
Date: Tue, 6 May 2014 16:41:59 -0400
Message-ID: <20140506204159.GT1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-24-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:43:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhmBc-0001jO-13
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755681AbaEFUl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 16:41:56 -0400
Received: from josefsipek.net ([64.9.206.49]:1672 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755208AbaEFUlz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 16:41:55 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 0509D55654;
	Tue,  6 May 2014 16:41:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-24-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248248>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Mar 21, 2014 at 08:32:01AM +0100, Per Cederqvist wrote:
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-rebase | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/guilt-rebase b/guilt-rebase
> index fd28e48..a1714a0 100755
> --- a/guilt-rebase
> +++ b/guilt-rebase
> @@ -66,7 +66,7 @@ pop_all_patches
>  git merge --no-commit $upstream > /dev/null 2> /dev/null
>  
>  disp ""
> -log=`git log -1 --pretty=oneline`
> +log=`git log -1 --no-decorate --pretty=oneline`
>  disp "HEAD is now at `echo $log | cut -c 1-7`... `echo "$log" | cut -c 41-`"
>  
>  #
> -- 
> 1.8.3.1
> 

-- 
Don't drink and derive. Alcohol and algebra don't mix.
