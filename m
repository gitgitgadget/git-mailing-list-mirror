From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 3/5] doc: don't use guilt-foo invocations in examples.
Date: Fri, 23 Jan 2015 09:25:45 -0500
Message-ID: <20150123142545.GC101465@meili.jeffnet.31bits.net>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
 <1422019499-2012-4-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:25:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEfBK-0003ke-KR
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495AbbAWOZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:25:50 -0500
Received: from josefsipek.net ([71.174.113.7]:1610 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbbAWOZs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:25:48 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id 0F14C55654;
	Fri, 23 Jan 2015 09:25:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1422019499-2012-4-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262933>

On Fri, Jan 23, 2015 at 02:24:57PM +0100, Per Cederqvist wrote:
> Note: there is one place where I replace guilt-repair with "guilt
> repair" instead of "+guilt repair+".  At least the version of docbook
> I'm using mishandles the "+" signs in that particular spot (even
> though it works properly for "+guilt select+" in another file.  I know
> too little docbook to be able to find the cause.

Yeah, a bit of a mystery to me too.  Regardless,

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  Documentation/guilt-add.txt    | 2 +-
>  Documentation/guilt-delete.txt | 2 +-
>  Documentation/guilt-diff.txt   | 2 +-
>  Documentation/guilt-help.txt   | 4 ++--
>  Documentation/guilt-new.txt    | 6 +++---
>  Documentation/guilt-repair.txt | 2 +-
>  Documentation/guilt-select.txt | 4 ++--
>  7 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/guilt-add.txt b/Documentation/guilt-add.txt
> index 6d2785a..a276f09 100644
> --- a/Documentation/guilt-add.txt
> +++ b/Documentation/guilt-add.txt
> @@ -24,7 +24,7 @@ EXAMPLES
>  Create and add a new file example.c
>  
>  	$ touch example.c
> -	$ guilt-add example.c
> +	$ guilt add example.c
>  
>  Author
>  ------
> diff --git a/Documentation/guilt-delete.txt b/Documentation/guilt-delete.txt
> index ef57dc6..4e8c28c 100644
> --- a/Documentation/guilt-delete.txt
> +++ b/Documentation/guilt-delete.txt
> @@ -25,7 +25,7 @@ EXAMPLES
>  --------
>  Delete a patch called 'foobar':
>  
> -	$ guilt-delete foobar
> +	$ guilt delete foobar
>  
>  Author
>  ------
> diff --git a/Documentation/guilt-diff.txt b/Documentation/guilt-diff.txt
> index 986ceca..0ee062c 100644
> --- a/Documentation/guilt-diff.txt
> +++ b/Documentation/guilt-diff.txt
> @@ -18,7 +18,7 @@ OPTIONS
>  -------
>  -z::
>  	Output a interdiff against the top-most applied patch. This should
> -	produce the same diff as "+guilt-new -f foo+".
> +	produce the same diff as "+guilt new -f foo+".
>  
>  <path>...::
>  	Restrict diff output to a given set of files.
> diff --git a/Documentation/guilt-help.txt b/Documentation/guilt-help.txt
> index ed6a5cf..df0e0fb 100644
> --- a/Documentation/guilt-help.txt
> +++ b/Documentation/guilt-help.txt
> @@ -18,11 +18,11 @@ EXAMPLES
>  
>  Open the guilt-status man page 
>  
> -	$ guilt-help status
> +	$ guilt help status
>  
>  Open the guilt man page 
>  
> -	$ guilt-help
> +	$ guilt help
>  
>  Author
>  ------
> diff --git a/Documentation/guilt-new.txt b/Documentation/guilt-new.txt
> index a2c8a4c..698dcb7 100644
> --- a/Documentation/guilt-new.txt
> +++ b/Documentation/guilt-new.txt
> @@ -42,16 +42,16 @@ EXAMPLES
>  
>  Create a new patch called 'foobar':
>  
> -	$ guilt-new foobar
> +	$ guilt new foobar
>  
>  Create a patch called 'foo' and supply a patch description interactively:
>  
> -	$ guilt-new -e foo
> +	$ guilt new -e foo
>  
>  Create a patch called 'bar' with a provided patch description and sign off
>  on the patch:
>  
> -	$ guilt-new -s -m patch-fu bar
> +	$ guilt new -s -m patch-fu bar
>  
>  Author
>  ------
> diff --git a/Documentation/guilt-repair.txt b/Documentation/guilt-repair.txt
> index 4aa472b..4faf113 100644
> --- a/Documentation/guilt-repair.txt
> +++ b/Documentation/guilt-repair.txt
> @@ -22,7 +22,7 @@ Perform various repository repairs. You must specify one mode of repair:
>  	WARNING: Running this command may result in commits and working
>  	directory changes being lost. You may want to create a new reference
>  	(e.g., branch, or reflog) to the original HEAD before using
> -	guilt-repair.
> +	"guilt repair".
>  
>  --status::
>  	Upgrade the status file from old format to new.
> diff --git a/Documentation/guilt-select.txt b/Documentation/guilt-select.txt
> index f7fb5f7..dd5833e 100644
> --- a/Documentation/guilt-select.txt
> +++ b/Documentation/guilt-select.txt
> @@ -19,10 +19,10 @@ the following way:
>  * An unguarded patch is always applied.
>  
>  * A patch with a positive guard is applied *only* if the guard is
> -selected with guilt-select.
> +selected with "+guilt select+".
>  
>  * A patch with a negative guard is applied *unless* the guard is
> -selected with guilt-select.
> +selected with "+guilt select+".
>  
>  OPTIONS
>  -------
> -- 
> 2.1.0
> 

-- 
mainframe, n.:
  An obsolete device still used by thousands of obsolete companies serving
  billions of obsolete customers and making huge obsolete profits for their
  obsolete shareholders. And this year's run twice as fast as last year's.
