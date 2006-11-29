X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Wed, 29 Nov 2006 15:32:36 -0600
Message-ID: <1164835956.4724.62.camel@cashmere.sps.mot.com>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 21:34:13 +0000 (UTC)
Cc: Git List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32671>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpX3a-0003sO-7V for gcvg-git@gmane.org; Wed, 29 Nov
 2006 22:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758144AbWK2Vd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 16:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758146AbWK2Vd1
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 16:33:27 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:12160 "EHLO
 de01egw02.freescale.net") by vger.kernel.org with ESMTP id S1758144AbWK2Vd0
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 16:33:26 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
 by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id kATLlfkx021423;
 Wed, 29 Nov 2006 14:47:41 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2]) by
 de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id kATLXN8H008625; Wed, 29
 Nov 2006 15:33:23 -0600 (CST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, 2006-11-25 at 15:53, Junio C Hamano wrote:

> I am not sure if 'merge in corresponding branch' is the only
> valid workflow, however. I am reluctant to make the system
> automatically do so if the solution makes other workflows more
> painful to follow.  Automatically merging remotes/origin/$foo
> when on $foo branch is not good enough, in other words (also,
> there may be a hierarchy under remotes/ other than origin).  It
> might make sense to introduce "Merge: " in remotes/ file and if
> they are present use "Pull: " only to decide what are fetched
> and use "Merge: " to decide what is merged (if we were doing the
> system from scratch, the former would have been named "Fetch: "
> but it is too late now).

Heh.  It was too late back here too!

    From: 	Jon Loeliger <jdl@freescale.com>
    To: 	Git List <git@vger.kernel.org>
    Subject: 	Re: GIT 0.99.7d, and end of week status.
    Date: 	Mon, 26 Sep 2005 15:17:32 -0500
    Message-Id:  <1127765852.5735.36.camel@cashmere.sps.mot.com>

jdl

