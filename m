From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: version 0.91 of gitk out now
Date: Sun, 15 May 2005 10:45:23 -0400
Organization: None, usuallly detectable by casual observers
Message-ID: <200505151045.23198.gene.heskett@verizon.net>
References: <17031.19069.345408.888580@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 16:46:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXKNB-00018M-VL
	for gcvg-git@gmane.org; Sun, 15 May 2005 16:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVEOOpg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 10:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262832AbVEOOpg
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 10:45:36 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:55939 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S261662AbVEOOpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 10:45:25 -0400
Received: from coyote.coyote.den ([141.153.89.189])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IGJ006T3CZO3I99@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 15 May 2005 09:45:24 -0500 (CDT)
In-reply-to: <17031.19069.345408.888580@cargo.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-disposition: inline
User-Agent: KMail/1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sunday 15 May 2005 09:11, Paul Mackerras wrote:
>I have just put version 0.91 of gitk on ozlabs.org at:
>
> http://ozlabs.org/~paulus/gitk-0.91
>
>(that's the actual script, just wget it and run it).
>
Been lurking here, waiting for an announcement of a snapshot of this 
new gismo.  I wgot it, and chmodded it to 0766, but got this when its 
run:
[root@coyote git]# ./gitk-0.91
Error in startup script: can not find channel named "stder"
    while executing
"puts stder "Error executing git-rev-tree: $err""
    invoked from within
"if [catch {set commfd [open "|git-rev-tree $rargs" r]} err] {
        puts stder "Error executing git-rev-tree: $err"
        exit 1
    }"
    (procedure "getcommits" line 8)
    invoked from within
"getcommits $revtreeargs"
    (file "./gitk-0.91" line 993)

Typu?

>New features in version 0.91 include a menu bar, a widget to show
> the SHA1 id of the selected commit, a find facility for searching
> for commits, better error handling, and the ability to increase and
> decrease the font size with control-KP+ and control-KP- (and
> control-equal and control-minus).
>
>Gitk is a commit viewer written in Tcl/Tk.  Its main features are a
>compact and clear representation of the commit graph and the fact
> that it shows the headline, author and date of each commit in the
> summary window, allowing developers to scan quickly through a large
> number of commits and home in on the ones of interest to them. 
> When a commit is selected, the full commit message is shown, along
> with the colorized diff for commits that have one parent.
>
>Apart from the -b (use bold font for names), -c (color the commit
>graph according the the committer) and -d (order commits by date)
>options, all other arguments to gitk are passed to git-rev-tree to
>allow the user to specify which commits to display.
>
>Paul.
>-
>To unsubscribe from this list: send the line "unsubscribe git" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
