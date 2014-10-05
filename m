From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn's performance issue and strange pauses, and other thing
Date: Sun, 5 Oct 2014 01:02:43 +0000
Message-ID: <20141005010243.GA2926@dcvr.yhbt.net>
References: <1411025993.80693.YahooMailBasic@web172304.mail.ir2.yahoo.com>
 <20140919082529.GA32459@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakob Stoklund Olesen <stoklund@2pi.dk>,
	Sam Vilain <sam@vilain.net>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>,
	Andrew Myrick <amyrick@apple.com>
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Oct 05 03:03:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaaE0-0004Nh-2W
	for gcvg-git-2@plane.gmane.org; Sun, 05 Oct 2014 03:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbaJEBCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2014 21:02:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:32928 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbaJEBCp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2014 21:02:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A131F7FF;
	Sun,  5 Oct 2014 01:02:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20140919082529.GA32459@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257895>

Eric Wong <normalperson@yhbt.net> wrote:
> Jakob sent some patches a few months ago which seem to address the
> issue.  Unfortunately we forgot about them :x

Hin-Tak: have you tried Jakob's patches?  I've taken another look,
signed-off and pushed to my master.

> Can you take a look at the following two "mergeinfo-speedups"
> in my repo?  (git://bogomips.org/git-svn)
> 
> Jakob Stoklund Olesen (2):
>       git-svn: only look at the new parts of svn:mergeinfo
>       git-svn: only look at the root path for svn:mergeinfo
> 
> Also downloadable here:
> 
> http://bogomips.org/git-svn.git/patch?id=9b258e721b30785357535
> http://bogomips.org/git-svn.git/patch?id=73409a2145e93b436d74a
> 
> Can you please give them a try?
