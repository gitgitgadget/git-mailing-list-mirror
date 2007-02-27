From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] show_date(): rename the "relative" parameter to "mode"
Date: Tue, 27 Feb 2007 13:41:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271339550.12485@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 27 22:41:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMA4q-0000pt-Oa
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 22:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbXB0Vli (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 16:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbXB0Vli
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 16:41:38 -0500
Received: from smtp.osdl.org ([65.172.181.24]:53351 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbXB0Vlh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 16:41:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1RLfGhB019098
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 13:41:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1RLfFgv029461;
	Tue, 27 Feb 2007 13:41:16 -0800
In-Reply-To: <Pine.LNX.4.63.0702271620390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.434 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40809>



On Tue, 27 Feb 2007, Johannes Schindelin wrote:
> 
> Now, show_date() can print three different kinds of dates: normal,
> relative and short (%Y-%m-%s) dates.
> 
> To achieve this, the "int relative" was changed to "enum date_mode
> mode", which has three states: DATE_NORMAL, DATE_RELATIVE and
> DATE_SHORT.

Ack. I think this kind of thing is worth it regardless of any of the other 
issues (ie the whole "changelog" thing). 

		Linus
