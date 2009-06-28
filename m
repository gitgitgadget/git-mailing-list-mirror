From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv7 9/9] gitweb: add alt text to avatar img
Date: Sun, 28 Jun 2009 17:43:52 +0200
Message-ID: <200906281743.55871.jnareb@gmail.com>
References: <1246104305-15191-1-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-9-git-send-email-giuseppe.bilotta@gmail.com> <1246104305-15191-10-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 17:38:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKwSk-0005kv-Ap
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 17:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbZF1Pi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 11:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbZF1Pi1
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 11:38:27 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:45314 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbZF1Pi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 11:38:26 -0400
Received: by fxm18 with SMTP id 18so538536fxm.37
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=O6oN1aYruHmwzAIGPFC71oaC/kxCImeRrWwmFF0k6AA=;
        b=B3YT24b+fNLif5V0n9CUoZA067kBjDzns7P538/WPpfOXueJFd8l+LXcnvQ3tg0jgn
         o1ctH/9TsBTk+hVe2LVxMVKZJEVvQxMzAJHGb7rLswOeAiq1f15dr7/to6ZcKzVJdaXZ
         4i3jbWq8jzchneEz4xa/j4/pdvXKOkB9TovkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=hucu/HWKiZ37FRezWdI56vBdfNSEYTGIKHAokMCQcxw8UeFX+OaFgBoCqGJVUh2PHd
         jiYPdKASDOHE+U0B/WwefaM6MAV5eAozi3j+7ytgbbyubwFloRqTVF3ImVZbJTIYz+Dw
         B9TiZCQSIgpuKvdtQhm0LAuf70E/uTpLPd6+I=
Received: by 10.102.219.9 with SMTP id r9mr846945mug.91.1246203508027;
        Sun, 28 Jun 2009 08:38:28 -0700 (PDT)
Received: from ?192.168.1.13? (abvg228.neoplus.adsl.tpnet.pl [83.8.204.228])
        by mx.google.com with ESMTPS id e9sm26162820muf.32.2009.06.28.08.38.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 08:38:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246104305-15191-10-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122409>

On Sat, 27 June 2009, Giuseppe Bilotta wrote:

> The alt text, set to the avatar provider (i.e. image type), is more
> friendly than the img url in some text-only browsers.

Signoff?

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e2638cb..dc6049a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1578,6 +1578,7 @@ sub git_get_avatar {
>  		       "<img width=\"$size\" " .
>  		            "class=\"avatar\" " .
>  		            "src=\"$url\" " .
> +			    "alt=\"$git_avatar\" " .
>  		       "/>" . $post_white;
>  	} else {
>  		return "";
> -- 

Bit of bikeshedding: "alt=\"\" " (empty alt text) would also be
a good solution.  This way text browser which do not display images
wouldn't take limited horizontal space for alt text of extraneous
avatar image.

-- 
Jakub Narebski
Poland
