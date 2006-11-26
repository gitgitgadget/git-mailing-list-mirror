X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Marko Macek <marko.macek@gmx.net>
Subject: Re: Some tips for doing a CVS importer
Date: Sun, 26 Nov 2006 17:11:36 +0100
Message-ID: <4569BCB8.9030809@gmx.net>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>	 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>	 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>	 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>	 <9e4733910611201753m392b5defpb3eb295a075be789@mail.gmail.com>	 <456969DA.6090702@gmx.net> <9e4733910611260735g2b18e9d1p51a0dca153282cc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 16:15:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #420190
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <9e4733910611260735g2b18e9d1p51a0dca153282cc7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32354>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoMfT-0000ZL-Ix for gcvg-git@gmane.org; Sun, 26 Nov
 2006 17:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934383AbWKZQPh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 11:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934391AbWKZQPh
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 11:15:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:41190 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S934383AbWKZQPh (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 11:15:37 -0500
Received: (qmail invoked by alias); 26 Nov 2006 16:15:34 -0000
Received: from BSN-77-45-79.dial-up.dsl.siol.net (EHLO [192.168.2.7])
 [193.77.45.79] by mail.gmx.net (mp009) with SMTP; 26 Nov 2006 17:15:34 +0100
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

Jon Smirl wrote:

> Another note for doing a converter. When combining things into change
> sets, for git import the comments in the branches should not be mixed
> between branches and the trunk when detecting change set. Git doesn't
> allow simultaneous commits to the trunk and branches.

Yup, this is the current problem I'm facing now. Even for CVS->SVN conversion,
I don't want to see multi-branch commits.

