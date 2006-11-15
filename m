X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:11:36 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611151309290.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org>
 <7virhhy76h.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
 <200611150917.23756.andyparkins@gmail.com>
 <Pine.LNX.4.64.0611151023160.2591@xanadu.home>
 <7vfyckoaju.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 18:12:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vfyckoaju.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31457>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPEc-00020B-QT for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030797AbWKOSLj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030800AbWKOSLj
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:11:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:34911 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030797AbWKOSLi
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:11:38 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8S00366AJC9HL0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 13:11:37 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > But again I think it is important that the URL to use must be a per 
> > branch attribute i.e. attached to "default/master" and not just 
> > "default".  This way someone could add all branches of interest into the 
> > "default" group even if they're from different repositories, and a 
> > simple  get without any argument would get them all.
> 
> I think the "one group per one remote repository" model is a lot
> easier to explain.  At least when I read your first "branch
> group" proposal that was I thought was going on and I found it
> quite sensible (and it maps more or less straightforwardly to
> the way existing .git/refs/remotes is set up by default).

I think one group per remote repo is how things should be by default 
too.  But we should not limit it to that if possible.


