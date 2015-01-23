From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 4/5] doc: don't use guilt-foo invocations in usage
 messages.
Date: Fri, 23 Jan 2015 09:27:31 -0500
Message-ID: <20150123142731.GD101465@meili.jeffnet.31bits.net>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
 <1422019499-2012-5-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:27:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEfD2-00054i-0f
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbbAWO1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:27:35 -0500
Received: from josefsipek.net ([71.174.113.7]:1617 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702AbbAWO1d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:27:33 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id 132E355654;
	Fri, 23 Jan 2015 09:27:33 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1422019499-2012-5-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262934>

Ah, I see you changed usage.sh here.  I guess that kinda invalidates my
comment for patch 1/5.

On Fri, Jan 23, 2015 at 02:24:58PM +0100, Per Cederqvist wrote:
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  Documentation/usage.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/usage.sh b/Documentation/usage.sh
> index 629f546..9cc49f7
> --- a/Documentation/usage.sh
> +++ b/Documentation/usage.sh
> @@ -2,4 +2,4 @@
>  
>  name=$(basename $1)
>  u=$(grep USAGE $1 |  sed 's/USAGE="//' | sed 's/"$//') 
> -echo "'$name' $u"  > usage-$name.txt
> +echo "'`echo $name|sed -e 's/^guilt-/guilt /'`' $u"  > usage-$name.txt

Tiny nitpick: spaces around the |, otherwise looks good.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>


> -- 
> 2.1.0
> 

-- 
Si hoc legere scis nimium eruditionis habes.
