From: Paul Jackson <pj@sgi.com>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sat, 23 Apr 2005 21:35:57 -0700
Organization: SGI
Message-ID: <20050423213557.475e0dfe.pj@sgi.com>
References: <20050424005923.GA8859@pasky.ji.cz>
	<20050423205847.7758bfaa.pj@sgi.com>
	<1114316259.25535.4.camel@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 06:32:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPYnV-0006OI-DU
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 06:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVDXEha (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 00:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVDXEha
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 00:37:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25537 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262158AbVDXEhX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 00:37:23 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3O6HGb5028742;
	Sat, 23 Apr 2005 23:17:26 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3O4a1lU17742368;
	Sat, 23 Apr 2005 21:36:05 -0700 (PDT)
To: James Purser <purserj@ksit.dynalias.com>
In-Reply-To: <1114316259.25535.4.camel@kryten>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

James wrote:
> Try separating out the git directory and linux directory. As I
> understand it each project/git repo needs its own directory.

I'm willing to do that - but I still don't get what I actually type.

I just tried:

    mkdir linux
    cd linux
    git init

    git addremote linus rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    # The above complained:
    #	grep: .git/remotes: No such file or directory
    # but still seemed to work ?

    git pull linus	# seems to get the same files I pulled before ... ok.
    # The above complained:
    #	client: nothing to do: perhaps you need to specify some filenames or the --recursive option?


Now what?  I still don't have the working source files for a kernel,
and I don't see how to specify in particular whatever Linus meant by

	a2755a80f40e5794ddc20e00f781af9d6320fafb

I issued a 'git --help' command (yeah - git is different - should be 'git help')
but I don't see any command that looks like it would checkout the working files.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
