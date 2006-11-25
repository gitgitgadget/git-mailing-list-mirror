X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: cvsimport oddness
Date: Sat, 25 Nov 2006 13:33:56 +0000
Message-ID: <45684644.4040202@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 13:34:07 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32287>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnxfM-0002t5-36 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 14:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935186AbWKYNd5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 08:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935187AbWKYNd5
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 08:33:57 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:53764 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S935186AbWKYNd4
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 08:33:56 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gnxea-0005HX-M3 for git@vger.kernel.org; Sat, 25 Nov 2006
 13:33:12 +0000
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

skip patchset 2472: 1164219169 before 1164219362
skip patchset 2473: 1164219362 before 1164219362
Generating pack...
Done counting 14014 objects.
Deltifying 14014 objects.
 100% (14014/14014) done
Writing 14014 objects.
 100% (14014/14014) done
Total 14014, written 14014 (delta 9462), reused 13185 (delta 8872)
Pack pack-aca856ec2fa431ba3bbb975c67ed3a4dd5365a14 created.
DONE.
Already up-to-date.
apw@pinky$

Note that at the end we didn't get any additional revisions or commit
any additional commits.  The repack seems excessive in this case.

