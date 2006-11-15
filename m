X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 21:35:17 +0100
Message-ID: <20061115203517.GN7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <ejfm6c$bu4$1@sea.gmane.org> <200611152131.14883.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 20:35:35 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611152131.14883.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31487>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRTh-0001YM-2T for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161372AbWKOUfV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030983AbWKOUfV
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:35:21 -0500
Received: from w241.dkm.cz ([62.24.88.241]:25816 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1030977AbWKOUfU (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:35:20 -0500
Received: (qmail 6845 invoked by uid 2001); 15 Nov 2006 21:35:18 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 09:31:13PM CET, Josef Weidendorfer wrote:
> Often, I find myself doing "git branch" just to make sure that I am on
> "master", so that a following pull does not do a bogus merge.
> 
> Can we please disable this behavior, e.g. by allowing a fake first
> Pull line like "Pull: (not-for-merge)" to prohibit any merge?

Wait, if you don't want pull to merge, why do you pull and not fetch?

(Disclaimer: I'm not intimately familiar with git pull/fetch and I
didn't read the whole thread yet.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
