From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: description
Date: Sat, 30 Apr 2005 14:43:27 +0200
Message-ID: <20050430124327.GA8942@vrfy.org>
References: <4272CDF1.9060207@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 14:37:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRrE6-0004Mh-EO
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 14:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVD3Mnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 08:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVD3Mnb
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 08:43:31 -0400
Received: from soundwarez.org ([217.160.171.123]:24556 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261210AbVD3Mn3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 08:43:29 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 8C2AF2929D; Sat, 30 Apr 2005 14:43:27 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4272CDF1.9060207@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 05:14:41PM -0700, H. Peter Anvin wrote:
> I guess this is technically speaking complete nonstandard addition to 
> git :) but I have added the following to the script that generates 
> http://www.kernel.org/git/:
> 
> If there is a plain text file called "description" in the .git 
> directory, it will appear on that webpage.

That's a nice idea. We may add the owner of the repo to this file too?
Or where does your script know that from the permissions? Is the projects
overview page updating itself?


Here is a new gitweb.cgi version that integrates with that page. The
own project browser is removed now and the top-link points now to your
link-list.

!! It already uses the new binaries with the git-* prepended. !!

See it working here:
  http://ehlo.org/~kay/git/

Get the cgi from here:
  ftp://ehlo.org/git/gitweb.cgi

!! Just remove lines 26-30, which are the settings to run on my box. !!

Thanks,
Kay
