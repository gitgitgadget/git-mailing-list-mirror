X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 04:21:57 +0100
Message-ID: <20061116032157.GR7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611151000460.2591@xanadu.home> <7vbqn8o9st.fsf@assigned-by-dhcp.cox.net> <200611151902.16358.andyparkins@gmail.com> <7vr6w4lcpr.fsf@assigned-by-dhcp.cox.net> <87y7qcsbsa.wl%cworth@cworth.org> <7vmz6sjtw8.fsf@assigned-by-dhcp.cox.net> <87r6w4s5ga.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 03:22:20 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87r6w4s5ga.wl%cworth@cworth.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31550>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkXpR-00028G-BW for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031068AbWKPDWA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031067AbWKPDWA
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:22:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:724 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1031068AbWKPDV7 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:21:59 -0500
Received: (qmail 9444 invoked by uid 2001); 16 Nov 2006 04:21:57 +0100
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 11:36:21PM CET, Carl Worth wrote:
> On Wed, 15 Nov 2006 13:13:11 -0800, Junio C Hamano wrote:
> > That is a very fine example, but I do not see why it is a
> > problem.  I do not think the goal of Porcelain is to make it
> > totally unnecessary for users to know about the plumbing.
> 
> If not, then the promise of the porcelain fails. If cogito offers
> "Here are 40 commands so you don't have to learn git's 140" and then
> next says "Oh, and you'll still want to learn all those git commands
> too", then its existence only makes the "too much stuff to learn"
> problem worse, not better.

I didn't get this argument before either - why do you need to learn "all
those git commands" too? You'll never have to learn "git add" or even
"git commit". If you want to pick specific git commands later (like "git
bisect", which even seeks in a Cogito-compatible way), that's fine, go
ahead! But you by no means have to learn _other_ commands than those you
need. If you want to bisect, you have to learn no other Git commands
than "git bisect".

Another point is, if using _just_ _git_ requires you to learn "all those
git commands too" from git-commit-tree up (yes it does! if you want your
authorship information to be correct), something is wrong.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
