From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with Linus's git repository?
Date: Tue, 26 Jun 2007 09:43:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706260935440.8675@woody.linux-foundation.org>
References: <f5r8q5$pbr$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 18:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3E9l-0004Vq-1j
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 18:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbXFZQoo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 12:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbXFZQon
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 12:44:43 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54407 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752920AbXFZQon (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2007 12:44:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QGi1Hj019537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2007 09:44:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QGhbi4030011;
	Tue, 26 Jun 2007 09:43:46 -0700
In-Reply-To: <f5r8q5$pbr$1@sea.gmane.org>
X-Spam-Status: No, hits=-2.61 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50965>



On Tue, 26 Jun 2007, walt wrote:
>
> For two days I've been unable to pull from Linus's kernel
> git repository.  The reason seems to be that HEAD is a
> symlink to refs/heads/master, which appears to be missing.

It's not missing, it's packed. I tend to re-pack after I make a release, 
and this time I did it after -rc6.

I assume you're using http, and probably not a very recent version.

> I'm wondering if Linus's personal version of git is broken ;o)

http fetching has always been the ugly step-child of the other protocols. 
I personally dislike it a lot. But it _should_ work even with packed refs, 
at least if recent enough.

I just tested, it seems to work for me (I didn't wait for the clone to 
succeed, but it certainly got started).

		Linus
