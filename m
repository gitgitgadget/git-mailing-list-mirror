From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git tree for old kernels from before the current tree
Date: Mon, 23 Jul 2007 11:02:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707231057480.3607@woody.linux-foundation.org>
References: <9e4733910707221349s462aa11bj714956f7cdc72aac@mail.gmail.com>
 <Pine.LNX.4.64.0707222257540.32367@fbirervta.pbzchgretzou.qr>
 <20070722211314.GA13850@linux-sh.org> <Pine.LNX.4.64.0707222344540.32367@fbirervta.pbzchgretzou.qr>
 <Pine.LNX.4.64.0707230000170.32367@fbirervta.pbzchgretzou.qr>
 <46A3D5EA.2050600@zytor.com> <alpine.LFD.0.999.0707230950340.3607@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707231343350.6355@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Paul Mundt <lethal@linux-sh.org>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jul 23 20:04:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID2GS-0005Qn-91
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 20:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765323AbXGWSEB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 14:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764382AbXGWSEA
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 14:04:00 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36435 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1764336AbXGWSD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jul 2007 14:03:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NI2kxl014892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jul 2007 11:02:49 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6NI2dOW004388;
	Mon, 23 Jul 2007 11:02:40 -0700
In-Reply-To: <alpine.LFD.0.999.0707231343350.6355@xanadu.home>
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.14__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53455>



On Mon, 23 Jul 2007, Nicolas Pitre wrote:
> 
> I started this once.
> 
> I have (sort of) a GIT tree with all Linux revisions that I could find 
> from v0.01 up to v1.0.9.  But the most interesting information and also 
> what is the most time consuming is the retrieval of announcement 
> messages for those releases in old mailing list or newsgroup archives to 
> serve as commit log data.  It seems to be even arder to find for post 
> v1.0 releases.

Yes, I agree. Google finds some of them, but (a) I was never very good 
about announcements anyway and (b) there's nothing really good to search 
for, so it's very hit-and-miss.

Some of the really early release notes are easy to find, just because I 
made them available with the sources, but mostly I'd just have posten to 
the newsgroup/mailing lists.

If somebody creates a reasonably good tree (ie all the trees, easily 
diffable, tied together with at least *some* commit history and the most 
easily found release notes), I'm willing to try to spend some time just 
writing down recollections from looking at the diffs. Not very reliable, 
but better than nothing. This is the kind of thing that the "notes" thing 
could be useful for, since there are others around who might also be 
interested in adding their commentary.

		Linus
