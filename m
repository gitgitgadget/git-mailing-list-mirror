X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 16:38:54 +0200
Message-ID: <20061027143854.GC20017@pasky.or.cz>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org> <20061027030054.GB28407@spearce.org> <Pine.LNX.4.64.0610271022240.11384@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 14:43:16 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Eran Tromer <git2eran@tromer.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610271022240.11384@xanadu.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30329>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdSrj-00019F-V2 for gcvg-git@gmane.org; Fri, 27 Oct
 2006 16:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752229AbWJ0Oi5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 10:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbWJ0Oi5
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 10:38:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64914 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1752229AbWJ0Oi4 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 10:38:56 -0400
Received: (qmail 14031 invoked by uid 2001); 27 Oct 2006 16:38:54 +0200
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Dear diary, on Fri, Oct 27, 2006 at 04:27:05PM CEST, I got a letter
where Nicolas Pitre <nico@cam.org> said that...
> On Thu, 26 Oct 2006, Shawn Pearce wrote:
> > OK so the repository won't get corrupted but the repack would be
> > forced to abort.
> 
> Maybe this is the best way out?  Abort git-repack with "a fetch is in 
> progress -- retry later".  No one will really suffer if the repack has 
> to wait for the next scheduled cron job, especially if the fetch doesn't 
> explode packs into loose objects anymore.

I don't really like this that much. Big projects can have 10 commits per
hour on average, and they also take potentially long time to repack, so
you might get to never really repack them.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
