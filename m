From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH] git-svn: Added 'find-rev' command
Date: Sat, 28 Apr 2007 12:22:13 -0700
Message-ID: <CB101F10-559A-4FB9-A76B-E185943BAF2A@apple.com>
References: <117770027350-git-send-email-aroben@apple.com> <20070427193004.GC12375@untitled> <7vbqh9kov9.fsf@assigned-by-dhcp.cox.net> <20070428105016.GA11271@muzzle>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Apr 28 21:23:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhsW6-0002Pv-Bz
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 21:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbXD1TW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 15:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbXD1TWw
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 15:22:52 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:61239 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030766AbXD1TWc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 15:22:32 -0400
Received: from relay7.apple.com (a17-128-113-37.apple.com [17.128.113.37])
	by mail-out4.apple.com (8.13.8/8.13.8) with ESMTP id l3SJMTaG016691;
	Sat, 28 Apr 2007 12:22:29 -0700 (PDT)
Received: from relay7.apple.com (unknown [127.0.0.1])
	by relay7.apple.com (Symantec Mail Security) with ESMTP id D7CF330526;
	Sat, 28 Apr 2007 12:22:29 -0700 (PDT)
X-AuditID: 11807125-a1c50bb00000097b-cd-46339ef5176b 
Received: from [17.219.210.16] (unknown [17.219.210.16])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay7.apple.com (Apple SCV relay) with ESMTP id 832BF304CA;
	Sat, 28 Apr 2007 12:22:29 -0700 (PDT)
In-Reply-To: <20070428105016.GA11271@muzzle>
X-Mailer: Apple Mail (2.752.3)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45794>

On Apr 28, 2007, at 3:50 AM, Eric Wong wrote:

> Adam:
>
> However, since we're not fetching ranges...
>
> You can do $gs->rev_db_get($rev_nr) to easily find a commit given a
> revision.  Bonus points if this works independently of the current  
> HEAD
> so you can look up revision numbers on different branches.  (git- 
> svn log
> should be made to support this, too)

    OK, I'll do that and send out a new patch.

-Adam
