X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: reflog by default?, was Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 15:03:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141459160.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com>
 <20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org>
 <20061214120518.GL1747@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 14:04:25 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061214120518.GL1747@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34338>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GurC4-0000LJ-CH for gcvg-git@gmane.org; Thu, 14 Dec
 2006 15:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932742AbWLNOEB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 09:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbWLNODm
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 09:03:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:36630 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932739AbWLNODj
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 09:03:39 -0500
Received: (qmail invoked by alias); 14 Dec 2006 14:03:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp020) with SMTP; 14 Dec 2006 15:03:37 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Shawn Pearce wrote:

>  * Normal working repository (wants reflogs);
>  * Bare private (backup) repository (wants reflogs);
>  * Bare shared repository (probably doesn't want reflogs);
>  * Import generated repository (probably doesn't want reflogs);

In contrast, I think that reflogs make lots of sense for shared repos, 
and less sense for bare (non-shared) ones...

So, I'd say: enable reflog by default, unless it is bare _and_ not shared. 
But then, cmd_init_db() no longer knows if it was called with "--bare" or 
not.

Ciao,
Dscho
