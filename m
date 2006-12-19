X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Change in git-svn dcommit semantics?
Date: Tue, 19 Dec 2006 18:02:14 -0500
Message-ID: <94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com>
References: <m2mz5jegka.fsf@ziti.local>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 19 Dec 2006 23:04:07 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <m2mz5jegka.fsf@ziti.local>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34862>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwo0D-0004JM-SB for gcvg-git@gmane.org; Wed, 20 Dec
 2006 00:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933059AbWLSXCu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 18:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933057AbWLSXCl
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 18:02:41 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:46886 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S933058AbWLSXCT (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 18:02:19 -0500
Received: from [192.168.1.6] (cpe-66-67-221-135.rochester.res.rr.com
 [66.67.221.135]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by silverinsanity.com (Postfix) with ESMTP id
 1C0441FFD321; Tue, 19 Dec 2006 23:02:15 +0000 (UTC)
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org


On Dec 19, 2006, at 4:12 PM, Seth Falcon wrote:

> git version 1.4.4.2.gee60-dirty
> (the dirty is a hand edit to Makefile for prefix)

Just FYI:  You can save Makefile variables in a "config.mak" file  
instead of having to dirty your working tree (and dealing with  
conflicts, etc).  For example:

cat > config.mak <<EOF
prefix=/your/prefix/path/here/
EOF

Mine also has a few variables like "COLLISION_CHECK=paranoid" and my  
own prefix.

