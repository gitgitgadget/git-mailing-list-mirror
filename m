From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Documentation: finding $(prefix)/etc/gitconfig when
 prefix = /usr
Date: Mon, 8 Jul 2013 00:23:26 +0200 (CEST)
Message-ID: <382862830.1053811.1373235806136.JavaMail.root@dewire.com>
References: <1373234402-6856-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 08 00:29:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvxSm-0000NW-4r
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 00:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab3GGW3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 18:29:44 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:56065 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab3GGW3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 18:29:43 -0400
X-Greylist: delayed 373 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jul 2013 18:29:43 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 4A6C082C0D;
	Mon,  8 Jul 2013 00:23:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X2huowwwyHd4; Mon,  8 Jul 2013 00:23:26 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 37D2182BD8;
	Mon,  8 Jul 2013 00:23:26 +0200 (CEST)
In-Reply-To: <1373234402-6856-1-git-send-email-robin.rosenberg@dewire.com>
X-Originating-IP: [78.69.107.197]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229810>


I guess this isn't true either. Anyone has a better way of
specifiying where the system wide config file is read from,
or a user-parseable definition of $(prefix) ?

-- robin

----- Ursprungligt meddelande -----
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  Documentation/git-config.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-config.txt
> b/Documentation/git-config.txt
> index 9ae2508..3198d52 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -107,7 +107,8 @@ See also <<FILES>>.
>  
>  --system::
>  	For writing options: write to system-wide $(prefix)/etc/gitconfig
> -	rather than the repository .git/config.
> +	rather than the repository .git/config. However, $(prefix) is /usr
> +	then /etc/gitconfig is used.
>  +
>  For reading options: read only from system-wide
>  $(prefix)/etc/gitconfig
>  rather than from all available files.
> @@ -214,7 +215,8 @@ $XDG_CONFIG_HOME/git/config::
>  	file was added fairly recently.
>  
>  $(prefix)/etc/gitconfig::
> -	System-wide configuration file.
> +	System-wide configuration file, unless $(prefix) is /usr. In the
> +	latter case /etc/gitconfig is used.
>  
>  If no further options are given, all reading options will read all
>  of these
>  files that are available. If the global or the system-wide
>  configuration
> --
> 1.8.3.rc0.19.g7e6a0cc
> 
> 
