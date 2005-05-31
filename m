From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [gitweb PATCH] Kill warnings in Webserver Error Log
Date: Tue, 31 May 2005 11:48:38 +0200
Message-ID: <20050531094838.GA22853@vrfy.org>
References: <429B6AD4.9010107@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 11:47:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd3K8-0005pG-33
	for gcvg-git@gmane.org; Tue, 31 May 2005 11:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVEaJsr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 05:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVEaJsr
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 05:48:47 -0400
Received: from soundwarez.org ([217.160.171.123]:14985 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261598AbVEaJsn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 05:48:43 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 686693AF50; Tue, 31 May 2005 11:48:38 +0200 (CEST)
To: Jochen Roemling <jochen@roemling.net>
Content-Disposition: inline
In-Reply-To: <429B6AD4.9010107@roemling.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 30, 2005 at 09:34:44PM +0200, Jochen Roemling wrote:
> The following patch kills two warnings in the Web Server Error Log:
> 
> [Mon May 30 21:24:15 2005] gitweb.cgi: "my" variable %co masks earlier 
> declaration in same scope at /home/www/html/tools/cgi-bin/gitweb.cgi 
> line 1658.
> [Mon May 30 21:25:46 2005] gitweb.cgi: "my" variable %co masks earlier 
> declaration in same scope at /home/www/html/tools/cgi-bin/gitweb.cgi 
> line 1615.
> 
> There might be a patch offset of few lines because I deleted my local 
> gitweb settings from the patch.

Dou you get the version from:
  ftp://ehlo.org/gitweb.cgi

It seems already fixed.

Thanks,
Kay
