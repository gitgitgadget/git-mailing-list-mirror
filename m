X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 14:46:47 +0100
Message-ID: <20061116134647.GX7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <87r6w4s5ga.wl%cworth@cworth.org> <20061116032157.GR7201@pasky.or.cz> <200611161109.13883.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 13:47:10 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611161109.13883.robin.rosenberg.lists@dewire.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31583>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkhZv-0002eI-6W for gcvg-git@gmane.org; Thu, 16 Nov
 2006 14:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424050AbWKPNqv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 08:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933502AbWKPNqv
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 08:46:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64715 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S933501AbWKPNqu (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 08:46:50 -0500
Received: (qmail 25012 invoked by uid 2001); 16 Nov 2006 14:46:47 +0100
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

On Thu, Nov 16, 2006 at 11:09:13AM CET, Robin Rosenberg wrote:
> torsdag 16 november 2006 04:21 skrev Petr Baudis:
> > Another point is, if using _just_ _git_ requires you to learn "all those
> > git commands too" from git-commit-tree up (yes it does! if you want your
> > authorship information to be correct), something is wrong.
> 
> When/why do I need git-commit-tree? Isn't git-commit enough?

As I said, when you need to find out how to setup your authorship
information. It's documented as deep as on the git-commit-tree level.
BTW, the documentation is another important part of the
plumbing/porcelain separation, it's not only about the list of commands
but also that porcelain documentation should be reasonably
self-contained and not require users to peek at plumbing docs in order
to find out many stuff. It's also a consideration I take when
maintaining Cogito documentation.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
