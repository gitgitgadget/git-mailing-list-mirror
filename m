X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: Push and remote refs
Date: Sun, 5 Nov 2006 16:50:00 -0500
Message-ID: <20061105214959.GA28728@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0611051333210.9789@iabervon.org> <7vhcxdu1ln.fsf@assigned-by-dhcp.cox.net> <20061105210607.GA28320@coredump.intra.peff.net> <7vveltoa0l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 21:50:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vveltoa0l.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30986>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggpse-0002DI-CQ for gcvg-git@gmane.org; Sun, 05 Nov
 2006 22:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422724AbWKEVuE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 16:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWKEVuE
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 16:50:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:32934
 "HELO peff.net") by vger.kernel.org with SMTP id S1422724AbWKEVuC (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 16:50:02 -0500
Received: (qmail 17579 invoked from network); 5 Nov 2006 16:49:05 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 5 Nov 2006 16:49:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Nov
 2006 16:50:00 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sun, Nov 05, 2006 at 01:31:54PM -0800, Junio C Hamano wrote:

> post-update hook rewinds the tip we just pushed, it is the same
> thing as in the case where the post-update hook did not do
> anything but somebody else, a human user, did the equivalent
> rewinding of the branch, and the pretended fetch happened

Yes, I think this is a sensible way of looking at it. I withdraw my
question. :)

