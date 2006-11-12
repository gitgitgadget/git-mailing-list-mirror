X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Sun, 12 Nov 2006 23:25:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611122319340.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 12 Nov 2006 22:25:50 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31283>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjNlg-0003ew-VT for gcvg-git@gmane.org; Sun, 12 Nov
 2006 23:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753375AbWKLWZc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 17:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbWKLWZc
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 17:25:32 -0500
Received: from mail.gmx.de ([213.165.64.20]:21180 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1753375AbWKLWZc (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 17:25:32 -0500
Received: (qmail invoked by alias); 12 Nov 2006 22:25:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp018) with SMTP; 12 Nov 2006 23:25:30 +0100
To: David Lang <dlang@digitalinsight.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 7 Nov 2006, David Lang wrote:

> On Tue, 7 Nov 2006, Junio C Hamano wrote:
> 
> > [pu]
> > 
> >  Johannes's shallow clone work now should rebase cleanly on top
> >  of 'master' although I haven't done so yet.  As he said
> >  himself the series is waiting for people who have needs for
> >  such a feature to raise hands.
> 
> I haven't been watching this recently, but if this is what I understand it to
> be (the ability to get a partial repository from upstream and work normally
> from there with the result of data-mineing tools sometimes reporting 'that's
> part of the truncated history' if they hit the cutoff) consider my hand
> raised.

For now, it does not say "part of the truncated history". But yes, shallow 
clones are partial copies of remote repositories, by making some commits 
"shallow", i.e. grafting an empty set of parents onto them (thereby 
pretending that these commits are root commits).

Telling the user that a commit is shallow should not be too hard.

Ciao,
Dscho
