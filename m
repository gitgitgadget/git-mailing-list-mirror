From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 5/5] doc: git doesn't use git-foo invocations.
Date: Fri, 23 Jan 2015 09:29:12 -0500
Message-ID: <20150123142911.GE101465@meili.jeffnet.31bits.net>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
 <1422019499-2012-6-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:29:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEfEc-0006DR-Q2
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbbAWO3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:29:15 -0500
Received: from josefsipek.net ([71.174.113.7]:1620 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755223AbbAWO3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:29:14 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id 5253D55654;
	Fri, 23 Jan 2015 09:29:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1422019499-2012-6-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262935>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Jan 23, 2015 at 02:24:59PM +0100, Per Cederqvist wrote:
> Make them into reference to the man pages instead.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  Documentation/guilt-add.txt     | 2 +-
>  Documentation/guilt-refresh.txt | 2 +-
>  Documentation/guilt-rm.txt      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/guilt-add.txt b/Documentation/guilt-add.txt
> index a276f09..067b6ca 100644
> --- a/Documentation/guilt-add.txt
> +++ b/Documentation/guilt-add.txt
> @@ -11,7 +11,7 @@ include::usage-guilt-add.txt[]
>  
>  DESCRIPTION
>  -----------
> -Adds the files specified to git using git-add making it available to guilt.
> +Adds the files specified to git using git-add(1) making it available to guilt.
>  
>  OPTIONS
>  -------
> diff --git a/Documentation/guilt-refresh.txt b/Documentation/guilt-refresh.txt
> index 7757bdc..98076e3 100644
> --- a/Documentation/guilt-refresh.txt
> +++ b/Documentation/guilt-refresh.txt
> @@ -23,7 +23,7 @@ OPTIONS
>  Include a diffstat output in the patch file. Useful for cases where
>  patches will be submitted with other tools.
>  +
> -If the command line option is omitted, the corresponding git-config
> +If the command line option is omitted, the corresponding git-config(1)
>  option "guilt.diffstat" will be queried. So this would enable diffstat
>  output by default:
>  
> diff --git a/Documentation/guilt-rm.txt b/Documentation/guilt-rm.txt
> index 71b49fe..cfe471e 100644
> --- a/Documentation/guilt-rm.txt
> +++ b/Documentation/guilt-rm.txt
> @@ -11,7 +11,7 @@ include::usage-guilt-rm.txt[]
>  
>  DESCRIPTION
>  -----------
> -Removes the files specified from git using git-rm
> +Removes the files specified from git using git-rm(1).
>  
>  OPTIONS
>  -------
> -- 
> 2.1.0
> 

-- 
The obvious mathematical breakthrough would be development of an easy way to
factor large prime numbers.
		- Bill Gates, The Road Ahead, pg. 265
