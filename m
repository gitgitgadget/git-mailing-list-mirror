From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] fork optional branch point normazilation
Date: Sun, 17 Apr 2005 16:39:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171636590.7211@ppc970.osdl.org>
References: <Pine.LNX.4.44.0504171614150.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:33:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJGe-0006IU-Tf
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVDQXhV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVDQXhV
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:37:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:28349 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261558AbVDQXhQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 19:37:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HNbCs4029490
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 16:37:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HNbBs7013318;
	Sun, 17 Apr 2005 16:37:12 -0700
To: Brad Roberts <braddr@puremagic.com>
In-Reply-To: <Pine.LNX.4.44.0504171614150.2625-100000@bellevue.puremagic.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Brad Roberts wrote:
>
> braddr:x:1000:1000:Brad Roberts,,,:/home/braddr:/bin/bash
> 
> All gecos entries on all my debian boxes are of the form:
> 
>    fullname, office number, office extension, and home number

Ahh, ok.

I'll make the "cleanup" thing just remove strange characters from the end, 
that should fix this kind of thing for now.

I'd just remove everything after the first strange number, but I can also 
see people using the "lastname, firstname" format, and I'd hate to just 
ignore firstname in that case.

		Linus
