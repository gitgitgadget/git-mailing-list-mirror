X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Locked down (but still shared) repositories
Date: Thu, 7 Dec 2006 14:17:30 -0500
Message-ID: <20061207191730.GA12143@spearce.org>
References: <20061207113539.GA10781@spearce.org> <Pine.LNX.4.63.0612071640160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:17:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612071640160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33607>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsOkW-0004WG-W2 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163215AbWLGTRf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163218AbWLGTRe
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:17:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34010 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163215AbWLGTRe (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:17:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsOkH-0002NC-BA; Thu, 07 Dec 2006 14:17:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6359620FB6E; Thu,  7 Dec 2006 14:17:30 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 7 Dec 2006, Shawn Pearce wrote:
> 
> > For various auditing reasons the repositories need to be tightly
> > controlled.  That is the following cannot be permitted:
> > 
> > [...]
> 
> How about just one such user? After all, you already have this user: the 
> repo owner. Of course, people have to push via ssh, even on the same 
> machine.

How do I know which SSH key the client used to connect?  Remember I'm
looking at the real uid to determine who is performing the operation.
In the situation you describe everyone looks the same to the
update hook...

For (probably stupid) reasons the server is the commerial F-Secure
SSH server, btw.  So OpenSSH based things wouldn't apply.  And best
that I can tell, F-Secure SSH won't tell me which key was used
to authenticate.

-- 
