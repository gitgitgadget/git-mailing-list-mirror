From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Deltification library work by Nicolas Pitre.
Date: Thu, 19 May 2005 07:38:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505190736020.2322@ppc970.osdl.org>
References: <7vwtpv1pd4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.62.0505191019180.20274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 16:36:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYm7i-0005Kh-Mf
	for gcvg-git@gmane.org; Thu, 19 May 2005 16:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVESOga (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 10:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVESOga
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 10:36:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:30133 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262524AbVESOg2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 10:36:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4JEaJU3018482
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 07:36:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4JEaHux023403;
	Thu, 19 May 2005 07:36:18 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505191019180.20274@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Nicolas Pitre wrote:
> 
> I'd prefer if the following patch was applied instead, following the 
> patch separation I've done already.

Sure. I'll apply this one and merge in Junio's rename on top of it, but I 
wanted to verify one thing first:

> + *  This file is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.

I don't know the different LGPL versions, so can somebody verify that LGPL
2.1 is fully compatible with GPLv2...

In fact I'd prefer to have that notice in the code to make it obvious that 
the LGPL becomes the GPLv2 when linked into the rest of git.

		Linus
