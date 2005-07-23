From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Last mile to 1.0?
Date: Sat, 23 Jul 2005 09:14:17 -0400
Organization: None, usuallly detectable by casual observers
Message-ID: <200507230914.18095.gene.heskett@verizon.net>
References: <7vwtnqhcfb.fsf@assigned-by-dhcp.cox.net>
 <20050723085031.GD3255@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jul 23 15:14:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DwJq4-0001bd-Cn
	for gcvg-git@gmane.org; Sat, 23 Jul 2005 15:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVGWNO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jul 2005 09:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVGWNO2
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jul 2005 09:14:28 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:61687 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261673AbVGWNOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2005 09:14:22 -0400
Received: from coyote.coyote.den ([151.205.63.153])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IK3001NK0RUZOG9@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 23 Jul 2005 08:14:19 -0500 (CDT)
In-reply-to: <20050723085031.GD3255@mythryan2.michonline.com>
To: git@vger.kernel.org
Content-disposition: inline
User-Agent: KMail/1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Duplicate send, had typo in orif address line :(
On Saturday 23 July 2005 04:50, Ryan Anderson wrote:
>On Sat, Jul 16, 2005 at 10:46:00AM -0700, Junio C Hamano wrote:
>>  - Publicity.  I would be very happy to see somebody with good
>>    writing and summarizing skills to prepare an article to be
>>    published on LWN.NET to coincide with the 1.0 release.  An
>>    update to GIT traffic would also be nice.
>
>How is this for a start?
>
>Source Code Management with Git
>
>Git, sometimes called "global information tracker", is a "directory
>content manager".  Git has been designed to handle absolutely
> massive projects with speed and efficiency, and the release of the
> 2.6.12 and (soon) the 2.6.13 version of the Linux kernel would
> indicate that it does this task well.
>
>Git falls into the category of distributed source code management
> tools, similar to Arch or Darcs (or, in the commercial world,
> BitKeeper).  This means that every working directory is a
> full-fledged repository with full revision tracking capabilities.
>
>Git uses the SHA1 hash algorithm to provide a content-addressable
> pseudo filesystem, complete with its own version of fsck.
>  o Speed of use, both for the project maintainer, and the
> end-users, is a key development principle.
>  o The history is stored as a directed acyclic graph, making
> long-lived branches and repeated merging simple.
>  o A collection of related projects are building on the core Git
>    project, either to provide an easier to use interface on top
> (Darcs, Mercurial, StGit, Cogito), or to take some of the
> underlying concepts and reimplement them directly into another
> system (Arch 2.0). o Two, interchangeable, on-disk formats are
> used:
>    o An efficient, packed format that saves spaced and network
>      bandwidth.
>    o An unpacked format, optimized for fast writes and incremental
>      work.
>
A very good start for the overview preamble.  Do carry on.

>Git results from the inspiration and frustration of Linus Torvalds,
> and the enthusiastic help of over 300 participants on the
> development mailing list.[1]
>
>
>1 - Generated with the following, in a maildir folder:
> find . -type f | xargs grep -h "^From:" | perl -ne \
> 'tr#A-Z#a-z#; m#<(.*)># && print $1,"\n";' | sort -u | wc -l

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
