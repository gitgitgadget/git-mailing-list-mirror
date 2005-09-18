From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: first impressions to git
Date: Sun, 18 Sep 2005 23:39:13 +0200
Message-ID: <20050918213913.GC13315@vrfy.org>
References: <Pine.LNX.4.63.0509181201220.23242@iabervon.org> <20050918145434.GA22391@pasky.or.cz> <94fc236b050918073351075bb4@mail.gmail.com> <20050918211855.GA1463@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Gierke <ch@gierke.de>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:40:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH6sd-0000Id-MT
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 23:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVIRVjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVIRVjP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 17:39:15 -0400
Received: from soundwarez.org ([217.160.171.123]:32451 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932173AbVIRVjO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 17:39:14 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 4D7BD5D8A2; Sun, 18 Sep 2005 23:39:13 +0200 (CEST)
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20050918211855.GA1463@schottelius.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8812>

On Sun, Sep 18, 2005 at 11:18:56PM +0200, Nico -telmich- Schottelius wrote:
> First of all, thanks for that many very good explaining answers.

> Than I tried gitweb.cgi, which seems to have a small bug validating input:
> 
>    if ($input =~ m/(^|\/)(|\.|\.\.)($|\/)/) {
> 
> This also matches a cLinux/cinit.git as far as I can see.
> I use '(^|\/)(\.\.|\.)($|\/)' currently, but I am not totally sure, whether
> this is correct.

It fails cause you have a "non canonical" file name with a trailing
slash.

> You can see the original version on
> http://linux.schottelius.org/cgi-bin/gitweb-orig.cgi
> and my modified version on
> http://linux.schottelius.org/cgi-bin/gitweb.cgi
> 
> But perhaps the logic in gitweb.cgi should be changed:

Just remove the trailing slash from your project name and everything
should be fine.

Kay
