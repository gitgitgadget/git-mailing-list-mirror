From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: My git repo is broken, how to fix it ?
Date: Thu, 22 Mar 2007 10:10:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703221006360.6730@woody.linux-foundation.org>
References: <200702281036.30539.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703200836490.6730@woody.linux-foundation.org>
 <200703210956.50018.litvinov2004@gmail.com> <200703211024.04740.litvinov2004@gmail.com>
 <Pine.LNX.4.64.0703220858400.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703220924590.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703220931120.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703221257020.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 18:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUQoT-00089O-Tr
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 18:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934128AbXCVRKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 13:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934122AbXCVRKy
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 13:10:54 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40495 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934136AbXCVRKx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 13:10:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2MHAPG9010985
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Mar 2007 10:10:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2MHAOpj025285;
	Thu, 22 Mar 2007 10:10:24 -0700
In-Reply-To: <alpine.LFD.0.83.0703221257020.18328@xanadu.home>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42869>



On Thu, 22 Mar 2007, Nicolas Pitre wrote:

> On Thu, 22 Mar 2007, Linus Torvalds wrote:
> 
> > I can't really say whether there are other problems too - electric fence 
> > has a few bugs in that it considers zero-length allocations to be 
> > "probably a bug" and aborts. This makes some of the tests fail with 
> > efence, when re_compile_internal wants to allocate a zero-length object.
> 
> You can tell it not to abort on zero-length allocations by setting the 
> EF_ALLOW_MALLOC_0 environment variable to 1.

Ahh,that gets me further, but then it bombs out on the added error 
messages. Is there something for that braindamage too?

(if it at least tested it with "isatty()" or something I'd understand it, 
as it is, it has made my life miserable in the past too.. I like efence, 
but bruce seems to think his ego is more important than the program 
you're debugging.)

		Linus
