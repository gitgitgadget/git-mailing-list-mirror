From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 16:49:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505261648360.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
 <faf0d98cb35ad4b51c55d23d851093b5.ANY@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 01:46:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbS2s-0000Lu-By
	for gcvg-git@gmane.org; Fri, 27 May 2005 01:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVEZXrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 19:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVEZXrf
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 19:47:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:33430 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261859AbVEZXrZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 19:47:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4QNlHjA015847
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 May 2005 16:47:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4QNlFLZ021938;
	Thu, 26 May 2005 16:47:16 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <faf0d98cb35ad4b51c55d23d851093b5.ANY@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, Chris Wedgwood wrote:
>
> On Thu, May 26, 2005 at 12:19:21PM -0700, Linus Torvalds wrote:
> 
> > 	deleted file mode 100644 arch/um/kernel/checksum.c
> 
> why do we care about the mode here?

Junio makes the (correct) argument that patches should be reversible.

And the reverse of a delete is a create. And thus the file mode of the
file that got deleted matters.

		Linus
