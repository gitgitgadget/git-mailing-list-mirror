X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to prepend data when formatting patches ?
Date: Thu, 30 Nov 2006 16:39:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611301638430.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <38b2ab8a0611300616j54a9f8ase9b4f1c305b7c22b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 15:39:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <38b2ab8a0611300616j54a9f8ase9b4f1c305b7c22b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32755>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpo0V-0005XF-HG for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030565AbWK3PjY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbWK3PjY
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:39:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:26027 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030565AbWK3PjX (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:39:23 -0500
Received: (qmail invoked by alias); 30 Nov 2006 15:39:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 30 Nov 2006 16:39:22 +0100
To: Francis Moreau <francis.moro@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Francis Moreau wrote:

> I'd like to add to all patchs created by "git-format-patch" command
> the following line:
> 
>        From: xxx.yyy <foo@crazy.com>

From Documentation/git-format-patch.txt:

-- snip --

CONFIGURATION
-------------
You can specify extra mail header lines to be added to each
message in the repository configuration as follows:

[format]
        headers = "Organization: git-foo\n"

-- snap --

Hth,
Dscho
