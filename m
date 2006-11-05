X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Re: git-am vs. git-applymbox
Date: 5 Nov 2006 16:42:14 -0500
Message-ID: <20061105214214.8626.qmail@science.horizon.com>
NNTP-Posting-Date: Sun, 5 Nov 2006 21:42:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30985>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggpl0-0000Fk-DE for gcvg-git@gmane.org; Sun, 05 Nov
 2006 22:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422700AbWKEVmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 16:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWKEVmQ
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 16:42:16 -0500
Received: from science.horizon.com ([192.35.100.1]:9022 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S1422700AbWKEVmQ (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 16:42:16 -0500
Received: (qmail 8627 invoked by uid 1000); 5 Nov 2006 16:42:14 -0500
To: jnareb@gmail.com
Sender: git-owner@vger.kernel.org

> git-applymbox - Apply a series of patches in a mailbox
> git-am        - Apply a series of patches in a mailbox
> 
> What are the differences between thos two commands, UI-wise and capability
> (feature) wise? Which one should I use? Which one do _you_ use?

git-applymbox was one of the first git porcelain scripts ever written,
by Linus.  (In fact, it's original name of "dotest" is visible in some
of the temp files.)  It has its rough edges, but Linus is used to it,
so it is retained for his convenience.

git-am is a rewrite with a nicer (but different) command line.  If you
are starting, it's the one you should learn and use.

In particular, git-am has options like "--resolved" and "--skip" 
for resuming from an interrupted patch series.  Restarting
git-applymbox requires a detailed knowledge of its workings.

