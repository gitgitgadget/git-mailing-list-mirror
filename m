From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Fri, 5 Jan 2007 16:11:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701051610290.3661@woody.osdl.org>
References: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
 <Pine.LNX.4.64.0701031737300.4989@woody.osdl.org> <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com>
 <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com>
 <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com>
 <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net>
 <204011cb0701051503m3a431e07qc12662eecc08884f@mail.gmail.com>
 <7v64bldqas.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701051515000.3661@woody.osdl.org>
 <7vac0xc9g8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Lee <chris133@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 01:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2z9s-0001cF-66
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 01:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXAFALd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 19:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbXAFALd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 19:11:33 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44606 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbXAFALc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 19:11:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l060BQWi014553
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 5 Jan 2007 16:11:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l060BPRK011170;
	Fri, 5 Jan 2007 16:11:25 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac0xc9g8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.67 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36055>



On Fri, 5 Jan 2007, Junio C Hamano wrote:
> 
> Even if it is a read-only private mapping?  Would MAP_SHARED
> help?

mmap is mmap, and it all boils down to having to remove it from the page 
tables.

But it really shouldn't be a problem. 

		Linus
