From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cvsimport bug on branches [was: conversion to git]
Date: Fri, 21 Sep 2007 08:42:52 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709210840190.16478@woody.linux-foundation.org>
References: <loom.20070920T010842-272@post.gmane.org> <46F31BBB.1040901@byu.net>
 <8D5EA3F4-9642-4604-963E-838D03650FBC@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Eric Blake <ebb9@byu.net>, m4-patches@gnu.org,
	Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Sep 21 17:44:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYkgc-0007ib-05
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 17:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761044AbXIUPob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 11:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761017AbXIUPoa
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 11:44:30 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51224 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759444AbXIUPo3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2007 11:44:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8LFgZhf017492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 21 Sep 2007 08:42:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8LFgXUA010448;
	Fri, 21 Sep 2007 08:42:34 -0700
In-Reply-To: <8D5EA3F4-9642-4604-963E-838D03650FBC@zib.de>
X-Spam-Status: No, hits=-2.744 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.39__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58860>



On Fri, 21 Sep 2007, Steffen Prohaska wrote:
> 
> Hard to say. The best is to avoid git-cvsimport if you need
> to import branches correctly.

Yes. git-cvsimport started out as a pretty quick hack, and depends on 
cvsps which is another fairly hacky thing.

The big advantage of git-cvsimport is that it can do incremental imports, 
which I don't think the other methods do. But if there is any choice at 
all, and especially if you're not that interested in the incremental 
feature (ie you can cut over to git, and perhaps use git-cvsserver to 
"supprt" CVS users) the other CVS importers are likely to be much better.

			Linus
