X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 16:32:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611281614450.20138@iabervon.org>
References: <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org> <Pine.LNX.4.64.0611260241320.20138@iabervon.org>
 <456C0313.3020308@op5.se> <Pine.LNX.4.64.0611281218290.20138@iabervon.org>
 <20061128180817.GA12463MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0611281315020.20138@iabervon.org>
 <20061128190618.GB12463MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0611281407370.20138@iabervon.org> <20061128211012.GJ28337@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 21:32:40 +0000 (UTC)
Cc: skimo@liacs.nl, Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061128211012.GJ28337@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpAZ1-0002pC-K2 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756405AbWK1VcX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756548AbWK1VcX
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:32:23 -0500
Received: from iabervon.org ([66.92.72.58]:37134 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S1756405AbWK1VcW (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:32:22 -0500
Received: (qmail 20603 invoked by uid 1000); 28 Nov 2006 16:32:21 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 28
 Nov 2006 16:32:21 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Tue, 28 Nov 2006, Shawn Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > and then it makes sense to let you do multiple commits with a single 
> > command when the paths end in different modules, since that's obviously 
> > what you're requesting, and then -a must do all of them.
> 
> Except what if the submodules have different commit message
> standards?  E.g. one requires signoff and another doesn't?  Or one
> allows privately held information (e.g. its your coporate project)
> and one doesn't (e.g. its an open source project you use/contribute
> to)?

I don't think you'd ever want the same commit message for commits in two 
projects. In any case where you'd commit a submodule in the process of 
committing a supermodule, git would do this by recursively calling 
git-commit, which would prompt for separate commit messages.

	-Daniel
