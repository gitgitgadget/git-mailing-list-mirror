From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Sat, 11 Aug 2007 13:38:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708111337280.30176@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org>
 <20070811190201.GB4710@ferdyx.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: moe <moe-git@mbox.bz>, git@vger.kernel.org
To: "Fernando J. Pereda" <ferdy@gentoo.org>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJxjc-0000wW-PI
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 22:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbXHKUiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 16:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753822AbXHKUiu
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 16:38:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37803 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751810AbXHKUit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 16:38:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BKcdRY017816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Aug 2007 13:38:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7BKcYd4024430;
	Sat, 11 Aug 2007 13:38:34 -0700
In-Reply-To: <20070811190201.GB4710@ferdyx.org>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55629>



On Sat, 11 Aug 2007, Fernando J. Pereda wrote:
> 
> Just for the record, I tried those patches on a real tree of ~120k files
> and ~25k directories, and Git is now _usable_. (The repository was
> created from an old checkout of the gentoo-x86 tree).

What does "usable" mean? Is it still slow ("barely usable") or is it 
actually fast enough to be truly _nice_ to use?

		Linus
