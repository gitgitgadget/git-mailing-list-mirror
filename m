X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 23:46:48 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611142342160.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz>
 <87d57pu4qa.wl%cworth@cworth.org> <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net>
 <20061115040852.GL7201@pasky.or.cz> <7vd57ps51c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 04:46:59 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vd57ps51c.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31414>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkCfl-0004Dx-1f for gcvg-git@gmane.org; Wed, 15 Nov
 2006 05:46:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966639AbWKOEqu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 23:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966641AbWKOEqt
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 23:46:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:20323 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S966639AbWKOEqt (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 23:46:49 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8R00COF9A0NBI4@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Tue,
 14 Nov 2006 23:46:48 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 14 Nov 2006, Junio C Hamano wrote:

> Yes.  The current "merge" started its life as Linus's porcelain
> (we did not have fetch and pull infrastructure back then) but
> quickly has become just a helper for pull to produce a merge
> commit.  If anybody thinks its UI is good as a general end-user
> level command, there is a need for "head examination".

If you mean "git merge" it sure needs to be brought forward.  It can't 
be clearer than:

	git-merge the_other_branch

or

	git-merge git://repo.com/time_machine.git

to instantaneously understand what is going on.


