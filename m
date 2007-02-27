From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 13:59:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271356300.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 22:59:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMALk-0000QZ-Nv
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXB0V7E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbXB0V7E
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:59:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53994 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbXB0V7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:59:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RLwihB019695
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 13:58:44 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RLwhQo029941;
	Tue, 27 Feb 2007 13:58:44 -0800
In-Reply-To: <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.436 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40819>



On Tue, 27 Feb 2007, Linus Torvalds wrote:
> 
> Ack. I think this kind of thing is worth it regardless of any of the other 
> issues (ie the whole "changelog" thing). 

Side note: one of the reasons I like having more fine-grained date flags 
is that I've occasionally wanted a "show in UTC time" or "show everything 
in *my* local time" option. Sometimes it's a bit hard to compare dates 
just because we show them as they were for the people who did them, not 
in any unified format ;)

I'm not sure how useful that really would end up being, but the whole 
approach of just having a "date mode" flag should at least make those 
kinds of things trivial if we ever really want it.

		Linus
