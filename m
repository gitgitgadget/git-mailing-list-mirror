X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: GIT - releases workflow
Date: Wed, 13 Dec 2006 10:10:19 +0100
Message-ID: <1166001019.19098.4.camel@localhost.localdomain>
References: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com>
	 <Pine.LNX.4.63.0612122353320.2807@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 09:29:30 +0000 (UTC)
Cc: Sean Kelley <sean.v.kelley@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1104 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:29:22 EST
In-Reply-To: <Pine.LNX.4.63.0612122353320.2807@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.8.1.1 
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34192>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuQQX-0005qB-Mz for gcvg-git@gmane.org; Wed, 13 Dec
 2006 10:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932637AbWLMJ3X (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 04:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWLMJ3X
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 04:29:23 -0500
Received: from elephant.oekohosting.ch ([80.74.144.79]:44237 "EHLO
 elephant.oekohosting.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932637AbWLMJ3W (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec
 2006 04:29:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1]) by
 elephant.oekohosting.ch (Postfix) with ESMTP id 27B3362C096; Wed, 13 Dec 2006
 10:10:50 +0100 (CET)
Received: from elephant.oekohosting.ch ([127.0.0.1]) by localhost
 (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id
 18977-02; Wed, 13 Dec 2006 10:10:27 +0100 (CET)
Received: from [129.132.210.169] (vpn-global-dhcp3-169.ethz.ch
 [129.132.210.169]) by elephant.oekohosting.ch (Postfix) with ESMTP id
 4897562C058; Wed, 13 Dec 2006 10:10:26 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 2006-12-12 at 23:54 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 12 Dec 2006, Sean Kelley wrote:
> 
> > I was wondering if anyone could share ideas on how best to use GIT to 
> > handle releases for those working with a remote GIT repository?  Do you 
> > create a branch and push it to the remote?  Thus you have a new branch 
> > referencing the particular release?
> 
> Why not just tag the release, and push the tag?

I am doing both in my web SDK project.

I currently have two branches, master and maint/v1. Over time, if
necessary, I'll open new branches named maint/v2, maint/v3 etc.

New development happens on master, bugfixes go to maint/v1 and get
merged into master. If I do bugfix releases (2.0.x), I tag the tip of
the maint/v1 branch.

I need a full branch, because I need the ability to do bugfixes for the
already-released version.

Matthias
