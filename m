X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 17:03:34 +0200
Message-ID: <20061027150334.GD20017@pasky.or.cz>
References: <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org> <20061027030054.GB28407@spearce.org> <Pine.LNX.4.64.0610271022240.11384@xanadu.home> <20061027143854.GC20017@pasky.or.cz> <20061027144839.GB32451@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 15:13:34 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Shawn Pearce <spearce@spearce.org>,
	Eran Tromer <git2eran@tromer.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061027144839.GB32451@fieldses.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30332>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdTFE-0008BO-F9 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 17:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752201AbWJ0PDg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 11:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbWJ0PDg
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 11:03:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16590 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752201AbWJ0PDf (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 11:03:35 -0400
Received: (qmail 17003 invoked by uid 2001); 27 Oct 2006 17:03:34 +0200
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

Dear diary, on Fri, Oct 27, 2006 at 04:48:39PM CEST, I got a letter
where "J. Bruce Fields" <bfields@fieldses.org> said that...
> On Fri, Oct 27, 2006 at 04:38:54PM +0200, Petr Baudis wrote:
> > I don't really like this that much. Big projects can have 10 commits per
> > hour on average, and they also take potentially long time to repack, so
> > you might get to never really repack them.
> 
> An average of 10 per minute doesn't mean there aren't frequent long idle
> times.  That commit traffic is probably extremely bursty, right?

10 per _hour_. :-)

E.g. GNOME is 7 commits per hour average, and it does tend to be pretty
spread out:

	http://cia.navi.cx/stats/project/gnome

(Unfortunately I can't figure out how to squeeze more commits from the
web interface. KDE gets even more commits than GNOME and Gentoo tops
all the CIA-tracked projects.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
