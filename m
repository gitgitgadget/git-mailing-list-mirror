From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 18:06:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505301801520.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <972477.0a6782ba1d3b9f05216ed520ef720fcf.ANY@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 03:02:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcv97-0002eV-Ka
	for gcvg-git@gmane.org; Tue, 31 May 2005 03:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVEaBEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 21:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVEaBEa
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 21:04:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:24493 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261853AbVEaBEX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 21:04:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4V14KjA010980
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 30 May 2005 18:04:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4V14KKx025341;
	Mon, 30 May 2005 18:04:20 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <972477.0a6782ba1d3b9f05216ed520ef720fcf.ANY@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 30 May 2005, Chris Wedgwood wrote:
> 
> I'm still at a loss how to do the equivalent of annotate.  I know a
> couple of front ends can do this but I have no idea what command line
> magic would be equivalent.

There isn't any. It's actually pretty nasty to do, following history 
backwards and keeping track of lines as they are added. I know how, I'm 
just really lazy and hoping somebody else will do it, since I really end 
up not caring that much myself.

I notice that Thomas Gleixner seems to have one, but that one is based on 
a database, and doesn't look usable as a standalone command..

		Linus
