From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 00:40:43 -0700
Message-ID: <20050429074043.GT21897@waste.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 09:36:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRQ2N-0001uJ-SY
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 09:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbVD2HlH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 03:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbVD2HlH
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 03:41:07 -0400
Received: from waste.org ([216.27.176.166]:12170 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262469AbVD2Hkw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 03:40:52 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3T7eh4i001095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Apr 2005 02:40:43 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j3T7ehoK001092;
	Fri, 29 Apr 2005 02:40:43 -0500
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <3817.10.10.10.24.1114756831.squirrel@linux1>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 02:40:31AM -0400, Sean wrote:
> > - no way to do efficient delta storage
> 
> This has been discussed.  It is a recognized and accepted design
> trade-off.  Disk is cheap.

This trade-off FAILS, as my benchmarks against Mercurial have shown.
It trades 10x disk space for maybe 10% performance relative to my
approach. Meanwhile, it makes a bunch of other things hard, namely the
ones I've listed. Yes, you can hack around them, but the back end will
still be bloated.

> Your concearns are about performance rather than real limitations and it's
> just too damn early in the development process for that.  Frankly it's
> amazing how good git is considering its age; it's already _way_ faster and
> easier to use than bk ever was for my use.

Mercurial is even younger (Linus had a few days' head start, not to
mention a bunch of help), and it is already as fast as git, relatively
easy to use, much simpler, and much more space and bandwidth
efficient.

-- 
Mathematics is the supreme nostalgia of our time.
