X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 14:59:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611211456520.3338@woody.osdl.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org>
 <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
 <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 22:59:53 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32054>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmeaF-0007kK-QF for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031291AbWKUW7P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 17:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031301AbWKUW7P
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:59:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:32234 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1031291AbWKUW7O (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 17:59:14 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kALMx2ix007656
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 21
 Nov 2006 14:59:03 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kALMx0Kl012498; Tue, 21 Nov
 2006 14:59:02 -0800
To: Yann Dirson <ydirson@altern.org>
Sender: git-owner@vger.kernel.org



On Tue, 21 Nov 2006, Linus Torvalds wrote:
> 
> Submodules are _directories_.

Side note - you can do submodules other ways, but if you do, you'll almost 
certainly go crazy. 

You could, for example, make submodules be some kind of "union 
filesystem", where you allow overlapping trees. It's conceptually 
possible. It's also horribly horribly wrong, if only because I guarantee 
that you'll have so many problems with it that you will only end up with a 
mess that is even worse than "branches" in CVS.

