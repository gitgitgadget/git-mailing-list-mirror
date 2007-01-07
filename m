From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] instaweb: Nicer error message when the http daemon isn't found
Date: Sat, 6 Jan 2007 18:09:57 -0800
Message-ID: <20070107020957.GB18322@localdomain>
References: <20070106104006.9359.33443.stgit@c165>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 03:10:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3NUL-0005a9-RP
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 03:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbXAGCKA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 21:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbXAGCJ7
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 21:09:59 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33675 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbXAGCJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 21:09:58 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 581BC7DC094;
	Sat,  6 Jan 2007 18:09:57 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 06 Jan 2007 18:09:57 -0800
To: Fredrik Kuivinen <frekui@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070106104006.9359.33443.stgit@c165>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36120>

Fredrik Kuivinen <frekui@gmail.com> wrote:
> 
> 
> 
> Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>

Signed-off-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong

>  git-instaweb.sh |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index 08362f4..80adc83 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -53,6 +53,9 @@ start_httpd () {
>  				return
>  			fi
>  		done
> +		echo "$httpd_only not found. Install $httpd_only or use" \
> +		     "--httpd to specify another http daemon."
> +		exit 1
>  	fi
>  	if test $? != 0; then
>  		echo "Could not execute http daemon $httpd."
> -
