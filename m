From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git as a filesystem
Date: Fri, 21 Sep 2007 21:29:41 +0400
Message-ID: <20070921172941.GA7399@potapov>
References: <fbe8b1780709210351x30775090ldab559f25c27645d@mail.gmail.com> <Pine.LNX.4.64.0709211208440.28395@racer.site> <fbe8b1780709210441n281248dbh5ba9934d09d6bbfc@mail.gmail.com> <20070921125337.GA28456@diana.vm.bytemark.co.uk> <fbe8b1780709210628u24c14117p5174bedb3d1912cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Peter Stahlir <peter.stahlir@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:29:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYmK7-00061a-H7
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 19:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbXIUR3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 13:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753649AbXIUR3q
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 13:29:46 -0400
Received: from smtp05.mtu.ru ([62.5.255.52]:60759 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbXIUR3p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 13:29:45 -0400
Received: from potapov.private (ppp85-140-170-112.pppoe.mtu-net.ru [85.140.170.112])
	by smtp05.mtu.ru (Postfix) with ESMTP id 8D6B997E000;
	Fri, 21 Sep 2007 21:29:42 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l8LHTgiK007519;
	Fri, 21 Sep 2007 21:29:42 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l8LHTfet007518;
	Fri, 21 Sep 2007 21:29:41 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to dpotapov@gmail.com using -f
Content-Disposition: inline
In-Reply-To: <fbe8b1780709210628u24c14117p5174bedb3d1912cb@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58863>

On Fri, Sep 21, 2007 at 03:28:20PM +0200, Peter Stahlir wrote:
> Yes, but if there were deb and tar support in git (to automatically unpack
> archives and store the contents), together with the best available
> binary diffs I think the repository could be significantly smaller because
> files common to all architectures could be deltified,

You can unpack contain of gzipped or bzipped files and deltify it, but
you cannot restore exactly the same gzip or bzip file based on its
content unless you use exactly the same version of compressor that was
used to create the original file. So, if you put any .deb file in such
a system, you will get back a different .deb file (with a different SHA1).
So, aside high CPU and memory requirements, this system cannot work in
principle unless all users have exactly the same version of a compressor.

Dmitry
