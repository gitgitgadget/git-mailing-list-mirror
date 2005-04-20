From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: [ANNOUNCEMENT] /Arch/ embraces `git'
Date: Wed, 20 Apr 2005 17:55:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504201754450.2630@cag.csail.mit.edu>
References: <200504201000.DAA04988@emf.net> <20050420213114.GF19112@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Tom Lord <lord@emf.net>, gnu-arch-users@gnu.org,
	gnu-arch-dev@lists.seyza.com, git@vger.kernel.org,
	talli@museatech.net, torvalds@osdi.org
X-From: git-owner@vger.kernel.org Wed Apr 20 23:58:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONCd-0004k7-Hq
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 23:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVDTWCD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbVDTWCD
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:02:03 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:33459 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261609AbVDTWB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 18:01:59 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DONB4-0003Pc-00; Wed, 20 Apr 2005 17:56:10 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050420213114.GF19112@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Petr Baudis wrote:

> I think one thing git's objects database is not very well suited for are
> network transports. You want to have something smart doing the
> transports, comparing trees so that it can do some delta compression;
> that could probably reduce the amount of data needed to be sent
> significantly.

I'm hoping my 'chunking' patches will fix this.  This ought to reduce the 
size of the object store by (in effect) doing delta compression; rsync
will then Do The Right Thing and only transfer the needed deltas.
Running some benchmarks right now to see how well it lives up to this 
promise...
  --scott

terrorist AEROPLANE munitions PAPERCLIP MI5 Morwenstow WSHOOFS CABOUNCE 
colonel Yakima AES MI6 nuclear NSA Cocaine Columbia plastique LICOZY
                          ( http://cscott.net/ )
