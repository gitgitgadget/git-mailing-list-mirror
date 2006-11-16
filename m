X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 14:43:58 +0100
Message-ID: <20061116134358.GW7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net> <20061116051240.GV7201@pasky.or.cz> <7vodr7brfp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 13:44:16 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vodr7brfp.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31582>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkhXB-00025E-CU for gcvg-git@gmane.org; Thu, 16 Nov
 2006 14:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424048AbWKPNoA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 08:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933503AbWKPNoA
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 08:44:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:59851 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S933502AbWKPNoA (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 08:44:00 -0500
Received: (qmail 24813 invoked by uid 2001); 16 Nov 2006 14:43:58 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Thu, Nov 16, 2006 at 11:45:46AM CET, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > (v) Library issues...
> > Git has the advantage of
> > simply putting that part in C, which is though something I should've
> > been doing more frequently too.
> 
> It should be stressed that git-core plumbing written in C is not
> just for git Porcelain-ish, and it will continue to be shared
> service.  We would add core support for what Porcelains need and
> we would try hard to keep them generic enough so that other
> Porcelains can use them.  Keeping the core and Porcelain-ish in
> the same project has made it easier to keep them in sync and to
> find and add missing features that would benefit Porcelains (not
> limited to git Porcelain-ish).  But that should not be mistaken
> as plumbing somehow belongs more to git Porcelain-ish than to
> Cogito or others.

  Of course, I didn't mean to say that. I should do more often things
like adding --stdin to the fetchers. From one part, I'm used to work
with a fixed set of system tools and extending Git with the
functionality I want means changing my thinking mode and "jumping out of
the system" a bit. The other part is that I cannot use the improvements
in Cogito right away (at least not in the main branch) but I have to
wait for the next Git release; but this is mostly just an excuse. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
