From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Add git-find-new-files to spot files added to the tree, but not the repository
Date: Mon, 25 Jul 2005 02:00:30 -0400
Message-ID: <20050725060029.GC6098@mythryan2.michonline.com>
References: <20050723074219.GB3255@mythryan2.michonline.com> <Pine.LNX.4.58.0507231039290.6074@g5.osdl.org> <Pine.LNX.4.58.0507231043330.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 25 08:13:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwwCf-0003cQ-8J
	for gcvg-git@gmane.org; Mon, 25 Jul 2005 08:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVGYGEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 02:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVGYGCF
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 02:02:05 -0400
Received: from mail.autoweb.net ([198.172.237.26]:27085 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261748AbVGYGAb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2005 02:00:31 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dww0s-0006SD-Na; Mon, 25 Jul 2005 02:00:30 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Dww9Y-00033F-00; Mon, 25 Jul 2005 02:09:28 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1Dww0s-0005Vd-1s; Mon, 25 Jul 2005 02:00:30 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507231043330.6074@g5.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2005 at 10:48:39AM -0700, Linus Torvalds wrote:
> 
> Oh, and btw, maybe you didn't realize that "git-ls-files --others" already 
> basically does what your script does? Without any filtering - it was meant 
> to be run from a script, so something like

That's exactly what I was missing.

The usage on a lot of the commands is very, well, "terse".

I totally missed "others" and I'm not sure I would have caught the
significance right away, anyway.

I was going to start a patch series to pull the man pages into each
program - but then I just decided it'd be easier to install the man
pages.

-- 

Ryan Anderson
  sometimes Pug Majere
