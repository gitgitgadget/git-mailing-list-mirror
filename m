X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Fri, 17 Nov 2006 03:16:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611170315160.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611170013590.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611161642320.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611170216190.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061117015238.GD7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 17 Nov 2006 02:16:50 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061117015238.GD7201@pasky.or.cz>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31662>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GktHA-0002dN-CE for gcvg-git@gmane.org; Fri, 17 Nov
 2006 03:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424926AbWKQCQR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 21:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424927AbWKQCQR
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 21:16:17 -0500
Received: from mail.gmx.de ([213.165.64.20]:29627 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1424926AbWKQCQQ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 21:16:16 -0500
Received: (qmail invoked by alias); 17 Nov 2006 02:16:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 17 Nov 2006 03:16:15 +0100
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Hi,

On Fri, 17 Nov 2006, Petr Baudis wrote:

> On Fri, Nov 17, 2006 at 02:22:35AM CET, Johannes Schindelin wrote:
> > On Thu, 16 Nov 2006, Linus Torvalds wrote:
> > > For example, if you used one of the old-fashioned commit walkers, maybe we 
> > > got the initial commit, but we may not have gotten the whole _chain_. See?
> > 
> > Huh? I am quite certain that FETCH_HEAD is not updated in that case. If it 
> > is, that's a bug.
> 
> It may be updated and then things may break _afterwards_. git-prune will
> happily blow anything referenced by FETCH_HEAD, it's not considered by
> the fsck-objects reachability analysis.

This actually underlines my point: FETCH_HEAD is no _real_ branch, not 
even a temporary one. If it was, git-prune would not lose the related 
objects.

Ciao,
Dscho
