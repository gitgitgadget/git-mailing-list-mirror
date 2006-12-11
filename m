X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] remove "[PATCH]" prefix from shortlog output
Date: Sun, 10 Dec 2006 22:17:57 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612102147460.2630@xanadu.home>
References: <Pine.LNX.4.64.0612091954010.2630@xanadu.home>
 <Pine.LNX.4.63.0612102337090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac1v2uom.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612110040260.1471@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 11 Dec 2006 03:18:10 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0612110040260.1471@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33972>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtbg6-0001qM-SX for gcvg-git@gmane.org; Mon, 11 Dec
 2006 04:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759737AbWLKDR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 22:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759709AbWLKDR7
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 22:17:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:52455 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1759715AbWLKDR6 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 22:17:58 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA300GYEAHX7VF0@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Sun,
 10 Dec 2006 22:17:57 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Mon, 11 Dec 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 10 Dec 2006, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > It tries not only to strip "[PATCH]", but also "[PATCH 0/n]" and basically 
> > > every prefix beginning with "[PATCH" and ending in "]". I do not remember 
> > > if I really tested that code, but it should work.

Hmmm well, right.  And of course I failed to notice that code was there.

I think I was corrupted by the dark side and failed to properly "use the 
source" twice on that tool this week.

> > The problem is that you forgot that the lines are indented when
> > acting as a filter.

Which was indeed my use case.

> Of course!
> 
> And your patch looks correct to me.

Confirmed.


