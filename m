X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Timur Tabi <timur@freescale.com>
Subject: Is there a way to trim old SHAs from a git tree (so it's not so large)?
Date: Wed, 15 Nov 2006 16:11:57 -0600
Organization: Freescale
Message-ID: <455B90AD.3060707@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 22:12:35 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1) Gecko/20061101 SeaMonkey/1.1b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31513>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSzG-00046L-TN for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161909AbWKOWMB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161881AbWKOWMB
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:12:01 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:57064 "EHLO
 de01egw02.freescale.net") by vger.kernel.org with ESMTP id S1161883AbWKOWL7
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:11:59 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
 by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id kAFMPvRp025436
 for <git@vger.kernel.org>; Wed, 15 Nov 2006 15:25:57 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
 by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id kAFMBwID011014 for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 16:11:58 -0600 (CST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

After doing a "make mrproper" in my Linux git tree, the result is still 1.1GB 
of files.  Compare that with just the tarball, which is just one-forth the size.

Is there a way to "trim away" old commits from the repository, so that it just 
doesn't take up that much space?  I don't care about any commits made in 2005. 
  As long as I can still do "git pull" from the source repo to update mine, 
that's good enough.

-- 
Timur Tabi
