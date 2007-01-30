From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 11:37:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701301135290.3611@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <Pine.LNX.4.64.0701300906260.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBynw-0001j7-Rv
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbXA3Thx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbXA3Thx
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:37:53 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44574 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbXA3Thw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:37:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0UJbY1m020555
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Jan 2007 11:37:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0UJbXB3026777;
	Tue, 30 Jan 2007 11:37:34 -0800
In-Reply-To: <Pine.LNX.4.64.0701300906260.3611@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.45 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38197>



On Tue, 30 Jan 2007, Linus Torvalds wrote:
> 
> We had this particular performance "anomaly" be discussed just the other 
> week. People seem to be so used to the "file ID" mentality that has its 
> roots in RCS etc, that they expect "git log <filename>" to somehow be 
> faster than "git log". In git, that's simply not true. History is *always* 
> seen as a "full repository history". There simply isn't anything else.

Side note: some people have talked about changing this by generating some 
kind of per-filename cache to make logging ops have an "accelerated" mode 
for the trivial cases.

So maybe git at some future date will have a special-case for a single 
filename, but that's definitely not the case today.

			Linus
