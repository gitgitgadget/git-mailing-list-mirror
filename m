From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v3 28/31] Fix coding style errors in t-061.sh.
Date: Fri, 16 May 2014 11:23:56 -0400
Message-ID: <20140516152356.GF1770@meili.valhalla.31bits.net>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
 <1400251578-17221-29-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri May 16 17:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJzI-0003aR-M9
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 17:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbaEPPXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 11:23:53 -0400
Received: from josefsipek.net ([64.9.206.49]:1593 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbaEPPXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 11:23:48 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 28BF455654;
	Fri, 16 May 2014 11:23:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400251578-17221-29-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249347>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, May 16, 2014 at 04:46:15PM +0200, Per Cederqvist wrote:
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  regression/t-061.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/regression/t-061.sh b/regression/t-061.sh
> index db26e12..bda50c7 100755
> --- a/regression/t-061.sh
> +++ b/regression/t-061.sh
> @@ -15,8 +15,7 @@ old_style_branch() {
>  
>  remove_topic() {
>  	cmd guilt pop -a
> -	if git rev-parse --verify --quiet guilt/master >/dev/null
> -	then
> +	if git rev-parse --verify --quiet guilt/master >/dev/null; then
>  		cmd git checkout guilt/master
>  	else
>  		cmd git checkout master
> @@ -46,8 +45,7 @@ cmd git for-each-ref
>  
>  cmd list_files
>  
> -for i in `seq 5`
> -do
> +for i in `seq 5`; do
>  	if [ $i -ge 5 ]; then
>  		shouldfail guilt pop
>  	else
> -- 
> 1.8.3.1
> 

-- 
Ready; T=0.01/0.01 11:22:58
