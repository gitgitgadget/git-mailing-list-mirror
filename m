X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-merge-recursive-old?
Date: 29 Nov 2006 07:09:06 -0800
Message-ID: <86zmaawar1.fsf@blue.stonehenge.com>
References: <868xhuxpun.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0611291606410.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 15:09:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.15.6; tzolkin = 13 Cimi; haab = 19 Ceh
In-Reply-To: <Pine.LNX.4.63.0611291606410.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Original-Lines: 20
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32643>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpR3g-0005w2-Pr for gcvg-git@gmane.org; Wed, 29 Nov
 2006 16:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967397AbWK2PJJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 10:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967400AbWK2PJI
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 10:09:08 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:56367 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S967397AbWK2PJH (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 10:09:07 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 260D08F9C8; Wed, 29 Nov 2006 07:09:07 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 20293-01-9; Wed, 29 Nov 2006 07:09:06 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 78C948FB3B;
 Wed, 29 Nov 2006 07:09:06 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

>>>>> "Johannes" == Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

Johannes> Hi,
Johannes> On Wed, 29 Nov 2006, Randal L. Schwartz wrote:

>> I build daily, and apaprently I built git-merge-recursive-old,
>> but it's not in .gitignore.  Needs to be added, no?

Johannes> To the contrary. You need to remove it: v1.4.4-g7cdbff1 removed it, but 
Johannes> you still have the generated file...

yes, I see that now.  It's too bad there's no mechanism for git to inform
trackers that this is not a mistake, but merely human action required.  I
can't immediately think of any way to do it though.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
