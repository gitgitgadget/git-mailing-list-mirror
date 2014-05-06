From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 22/28] The log.decorate setting should not influence
 patchbomb.
Date: Tue, 6 May 2014 16:41:40 -0400
Message-ID: <20140506204140.GS1655@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-23-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 06 22:43:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhmBK-0001Oa-6b
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755664AbaEFUlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 16:41:37 -0400
Received: from josefsipek.net ([64.9.206.49]:1670 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260AbaEFUlg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 16:41:36 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id E93BB55659;
	Tue,  6 May 2014 16:41:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-23-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248249>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Mar 21, 2014 at 08:32:00AM +0100, Per Cederqvist wrote:
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt-patchbomb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/guilt-patchbomb b/guilt-patchbomb
> index 1231418..164b10c 100755
> --- a/guilt-patchbomb
> +++ b/guilt-patchbomb
> @@ -47,7 +47,7 @@ if [ $? -ne 0 ]; then
>  fi
>  
>  # display the list of commits to be sent as patches
> -git log --pretty=oneline "$r" | cut -c 1-8,41- | $pager
> +git log --no-decorate --pretty=oneline "$r" | cut -c 1-8,41- | $pager
>  
>  _disp "Are these what you want to send? [Y/n] "
>  read n
> -- 
> 1.8.3.1
> 

-- 
Ready; T=0.01/0.01 16:41:35
