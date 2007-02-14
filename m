From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 08:37:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702140835440.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <200702141736.57521.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:37:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHN8X-000782-GK
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbXBNQhi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbXBNQhi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:37:38 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34736 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932377AbXBNQhi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:37:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EGbYhB007646
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 08:37:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EGbYIx002742;
	Wed, 14 Feb 2007 08:37:34 -0800
In-Reply-To: <200702141736.57521.litvinov2004@gmail.com>
X-Spam-Status: No, hits=-0.41 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39674>



On Wed, 14 Feb 2007, Alexander Litvinov wrote:
> 
> I just tried this patch and it works! From now I can use git-cvsimport under 
> Linux and then clone it to cygwin and work there with full history. Nice, 
> very nice.

Btw, it didn't do any commit message conversion etc, so you'll still 
always see commit messages with LF-only, and if you _create_ commits, you 
need to make sure that whatever program you use will do the right thing.

> In my case text file detection work well as far most of our files 
> are .cpp and .h

Yeah, considering that it worked in my testing for "git" itself, I'm not 
surprised. Source code tends to look the same..

		Linus
