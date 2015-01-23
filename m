From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 1/2] guilt graph: Simplify getfiles.
Date: Fri, 23 Jan 2015 09:36:37 -0500
Message-ID: <20150123143637.GH101465@meili.jeffnet.31bits.net>
References: <1422022867-7908-1-git-send-email-cederp@opera.com>
 <1422022867-7908-2-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:36:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEfLo-00034E-2H
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277AbbAWOgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:36:41 -0500
Received: from josefsipek.net ([71.174.113.7]:1645 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827AbbAWOgk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:36:40 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id 2219A55654;
	Fri, 23 Jan 2015 09:36:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1422022867-7908-2-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262938>

Neat.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Jan 23, 2015 at 03:21:06PM +0100, Per Cederqvist wrote:
> git diff-tree by default emits TAB-separated fields.  cut by defaults
> processes TAB-separated fields.  Simplify getfiles() by using TAB as
> the separator.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-graph | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/guilt-graph b/guilt-graph
> index 0857e0d..d90c2f1 100755
> --- a/guilt-graph
> +++ b/guilt-graph
> @@ -36,7 +36,7 @@ fi
>  
>  getfiles()
>  {
> -	git diff-tree -r "$1^" "$1" | tr '\t' ' ' | cut -d' ' -f6
> +	git diff-tree -r "$1^" "$1" | cut -f2
>  }
>  
>  cache="$GUILT_DIR/$branch/.graphcache.$$"
> -- 
> 2.1.0
> 

-- 
C is quirky, flawed, and an enormous success.
		- Dennis M. Ritchie.
