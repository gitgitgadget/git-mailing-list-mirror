From: Linus Torvalds <torvalds@osdl.org>
Subject: RE: Compilation troubles
Date: Tue, 12 Jul 2005 13:27:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507121321200.17536@g5.osdl.org>
References: <5EDB10423795F248B2A4C4957409ED680280D603@exch-calgary.int.pason.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dan Kohn <dan@dankohn.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 22:36:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsRSx-0003wI-V1
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 22:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVGLUeU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 16:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbVGLU1r
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 16:27:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2236 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262385AbVGLU1i (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 16:27:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6CKRWjA030615
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 12 Jul 2005 13:27:32 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6CKRVVE000444;
	Tue, 12 Jul 2005 13:27:31 -0700
To: Jerry Seutter <Jerry.Seutter@pason.com>
In-Reply-To: <5EDB10423795F248B2A4C4957409ED680280D603@exch-calgary.int.pason.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 12 Jul 2005, Jerry Seutter wrote:
> 
> The README file for cogito/git mentions that there is an ssl library
> included in the source which you can use if you don't have openssl.  It
> doesn't give any directions on how to use it, however.  You could try
> looking into using that.

Use

	make MOZILLA_SHA1=1

to use the included mozilla-based SHA1 library.

(Or just do "export MOZILLA_SHA1=1" in your .bashrc so that you always do 
this).

There's also a "PPC_SHA1" which works the same way, and which enables the 
optimized ppc assembly language version. It used to make a big difference 
for me, but it seems modern openssl libraries already have something 
fairly optimized (on my YDL machine the openssl version was really slow).

		Linus
