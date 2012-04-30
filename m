From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] [PATCH] The tests should not fail if log.date or
 log.decorate are set.
Date: Mon, 30 Apr 2012 11:04:57 -0400
Message-ID: <20120430150457.GD20761@poseidon.cudanet.local>
References: <87mx5t349e.fsf@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ceder@lysator.liu.se
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 17:14:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOsIm-0003dR-0h
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866Ab2D3POF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 11:14:05 -0400
Received: from josefsipek.net ([64.9.206.49]:58344 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415Ab2D3POE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 11:14:04 -0400
Received: from poseidon.cudanet.local (unknown [12.200.95.45])
	by josefsipek.net (Postfix) with ESMTPSA id 60601AF8BF;
	Mon, 30 Apr 2012 11:04:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87mx5t349e.fsf@opera.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196562>

On Mon, Apr 30, 2012 at 12:25:49PM +0200, Per Cederqvist wrote:
> Explicitly set log.date and log.decorate to their Git default values,
> so that git produces the expected output even if log.date and
> log.decorate are set by the user in his .gitconfig.

Looks good.

Jeff.

> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/scaffold |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/regression/scaffold b/regression/scaffold
> index b38a3f0..546d8c6 100644
> --- a/regression/scaffold
> +++ b/regression/scaffold
> @@ -83,6 +83,10 @@ function setup_git_repo
>  	git add def
>  	git commit -s -m "initial" 2> /dev/null > /dev/null
>  	# the commit should be d4850419ccc1146c7169f500725ce504b9774ed0
> +
> +	# Explicitly set config that the tests rely on.
> +	git config log.date default
> +	git config log.decorate no
>  }
>  
>  function setup_guilt_repo
> -- 
> 1.7.10
> 

-- 
OpenIndiana oi_151a3: 8 cores, 16 GB RAM
