From: Mike Taht <mike.taht@timesys.com>
Subject: Re: using git directory cache code in darcs?
Date: Sun, 17 Apr 2005 09:49:18 -0700
Message-ID: <4262938E.8010107@timesys.com>
References: <20050416132231.GJ2551@abridgegame.org> <Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org> <20050417121712.GA22772@abridgegame.org> <Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Roundy <droundy@abridgegame.org>, git@vger.kernel.org,
	darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Sun Apr 17 18:45:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCtt-0002ta-Gf
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVDQQtZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVDQQtZ
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:49:25 -0400
Received: from mail.timesys.com ([65.117.135.102]:25097 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261358AbVDQQtV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 12:49:21 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Sun, 17 Apr 2005 12:44:42 -0400
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
X-OriginalArrivalTime: 17 Apr 2005 16:44:42.0687 (UTC) FILETIME=[C1340CF0:01C5436C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 17 Apr 2005, David Roundy wrote:
> 
>>That's all right.  Darcs would only access the cached data through a
>>git-caching layer, and we've already got an abstraction layer over the
>>pristine cache.  As long as the git layer can quickly retrieve the contents
>>of a given file, we should be fine.
> 
> 
> Yes.
> 
> In fact, one of my hopes was that other SCM's could just use the git
> plumbing. But then I'd really suggest that you use "git" itself, not any
> "libgit". Ie you take _all_ the plumbing as real programs, and instead of
> trying to link against individual routines, you'd _script_ it.

If you don't want it, I won't do it. Still makes sense to separate the 
plumbing from the porcelain, though.

-- 

Mike Taht


   "You can tell how far we have to go, when FORTRAN is the language of
supercomputers.
	-- Steven Feiner"
