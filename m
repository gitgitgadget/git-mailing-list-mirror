X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Timur Tabi <timur@freescale.com>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not
 so large)?
Date: Tue, 21 Nov 2006 10:29:11 -0600
Organization: Freescale
Message-ID: <45632957.5070205@freescale.com>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 16:29:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
In-Reply-To: <20061117103611.183640@gmx.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31997>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmYUq-0006J6-Es for gcvg-git@gmane.org; Tue, 21 Nov
 2006 17:29:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031070AbWKUQ3Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 11:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031072AbWKUQ3Q
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 11:29:16 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:59316 "EHLO
 de01egw02.freescale.net") by vger.kernel.org with ESMTP id S1031070AbWKUQ3Q
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 11:29:16 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net
 [10.208.0.31]) by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
 kALGhJhd004935; Tue, 21 Nov 2006 09:43:19 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
 by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kALGTC9w001226; Tue,
 21 Nov 2006 10:29:12 -0600 (CST)
To: Thomas Kolejka <Thomas.Kolejka@gmx.at>
Sender: git-owner@vger.kernel.org

Thomas Kolejka wrote:

> Is it possible to do this with shallow clone? 

Maybe.  How do you do a shallow clone?  I tried "git clone" followed by 
"git-repack", and that helped a lot, but the result was still twice the size of 
a normal tarball.  I don't see any "shallow" option to the clone command, and 
git-shallow-pack doesn't exist on my installation.

-- 
Timur Tabi
