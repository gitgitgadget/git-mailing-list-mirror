X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
Date: Wed, 20 Dec 2006 14:14:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net> <86vek6z0k2.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 22:17:41 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86vek6z0k2.fsf@blue.stonehenge.com>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34968>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx9ko-0001ow-UI for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030387AbWLTWRS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWLTWRR
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:17:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44338 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1030379AbWLTWRQ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 17:17:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBKMEd2J009820
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 20
 Dec 2006 14:14:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBKMEcX0008221; Wed, 20 Dec
 2006 14:14:39 -0800
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Sender: git-owner@vger.kernel.org



On Wed, 20 Dec 2006, Randal L. Schwartz wrote:
> 
> Is this really in master?  I'm still seeing one-hour times on
> my Mac, using 8336afa563fbeff35e531396273065161181f04c.

Master right  now is at 54851157ac.

But I use the master site of kernel.org, and the public site mirrors 
probably haven't mirrored out yet.

Sometimes it can be worth it trying "git2.kernel.org" rather than 
"git.kernel.org", because the way the DNS round-robin works (badly), git1 
seems to get a lot more load than git2, so sometimes git2 gets updated 
before git1 does.

