X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: On removing files and "git-rm is pointless"
Date: Mon, 04 Dec 2006 22:29:13 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612042225220.2630@xanadu.home>
References: <87odqm2ppv.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org>
 <4571DB40.6020800@vilain.net> <Pine.LNX.4.64.0612022246310.2630@xanadu.home>
 <7vd570q888.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612040737120.3476@woody.osdl.org>
 <7v8xhnm9o6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Tue, 5 Dec 2006 03:29:23 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Carl Worth <cworth@cworth.org>, Sam Vilain <sam@vilain.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7v8xhnm9o6.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33290>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrQzh-0000Wq-3S for gcvg-git@gmane.org; Tue, 05 Dec
 2006 04:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968052AbWLED3P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 22:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968045AbWLED3P
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 22:29:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:24727 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968052AbWLED3P (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 22:29:15 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9S00ETC70PLDE0@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Mon,
 04 Dec 2006 22:29:14 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, 4 Dec 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > If it doesn't match HEAD, we can't get it back as easily, so maybe that's 
> > the case when we want to have "git rm -f filename".
> 
> Hmph.  Wouldn't this lossage the same as the lossage we are
> removing the "safety valve" for, when "commit --only" jumps the
> index?

Losing an intermediate file state is much less severe than losing the 
latest file state I would think.


