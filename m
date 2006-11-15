X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Timur Tabi <timur@freescale.com>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not
 so large)?
Date: Wed, 15 Nov 2006 16:26:25 -0600
Organization: Freescale
Message-ID: <455B9411.4090708@freescale.com>
References: <455B90AD.3060707@freescale.com> <20061115221616.GD24861@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 22:26:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
In-Reply-To: <20061115221616.GD24861@spearce.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31516>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTDH-0006fp-NK for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161989AbWKOW0a (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161988AbWKOW0a
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:26:30 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:62446 "EHLO
 de01egw02.freescale.net") by vger.kernel.org with ESMTP id S1161989AbWKOW03
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:26:29 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
 by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id kAFMePH3029187;
 Wed, 15 Nov 2006 15:40:25 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
 by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id kAFMQPvl014168; Wed, 15
 Nov 2006 16:26:25 -0600 (CST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce wrote:

> Have you tried "git repack -a -d" to repack the loose objects into
> a pack file?  Doing this every so often should reduce your disk
> space consumed by a HUGE amount.

Woah!  It shrunk that bad boy down to 420M!  That should do it, thanks!

I wonder why the powerpc tree shrank so much.  Do you think the maintainer 
just needs to run git-repack on his tree?

-- 
Timur Tabi
