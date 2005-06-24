From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 11:03:07 -0700
Message-ID: <20050624180307.GS27572@waste.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624130604.GK17715@g5.random> <42BC112C.1040009@qualitycode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
X-From: git-owner@vger.kernel.org Fri Jun 24 19:57:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlsQE-0003lh-Mf
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 19:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbVFXSDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 14:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbVFXSDU
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 14:03:20 -0400
Received: from waste.org ([216.27.176.166]:59062 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263232AbVFXSDO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2005 14:03:14 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5OI37vH011699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 24 Jun 2005 13:03:07 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j5OI37H5011696;
	Fri, 24 Jun 2005 13:03:07 -0500
To: Kevin Smith <yarcs@qualitycode.com>
Content-Disposition: inline
In-Reply-To: <42BC112C.1040009@qualitycode.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 24, 2005 at 09:57:00AM -0400, Kevin Smith wrote:
> Mercurial's tags use a radical approach, whereas cogito's are more 
> conventional. I haven't yet used mercurial's versioned-tags enough yet 
> to judge whether they are better, worse, or just different.

FYI, after reading Linus' rant about tags, I added a second kind of
tags to Mercurial. So now it has both 'official' tags, which are
properly version controlled, and 'private' tags (like git's) as well.

To add a local tag, add a section like this to .hg/hgrc:

[tags]
tested = d6ac88a738c4b3afea56ff09e449b91d85abff68

(This was a bit of a no-brainer, as it was two lines of code)
-- 
Mathematics is the supreme nostalgia of our time.
