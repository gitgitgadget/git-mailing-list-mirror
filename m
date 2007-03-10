From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-log --full-history renamed-file
Date: Fri, 9 Mar 2007 18:14:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703091813240.10832@woody.linux-foundation.org>
References: <87lki6umts.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0703091339190.10832@woody.linux-foundation.org>
 <7v8xe53ok5.fsf@assigned-by-dhcp.cox.net> <est24q$p4n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 03:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPr6X-0007QC-Oy
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 03:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbXCJCOg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 21:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbXCJCOg
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 21:14:36 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57230 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbXCJCOf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 21:14:35 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2A2EXo4024941
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 18:14:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2A2EXTW009027;
	Fri, 9 Mar 2007 18:14:33 -0800
In-Reply-To: <est24q$p4n$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.491 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41841>



On Sat, 10 Mar 2007, Jakub Narebski wrote:
>
> By the way, while it is fairly easy to follow one file, it is hard
> to follow directory or glob...

Don't even try. Make it clear that the rename-following automatically 
means that you only do the trivially obvious cases. Anything else is 
madness.

If you want to know where something actually comes from, use "blame".

		Linus
