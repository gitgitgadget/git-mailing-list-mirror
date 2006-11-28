X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 13:49:43 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
 <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com>
 <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
 <456CA981.4010808@onlinehome.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 21:50:11 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456CA981.4010808@onlinehome.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32586>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpApv-0007A3-9p for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757080AbWK1Vtw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbWK1Vtw
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:49:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43170 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1757078AbWK1Vtv (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:49:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kASLniix005417
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 28
 Nov 2006 13:49:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kASLnhe3027122; Tue, 28 Nov
 2006 13:49:43 -0800
To: Nicholas Allen <nick.allen@onlinehome.de>
Sender: git-owner@vger.kernel.org



On Tue, 28 Nov 2006, Nicholas Allen wrote:
> 
> and here's how it looked in git:
> git status

Ehh. It told you exactly what happened when you actually did the merge, 
didn't it?

Yeah, "git status" won't tell you _why_ it results in unmerged paths, but 
the merge will have told you.  You must have seen that, but decided to 
just ignore it and not post it, because it didn't support the conclusion 
you wanted to get, did it?

There are lots of reasons why "git status" may tell you that something 
isn't merged. The most common one by far being an actual data conflict, 
not a name conflict. The reason for why something conflicts is always told 
at merge-time.

