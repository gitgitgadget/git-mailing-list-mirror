X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 10:10:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611151000460.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
 <7virhhy76h.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
 <7vu011qnl6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611151454250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 15 Nov 2006 15:11:15 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0611151454250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31444>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkMPq-0003Oo-Gv for gcvg-git@gmane.org; Wed, 15 Nov
 2006 16:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030543AbWKOPKw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 10:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030548AbWKOPKv
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 10:10:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:329 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030543AbWKOPKv
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 10:10:51 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8S00FOU262KGF0@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Wed,
 15 Nov 2006 10:10:50 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Wed, 15 Nov 2006, Johannes Schindelin wrote:

> On Tue, 14 Nov 2006, Junio C Hamano wrote:
> 
> > Nicolas Pitre <nico@cam.org> writes:
> > 
> > > 2) "pull" and "push" should be symmetrical operations
> > 
> > I think that makes a lot of sense to have "gh pull" and "gh
> > push" as symmetric operations, and make "gh merge" do the
> > fast-forward and 3-way merge magic done in the current "git
> > pull".  These three words would have a lot saner meaning.
> 
> I am really opposed to do "gh pull". Not only because of "gh" being 
> completely confusing (we already _have_ "git", and for porcelains 
> different TLAs), but "pull" _really_ is confusing by now. And Mercurial 
> did not help one wit by insisting on their own interpretation.

I completely agree that creating yet another command prefix for 
basically the same tools would be a disaster.  We have "git" already so 
let's stick to it and make its usage just more sane.

> Why not do something like "get/put" instead? It is
> 
> - easier to remember
> - not bogus (AFAICT the meaning is not used in diametrical senses)
> - shorter to type than download/upload

Well, of all compromizes this is probably the best one so far.  I would 
have prefered to bite the bullet and fix "pull" instead of adding yet 
more commands.  But if the consensus is that there is no way on earth 
that "pull" can be salvaged then get/put is probably more enjoyable than 
download/upload.  This way pull/fetch/push could still be available 
(albeit burried somewhere out of sight).


