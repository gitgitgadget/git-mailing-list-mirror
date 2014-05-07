From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 27/28] Minor testsuite fix.
Date: Wed, 7 May 2014 17:09:23 -0400
Message-ID: <20140507210923.GB1459@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-28-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Wed May 07 23:09:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi95f-0001Zw-HK
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 23:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbaEGVJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 17:09:19 -0400
Received: from josefsipek.net ([64.9.206.49]:1711 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbaEGVJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 17:09:19 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id A981D55654;
	Wed,  7 May 2014 17:09:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-28-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248378>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Mar 21, 2014 at 08:32:05AM +0100, Per Cederqvist wrote:
> Fix remove_topic() in t-061.sh so that it doesn't print a git hash.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-061.out | 1 -
>  regression/t-061.sh  | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/regression/t-061.out b/regression/t-061.out
> index ef0f335..60ad56d 100644
> --- a/regression/t-061.out
> +++ b/regression/t-061.out
> @@ -381,7 +381,6 @@ ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba commit	refs/patches/master/mode
>  ffb7faa126a6d91bcdd44a494f76b96dd860b8b9 commit	refs/patches/master/remove
>  % guilt pop -a
>  No patches applied.
> -ccd56089d1b5305a9d35617cb7f6f4b06ffa68ba
>  % git checkout guilt/master
>  Switched to branch "guilt/master"
>  % guilt pop -a
> diff --git a/regression/t-061.sh b/regression/t-061.sh
> index a9a4fea..b573885 100755
> --- a/regression/t-061.sh
> +++ b/regression/t-061.sh
> @@ -15,7 +15,7 @@ old_style_branch() {
>  
>  remove_topic() {
>  	cmd guilt pop -a
> -	if git rev-parse --verify --quiet guilt/master
> +	if git rev-parse --verify --quiet guilt/master >/dev/null
>  	then
>  		cmd git checkout guilt/master
>  	else
> -- 
> 1.8.3.1
> 

-- 
Fact: 12.5% of all statistics are generated randomly.
