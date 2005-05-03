From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: cogito cg-update fails
Date: Tue, 03 May 2005 14:23:46 +1000
Message-ID: <1115094227.6031.62.camel@gaston>
References: <1115090374.6030.50.camel@gaston>
	 <200505022157.07800.elenstev@mesatop.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 06:20:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSosx-0005Yp-Tw
	for gcvg-git@gmane.org; Tue, 03 May 2005 06:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVECEZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVECEZ7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:25:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:33451 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261380AbVECEZw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 00:25:52 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j434K1gJ004655;
	Mon, 2 May 2005 23:20:03 -0500
To: Steven Cole <elenstev@mesatop.com>
In-Reply-To: <200505022157.07800.elenstev@mesatop.com>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


> 
> Yeah, I got exactly the same behavior a little while ago, but thanks
> to www.kernel.org/git, I saw that the problem had been found and fixed.
> 
> I had an older backup copy of all the cogito scripts, so I used that to update.
> 
> I believe the fix is this patch:

Thanks, fixed it ! Current top of tree seem to be fine too.

Cheers,
Ben.

> ===== cd7a12e5d569d59a04823114c275a83d65b9f37e vs 437167273f77c0d5f039280d158b43324a79f820 =====
> --- a/cg-pull
> +++ b/cg-pull
> @@ -48,7 +48,7 @@ fetch_rsync () {
>  }
>  
>  pull_rsync () {
> -	fetch_rsync -s -u -d "$1/objects" ".git/objects"
> +	fetch_rsync -s -u -d "$2/objects" ".git/objects"
>  }
>  
> 
> Hope this helps,
> Steven
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

