From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problems with autoCRLF?
Date: Fri, 9 Mar 2007 13:38:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703091337270.10832@woody.linux-foundation.org>
References: <1173464102.6102.18.camel@localhost>
 <200703092051.47441.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Raimund Bauer <ray007@gmx.net>, git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 22:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPmoI-0002m8-OZ
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 22:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767556AbXCIVjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 16:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767558AbXCIVjS
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 16:39:18 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50307 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767556AbXCIVjR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 16:39:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l29Lcro4017252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Mar 2007 13:38:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l29LcqbN003418;
	Fri, 9 Mar 2007 13:38:52 -0800
In-Reply-To: <200703092051.47441.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=-0.494 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41813>



On Fri, 9 Mar 2007, Robin Rosenberg wrote:

> fredag 09 mars 2007 19:15 skrev Raimund Bauer:
> > Is it really intended that with a setting core.autoCRLF=true textfiles
> > are checked out with crlf-lineendings on linux-boxes?
> > 
> > I found out because the git-compilation broke ...
> > 
> > Now using core.autocrlf=input ;-)
> 
> My guess is it's good for testing without having to compromise your 
> computer (or with cygwin).

Exactly. I'd much rather have git work consistently across different 
architectures, so that we can develop and test the CRLF code under UNIX, 
without having to actually have to use the brain damage that is Windows.

So yes, don't set "core.autocrlf=true" under UNIX. It will "work", but it 
will work exactly in the sense of "you can test what we'd do under 
Windows" ;)

		Linus
