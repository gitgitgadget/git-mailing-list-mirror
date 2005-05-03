From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 21:27:39 -0700
Message-ID: <20050503042739.GF22038@waste.org>
References: <20050429165232.GV21897@waste.org> <427650E7.2000802@tmr.com> <Pine.LNX.4.58.0505021457060.3594@ppc970.osdl.org> <20050502223002.GP21897@waste.org> <Pine.LNX.4.58.0505021540070.3594@ppc970.osdl.org> <20050503000011.GA22038@waste.org> <Pine.LNX.4.58.0505022123270.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Davidsen <davidsen@tmr.com>,
	Morten Welinder <mwelinder@gmail.com>,
	Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 06:21:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSouh-0005y2-4x
	for gcvg-git@gmane.org; Tue, 03 May 2005 06:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVECE1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVECE1u
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:27:50 -0400
Received: from waste.org ([216.27.176.166]:4559 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261385AbVECE1r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 00:27:47 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j434Re3W022731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 2 May 2005 23:27:40 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j434RdTa022728;
	Mon, 2 May 2005 23:27:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505022123270.3594@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 09:24:54PM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 2 May 2005, Matt Mackall wrote:
> > 
> > It's still simple in Mercurial, but more importantly Mercurial _won't
> > need it_. Dropping history is a work-around, not a feature.
> 
> Side note: this is what Larry thought about BK too. Until three years had
> passed, and the ChangeSet file was many megabytes in size. Even slow
> growth ends up being big growth in the end..
> 
> We had been talking about pruning the BK history as long back as a year 
> ago.

Ok, I'll implement it on my red eye flight tonight. But Mercurial
won't suffer from the O(filesize) problem of BK.

-- 
Mathematics is the supreme nostalgia of our time.
