From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Last mile to 1.0?
Date: Sat, 23 Jul 2005 04:50:31 -0400
Message-ID: <20050723085031.GD3255@mythryan2.michonline.com>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 23 10:51:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwFil-0006Q0-L3
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 10:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVGWIuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 04:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVGWIuf
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 04:50:35 -0400
Received: from mail.autoweb.net ([198.172.237.26]:8878 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261572AbVGWIuc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2005 04:50:32 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DwFiK-0005cm-Ha; Sat, 23 Jul 2005 04:50:32 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DwFqe-0004gz-00; Sat, 23 Jul 2005 04:59:08 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DwFiJ-0001ty-VY; Sat, 23 Jul 2005 04:50:31 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 16, 2005 at 10:46:00AM -0700, Junio C Hamano wrote:
>  - Publicity.  I would be very happy to see somebody with good
>    writing and summarizing skills to prepare an article to be
>    published on LWN.NET to coincide with the 1.0 release.  An
>    update to GIT traffic would also be nice.

How is this for a start?

Source Code Management with Git

Git, sometimes called "global information tracker", is a "directory
content manager".  Git has been designed to handle absolutely massive
projects with speed and efficiency, and the release of the 2.6.12 and
(soon) the 2.6.13 version of the Linux kernel would indicate that it
does this task well.

Git falls into the category of distributed source code management tools,
similar to Arch or Darcs (or, in the commercial world, BitKeeper).  This
means that every working directory is a full-fledged repository with
full revision tracking capabilities.

Git uses the SHA1 hash algorithm to provide a content-addressable pseudo
filesystem, complete with its own version of fsck.
  o Speed of use, both for the project maintainer, and the end-users, is
    a key development principle.
  o The history is stored as a directed acyclic graph, making long-lived
    branches and repeated merging simple.
  o A collection of related projects are building on the core Git
    project, either to provide an easier to use interface on top (Darcs,
    Mercurial, StGit, Cogito), or to take some of the underlying concepts
    and reimplement them directly into another system (Arch 2.0).
  o Two, interchangeable, on-disk formats are used:
    o An efficient, packed format that saves spaced and network
      bandwidth.
    o An unpacked format, optimized for fast writes and incremental
      work.

Git results from the inspiration and frustration of Linus Torvalds, and
the enthusiastic help of over 300 participants on the development
mailing list.[1]


1 - Generated with the following, in a maildir folder:
	find . -type f | xargs grep -h "^From:" | perl -ne \
	'tr#A-Z#a-z#; m#<(.*)># && print $1,"\n";' | sort -u | wc -l 


-- 

Ryan Anderson
  sometimes Pug Majere
