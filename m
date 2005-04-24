From: Paul Jackson <pj@sgi.com>
Subject: Re: [ANNOUNCE] git-pasky-0.7
Date: Sat, 23 Apr 2005 21:50:07 -0700
Organization: SGI
Message-ID: <20050423215007.1b2877d2.pj@sgi.com>
References: <20050423205847.7758bfaa.pj@sgi.com>
	<Pine.LNX.4.21.0504240018350.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 06:46:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPZ0G-00074H-Fa
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 06:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbVDXEu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 00:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVDXEu2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 00:50:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:40123 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262251AbVDXEuX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 00:50:23 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3O5EjTo016644;
	Sat, 23 Apr 2005 22:14:52 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3O4oBlU17765523;
	Sat, 23 Apr 2005 21:50:11 -0700 (PDT)
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504240018350.30848-100000@iabervon.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Daniel wrote:
> You might need a "git seek" or a "git cancel" or a "git track
> pasky" here; make sure that VERSION is 0.7.

Ok - I typed some random combination of "git seek", "git cancel" and
"git track pasky" and now I have a file named VERSION containing the
string "0.7\n", and I did a make install, with apparently useful
results (built and installed a bunch of stuff).

Then I did the following, with immediate, but not apparently useful, results:

    $ rm -fr linux
    $ mkdir linux
    $ cd linux
    $ git init linus rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    defaulting to local storage area
    link_stat linus/HEAD : No such file or directory
    rsync error: some files could not be transferred (code 23) at main.c(620)
    gitpull.sh: unable to get the head pointer of branch master
    gitinit.sh: pull failed

Still stuck ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
