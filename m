X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Fri, 17 Nov 2006 02:22:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611170216190.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <87bqn9u43s.wl%cworth@cworth.org>
 <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home>
 <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home>
 <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home>
 <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl>
 <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl>
 <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl>
 <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl>
 <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611170013590.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611161642320.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 17 Nov 2006 01:22:50 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0611161642320.3349@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31654>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GksRJ-0007G7-6a for gcvg-git@gmane.org; Fri, 17 Nov
 2006 02:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424858AbWKQBWi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 20:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424873AbWKQBWi
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 20:22:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:29634 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1424858AbWKQBWh (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 20:22:37 -0500
Received: (qmail invoked by alias); 17 Nov 2006 01:22:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp044) with SMTP; 17 Nov 2006 02:22:35 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 16 Nov 2006, Linus Torvalds wrote:

> On Fri, 17 Nov 2006, Johannes Schindelin wrote:
> 
> > Besides, it is not really a temporary branch. If it was, the pull would 
> > _not_ download all these objects again, would it?
> 
> Well, exactly because they are temporary, we can't actually trust the 
> objects they point to.

Nonono.

We made _sure_ that FETCH_HEAD is only written once _all_ the objects were 
received. So, actually, we _can_, and we _should_ trust the objects they 
point to!

Or did I miss something?

> For example, if you used one of the old-fashioned commit walkers, maybe we 
> got the initial commit, but we may not have gotten the whole _chain_. See?

Huh? I am quite certain that FETCH_HEAD is not updated in that case. If it 
is, that's a bug.

Ciao,
