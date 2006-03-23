From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Make dot-counting ignore ".1" at the end
Date: Wed, 22 Mar 2006 22:34:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603222232210.26286@g5.osdl.org>
References: <Pine.LNX.4.64.0603221723230.9196@g5.osdl.org> 
 <Pine.LNX.4.64.0603221746300.26286@g5.osdl.org> <1143095182.6850.23.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 23 07:34:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMJOp-00070r-MW
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 07:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWCWGeV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 01:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWCWGeU
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 01:34:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932151AbWCWGeU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Mar 2006 01:34:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2N6YHDZ005283
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Mar 2006 22:34:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2N6YGpr014222;
	Wed, 22 Mar 2006 22:34:16 -0800
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1143095182.6850.23.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17856>



On Wed, 22 Mar 2006, Keith Packard wrote:
> 
> No. 1.1.1.1 is the first import on the first vendor branch; 1.1 is the
> head of the tree.

Ok. Discard the second patch. The first one is definitely needed for cvsps 
right now, though.

With that in place (the "make sure we have a proper ancestor branch" 
thing), a "git cvsimport" of the binutils tree seems to be working, at 
least to the point that it seems to have imported 1400+ commits without 
undue complaints. But hey, I'm looking forward to something less 
hacked-together.

		Linus
