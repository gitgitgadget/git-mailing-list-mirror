X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fetching packs and storing them as packs
Date: Fri, 27 Oct 2006 10:48:39 -0400
Message-ID: <20061027144839.GB32451@fieldses.org>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home> <4540CA0C.6030300@tromer.org> <Pine.LNX.4.64.0610261105200.12418@xanadu.home> <45413209.2000905@tromer.org> <Pine.LNX.4.64.0610262038320.11384@xanadu.home> <20061027014229.GA28407@spearce.org> <45417205.6020805@tromer.org> <20061027030054.GB28407@spearce.org> <Pine.LNX.4.64.0610271022240.11384@xanadu.home> <20061027143854.GC20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 14:52:50 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Shawn Pearce <spearce@spearce.org>,
	Eran Tromer <git2eran@tromer.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061027143854.GC20017@pasky.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30331>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdT15-0003oY-Jy for gcvg-git@gmane.org; Fri, 27 Oct
 2006 16:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752233AbWJ0OtA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 10:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752234AbWJ0OtA
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 10:49:00 -0400
Received: from mail.fieldses.org ([66.93.2.214]:56030 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1752232AbWJ0Os7
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 10:48:59 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GdT0h-0000ZN-FO; Fri, 27 Oct 2006
 10:48:39 -0400
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On Fri, Oct 27, 2006 at 04:38:54PM +0200, Petr Baudis wrote:
> I don't really like this that much. Big projects can have 10 commits per
> hour on average, and they also take potentially long time to repack, so
> you might get to never really repack them.

An average of 10 per minute doesn't mean there aren't frequent long idle
times.  That commit traffic is probably extremely bursty, right?

