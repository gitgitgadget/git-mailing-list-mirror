From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv8 7/7] gitweb: add empty alt text to avatar img
Date: Tue, 30 Jun 2009 22:29:49 +0200
Message-ID: <200906302229.50303.jnareb@gmail.com>
References: <1246312854-3365-1-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-7-git-send-email-giuseppe.bilotta@gmail.com> <1246312854-3365-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 22:30:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLjyO-0007Ix-BH
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 22:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbZF3UaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 16:30:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754015AbZF3UaK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 16:30:10 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:62974 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbZF3UaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 16:30:04 -0400
Received: by fxm18 with SMTP id 18so399389fxm.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 13:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QvxNOg20V9sH3N8vsaw8u0gHynzDOc7NKOCufA4JsgI=;
        b=t1SVxJOw3NuvWVEpJv6dOMCDKREbcy0QbD1DB16Rg+o2lhzWpO3u5aBcMDpn10CTM3
         Dy4qtt1g057P4lfPkVZmjWtryTMuYUd0o+ChTMLxCZF8Nxh2haHjcrShU+eJuEAT39Kp
         B/m99DS1Z7M1XJ1XYdda5JHWMoKQcswaXznow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=f3UU8GEct/Gf0k7tcP1MkKMCGkNtMBQ7tHKd1j3gnjeUvXfhrnnQwgQ0/M7hhi5moU
         mNLZo4C+T+SgOHA5eThl2kpJYMO9GqyNMPviYLtZDATMQ/dLDCR0+S0sA6aLKkKt8UO6
         8TiQ7yi4pwRXAVWEkUFuY1hMAwp889kZQUC28=
Received: by 10.103.8.3 with SMTP id l3mr5099699mui.116.1246393805404;
        Tue, 30 Jun 2009 13:30:05 -0700 (PDT)
Received: from ?192.168.1.13? (abvk72.neoplus.adsl.tpnet.pl [83.8.208.72])
        by mx.google.com with ESMTPS id t10sm2191632muh.0.2009.06.30.13.30.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Jun 2009 13:30:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1246312854-3365-8-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122538>

On Tue, 30 Jun 2009, Giuseppe Bilotta wrote:

> The empty alt text optimizes screen estate in text-only browsers.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I am not sure if such alt-text is a good idea from standards point
of view.  But the reasoning seems sound.

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 862ea99..6a1b5b5 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1574,6 +1574,7 @@ sub git_get_avatar {
>  		       "<img width=\"$size\" " .
>  		            "class=\"avatar\" " .
>  		            "src=\"$url\" " .
> +			    "alt=\"\" " .
>  		       "/>" . $post_white;
>  	} else {
>  		return "";
> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
