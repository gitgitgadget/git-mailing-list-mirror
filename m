X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 05:30:50 +0100
Message-ID: <20061116043050.GU7201@pasky.or.cz>
References: <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 04:31:13 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31559>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkYty-0005HA-In for gcvg-git@gmane.org; Thu, 16 Nov
 2006 05:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162278AbWKPEax (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 23:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162280AbWKPEax
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 23:30:53 -0500
Received: from w241.dkm.cz ([62.24.88.241]:14771 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1162278AbWKPEaw (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 23:30:52 -0500
Received: (qmail 15437 invoked by uid 2001); 16 Nov 2006 05:30:50 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 07:03:18PM CET, Linus Torvalds wrote:
> If you think "pull" is confusing, I can guarantee you that _changing_ the 
> name is a hell of a lot more confusing. In fact, I think a lot of the 
> confusion comes from cogito, not from git - the fact that cogito used 
> different names and different syntax was a mistake, I think.

  I would agree that having "pull" mean something different in Cogito
than in Git was a bad idea (explanation: historically, for some period
of time Cogito had cg-pull which meant the same as cg-fetch or hg pull;
later it got renamed to cg-fetch). But I'm also happy that Cogito just
does not use the "pull" expression at all currently: "updating" seems to
be a clear and unloaded enough concept for new people. Pull is really
_very_ confusing, with it meaning something different (but not different
enough) in _all_ other systems but BK (which is basically irrelevant
nowadays).

  That said, I agree with your argument that changing it in Git now
might just result in more confusion. I'm just trying to explain Cogito's
choice here, and I believe it does no good nor harm to Core Git if it
just uses different name for the concept and avoids the original name at
all (except explaining in the docs that updating in Cogito is what
pulling is in Git).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
