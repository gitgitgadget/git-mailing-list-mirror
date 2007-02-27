From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 15:04:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271503140.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702271356300.12485@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702272322590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 00:04:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMBNC-0005YR-LB
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 00:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbXB0XEk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 18:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbXB0XEk
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 18:04:40 -0500
Received: from smtp.osdl.org ([65.172.181.24]:56316 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997AbXB0XEj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 18:04:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RN4LhB021656
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 15:04:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RN4KPv031555;
	Tue, 27 Feb 2007 15:04:21 -0800
In-Reply-To: <Pine.LNX.4.63.0702272322590.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.441 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40835>



On Tue, 27 Feb 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 27 Feb 2007, Linus Torvalds wrote:
> 
> > Side note: one of the reasons I like having more fine-grained date flags 
> > is that I've occasionally wanted a "show in UTC time" or "show 
> > everything in *my* local time" option.
> 
> I found the --relative-date option very useful to that end, if a bit long 
> to type.

That really doesn't work for stuff that is more than a day old. The 
difference between "3 weeks ago" and "3 weeks ago" is not usually very 
obvious.

(Hint: often they are days apart, but the relative date-format will just 
hide any differences due to excessive granularity).

			Linus
