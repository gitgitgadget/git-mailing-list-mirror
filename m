X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 23:20:51 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home>
 <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home>
 <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 04:21:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31411>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkCGe-0008So-Ea for gcvg-git@gmane.org; Wed, 15 Nov
 2006 05:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966574AbWKOEUx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 23:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966576AbWKOEUx
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 23:20:53 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20474 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S966574AbWKOEUw (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 23:20:52 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8R001TK82RWEF0@VL-MO-MR001.ip.videotron.ca> for git@vger.kernel.org; Tue,
 14 Nov 2006 23:20:51 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 14 Nov 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > "You pull the remote changes with 'git-pull upstream,, then you can 
> > merge them in your current branch with 'git-merge upstream'."
> >
> > Isn't it much simpler to understand (and to teach) that way?
> 
> If it were "you download the remote changes with 'git download
> upstream' and then merge with 'git merge'", then perhaps, but if
> you used the word "pull" or "fetch", I do not think so.
> 
> I would be all for changing the semantics of "pull" from one
> thing to another, if the new semantics were (1) what everybody
> welcomed, (2) what "pull" traditionally meant everywhere else.
> In that case, we have been misusing it to be confusing to
> outsiders and I agree it makes a lot of sense to remove the
> source of confusion.  But I do not think CVS nor SVN ever used
> the term, and I was told that BK was what introduced the term,
> and the word meant something different from what you are
> proposing.
> 
> You have to admit both pull and fetch have been contaminated
> with loaded meanings from different backgrounds. I was talking
> about killing the source of confusion in the longer term by
> removing fetch/pull/push, so we are still on the same page.
> 
> That's where my "you download from the upstream and merge" comes
> from.

But the fact is that HG (which has a growing crowd of happy campers, 
maybe even larger than the BK crowd now) did work with and got used to a 
sensible definition of what a "pull" is.  This means that their 
definition is becoming rather more relevant with time than what it used 
to, and because it is a saner definition than what GIT has for the same 
word which HG users really have no issue with, I think we really should 
leverage the "common wisdom" and consider aligning ourselves with them 
in this case rather than trying to go into a totally different 
direction.  We simply won't gain anything trying to teach people "a pull 
in HG is a download in GIT".  If a pull becomes the same thing for both 
then it's one less oddball in the GIT interface.


