X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: remotes/* for "foreign" archives
Date: 21 Nov 2006 08:53:17 -0800
Message-ID: <86lkm4kagy.fsf@blue.stonehenge.com>
References: <86y7q6m3zm.fsf@blue.stonehenge.com>
	<86r6vwkfti.fsf@blue.stonehenge.com> <m2y7q4bzo7.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 16:53:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.14.18; tzolkin = 5 Etznab; haab = 11 Ceh
In-Reply-To: <m2y7q4bzo7.fsf@ziti.local>
Original-Lines: 15
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32002>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmYs9-0004bJ-QC for gcvg-git@gmane.org; Tue, 21 Nov
 2006 17:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031146AbWKUQxV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 11:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031182AbWKUQxV
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 11:53:21 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:6209 "EHLO
 blue.stonehenge.com") by vger.kernel.org with ESMTP id S1031146AbWKUQxU
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 11:53:20 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 3D8808FED7; Tue, 21 Nov 2006 08:53:20 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 30719-01-52; Tue, 21 Nov 2006 08:53:17 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id B8F208FEFB;
 Tue, 21 Nov 2006 08:53:17 -0800 (PST)
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

>>>>> "Seth" == Seth Falcon <sethfalcon@gmail.com> writes:

Seth> This sort of integration could be quite cool.  But I think the most
Seth> common use of git-svn is with rebase and not pull.  My experience
Seth> with git-svn and pull is that I very quickly ended up making broken
Seth> commits to svn --- I've had much better luck rebasing.

Well, you'd still be using "git-fetch origin" then, transparently,
and your push command could do your preferred thing.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
