From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 18/28] guilt-graph: Handle commas in branch names.
Date: Tue, 6 May 2014 16:13:10 -0400
Message-ID: <20140506201310.GO1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-19-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:26:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whljj-0000dE-Si
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbaEFUNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 16:13:07 -0400
Received: from josefsipek.net ([64.9.206.49]:1575 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750982AbaEFUNG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 16:13:06 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 036A355654;
	Tue,  6 May 2014 16:13:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-19-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248240>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Mar 21, 2014 at 08:31:56AM +0100, Per Cederqvist wrote:
> This fix relies on the fact that git branch names can not contain ":".
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-graph | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/guilt-graph b/guilt-graph
> index 00301d5..575f03b 100755
> --- a/guilt-graph
> +++ b/guilt-graph
> @@ -52,7 +52,7 @@ safebranch=`echo "$branch"|sed 's%/%\\\\/%g'`
>  while [ "$current" != "$base" ]; do
>  	pname=`git show-ref | sed -n -e "
>  /^$current refs\/patches\/$safebranch/ {
> -	s,^$current refs/patches/$branch/,,
> +	s:^$current refs/patches/$branch/::
>  	p
>  	q
>  }"`
> -- 
> 1.8.3.1
> 

-- 
Computer Science is no more about computers than astronomy is about
telescopes.
		- Edsger Dijkstra
