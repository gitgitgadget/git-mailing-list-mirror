From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [gitweb PATCH] Configure encoding
Date: Tue, 31 May 2005 11:19:55 +0200
Message-ID: <20050531091955.GA22706@vrfy.org>
References: <1839.1117526111@www5.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 11:19:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd2st-0002nE-6x
	for gcvg-git@gmane.org; Tue, 31 May 2005 11:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVEaJUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 05:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVEaJUR
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 05:20:17 -0400
Received: from soundwarez.org ([217.160.171.123]:13960 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261491AbVEaJUC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 05:20:02 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 2E0B53AF65; Tue, 31 May 2005 11:19:55 +0200 (CEST)
To: Thomas Kolejka <Thomas.Kolejka@gmx.at>
Content-Disposition: inline
In-Reply-To: <1839.1117526111@www5.gmx.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, May 31, 2005 at 09:55:11AM +0200, Thomas Kolejka wrote:
> The following patch makes it easy to change the encoding:
> 
> 
> --- gitweb.cgi.177      2005-05-31 09:43:17.000000000 +0200
> +++ gitweb.cgi.p        2005-05-31 09:48:46.000000000 +0200
> @@ -20,6 +20,9 @@
>  my $my_uri =           $cgi->url(-absolute => 1);
>  my $rss_link = "";
>  
> +my $encoding = "utf-8";
> +$encoding = "iso-8859-1";

The upstream version will not support anything but the one and only
sane encoding which is utf-8. It will not provide options to switch
back to the 80's, sorry. :)

Thanks,
Kay
