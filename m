From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: list all dirty files in working directory
Date: Thu, 5 May 2005 19:06:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505051905200.2328@ppc970.osdl.org>
References: <20050505212152.GP20994@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 06 03:58:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTs6T-0004ez-Nz
	for gcvg-git@gmane.org; Fri, 06 May 2005 03:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVEFCEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 22:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVEFCEm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 22:04:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:46821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262195AbVEFCEk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2005 22:04:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4624ZU3014061
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 May 2005 19:04:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4624YQB021596;
	Thu, 5 May 2005 19:04:35 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050505212152.GP20994@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 5 May 2005, Thomas Glanzmann wrote:
>
> is there another way than call 'checkout-cache -a' and parse the output?
> Maybe a command which lists one dirty file per line?

A simple

	git-diff-files

does what I think you want.

Of course, it does a lot more too, but part of the deal is that you get to 
know which files are dirty.

		Linus
