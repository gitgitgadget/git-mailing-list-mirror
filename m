X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 15:52:47 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 14 Nov 2006 20:52:59 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <87hcx1u934.wl%cworth@cworth.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31373>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk5H2-0003sQ-7R for gcvg-git@gmane.org; Tue, 14 Nov
 2006 21:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966256AbWKNUwt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 15:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966258AbWKNUwt
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 15:52:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63191 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S966256AbWKNUws (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 15:52:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8Q0088HNBZ16A0@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Tue,
 14 Nov 2006 15:52:48 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On Tue, 14 Nov 2006, Carl Worth wrote:

> Anyway, now I've just gone and blown all my secret plans for changing
> git in ways to make it less intimidating for new users.

I just cannot do otherwise than cheer this with applause.

Even if I have a clear preference for GIT's _technology_, I still think 
that the HG user interface is more convivial.  I even been thinking 
about writing something like an hg-like frontend to GIT from time to 
time just so that GIT could then be better compared to (and actually 
just used like) HG.

I still think that the GIT user interface sucks in many ways.  The 
confusion between pull, fetch and push is still my favorite, along with 
the locale vs remote branch issue.  Maybe we'll better handle the branch 
issue eventually, but it would be so much intuitive to split branch 
merging out of git-pull, and make git-pull be the same as git-fetch 
(maybe deprecating git-fetch in the process) so push and pull are really 
_only_ opposite of each other.

If the fetch+merge behavior (which I think should really be refered as 
pull+merge) is still desirable, then it should be called git-update and 
be no more than a single shell script line such as

	git_pull && git_merge"

This is really what most people expect from such a command name based 
on obvious historical reasons.  The lack of any branch argument to 
git-pull and git-merge could be defined as using the first defined 
remote branch by default.  But having git-pull performing merges is IMHO 
overloading the word and goes against most people's expectations.


