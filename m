From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 13:20:12 -0400
Message-ID: <20050502172012.GD11726@mythryan2.michonline.com>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com> <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Davidsen <davidsen@tmr.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 19:22:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSec7-0002nm-9o
	for gcvg-git@gmane.org; Mon, 02 May 2005 19:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVEBRYa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 13:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVEBRXd
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 13:23:33 -0400
Received: from mail.autoweb.net ([198.172.237.26]:57997 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261365AbVEBRUi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 13:20:38 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DSeaa-0006WM-MN; Mon, 02 May 2005 13:20:12 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DSeaa-000320-00; Mon, 02 May 2005 13:20:12 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DSeaa-0003Z6-9g; Mon, 02 May 2005 13:20:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:
> That said, I think the /usr/bin/env trick is stupid too. It may be more 
> portable for various Linux distributions, but if you want _true_ 
> portability, you use /bin/sh, and you do something like
> 
> 	#!/bin/sh
> 	exec perl perlscript.pl "$@"
		if 0;

You don't really want Perl to get itself into an exec loop.

-- 

Ryan Anderson
  sometimes Pug Majere
