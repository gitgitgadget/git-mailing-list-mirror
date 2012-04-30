From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] [PATCH] Testsuite: get rid of "Broken pipe" errors from
 yes.
Date: Mon, 30 Apr 2012 11:06:55 -0400
Message-ID: <20120430150655.GE20761@poseidon.cudanet.local>
References: <87k40x346u.fsf@opera.com>
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
	id 1SOsIl-0003dR-Gh
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 17:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab2D3POG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 11:14:06 -0400
Received: from josefsipek.net ([64.9.206.49]:58343 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968Ab2D3POE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 11:14:04 -0400
Received: from poseidon.cudanet.local (unknown [12.200.95.45])
	by josefsipek.net (Postfix) with ESMTPSA id 7AF80AF9E0;
	Mon, 30 Apr 2012 11:06:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87k40x346u.fsf@opera.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196563>

On Mon, Apr 30, 2012 at 12:27:21PM +0200, Per Cederqvist wrote:
>

Looks good.  Interestingly, I haven't seen those errors before.  What's your
setup like?

Jeff.

> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-029.sh |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/regression/t-029.sh b/regression/t-029.sh
> index 83e1d2b..09450c6 100755
> --- a/regression/t-029.sh
> +++ b/regression/t-029.sh
> @@ -21,11 +21,11 @@ echo | shouldfail guilt repair --full
>  
>  cmd list_files
>  
> -yes n | shouldfail guilt repair --full
> +yes n 2>/dev/null | shouldfail guilt repair --full
>  
>  cmd list_files
>  
> -yes y | cmd guilt repair --full
> +yes y 2>/dev/null | cmd guilt repair --full
>  
>  cmd list_files
>  
> @@ -33,6 +33,6 @@ cmd guilt push -a
>  
>  cmd list_files
>  
> -yes Y | cmd guilt repair --full
> +yes Y 2>/dev/null | cmd guilt repair --full
>  
>  cmd list_files
> -- 
> 1.7.10
> 

-- 
You measure democracy by the freedom it gives its dissidents, not the
freedom it gives its assimilated conformists.
		- Abbie Hoffman
