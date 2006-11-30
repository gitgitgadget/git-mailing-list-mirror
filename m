X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git blame [was: git and bzr]
Date: Thu, 30 Nov 2006 10:44:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611301034420.3513@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net>
 <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>
 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org> <456CEF31.8080600@webdrake.net>
 <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org> <456D7A76.3080605@webdrake.net>
 <Pine.LNX.4.64.0611290830010.3395@woody.osdl.org> <456F21D6.1060200@webdrake.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 18:45:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <456F21D6.1060200@webdrake.net>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32787>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpqty-00044g-RZ for gcvg-git@gmane.org; Thu, 30 Nov
 2006 19:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967863AbWK3Sov (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 13:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967866AbWK3Sov
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 13:44:51 -0500
Received: from smtp.osdl.org ([65.172.181.25]:18337 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S967863AbWK3Sov (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 13:44:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUIinjQ002774
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 10:44:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUIimHe014898; Thu, 30 Nov
 2006 10:44:49 -0800
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
Sender: git-owner@vger.kernel.org



On Thu, 30 Nov 2006, Joseph Wakeling wrote:
> 
> What would be nice would be to have in the documentation a whole bunch
> of stupid examples for the main commands, something where someone can
> create a repo from scratch, create and modify some simple files
> according to instructions, and see the particular command in action.

100% agreed. A lot of the man-pages etc have been written to be about the 
technology, not about the _use_ of it.

I encouraged people at some point to add an "Examples" section to some of 
the functions to show what it all _means_, so for "man git-log", I think 
some of the most useful stuff is that examples section that shows the 
combination of revision naming and path-name limiting, for example. I 
personally think that that is a much better way of teaching people what 
the commands actually do than by mentioning the arguments one by one.

But that only exists for a couple of man-pages, and mostly for the simple 
ones at that. And a lot of the real examples would need "real data" to 
work on, so it can't easily be done as a trivial example in a man-page, it 
really needs a tutorial to "build up" to the situation where you can then 
explain with an example what to do.

> The tutorials do this, of course, but only for a few cases, when to be
> honest it's the more complex commands that most need such explanation.

Yeah. The git "tutorial.txt" should be extended, and preferably be a while 
nice set of "follow along with the bouncing ball" kind of web-page 
sequence.

So I absolutely agree. It's just that at least me personally, I just can't 
write documentation. I wrote some of the original tutorial, I've written 
some of the original tech docs, but I just can't get into the whole 
"document it" mindset, especially not from a user perspective. It doesn't 
float my boat, and judging by a lot of the discussions, I obviously also 
don't even see why something could _possibly_ cause confusion.

To make things worse, a lot of the docs (and by that I also mean some of 
the error messages and helpful hints) tend to be old.

The whole fact that "git commit" mentions "git update-index" is exactly 
that kind of thing: it's largely a legacy message. You'd almost never 
actually _use_ git-update-index itself these days, and it's much more 
convenient to just list the files you want to commit to "git commit" 
directly (or just use the -a flag, if that is what you want to do).

But that message exists, because it was written in an earlier age.

