From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Wed, 4 May 2005 15:03:39 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505041501220.2328@ppc970.osdl.org>
References: <200505030657.38309.alonz@nolaviz.org> <200505041156.19499.mason@suse.com>
 <Pine.LNX.4.61.0505041202270.22203@cag.csail.mit.edu> <200505041344.51637.mason@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "C. Scott Ananian" <cscott@cscott.net>,
	Nicolas Pitre <nico@cam.org>, Alon Ziv <alonz@nolaviz.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 23:56:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTRqw-0004EV-6S
	for gcvg-git@gmane.org; Wed, 04 May 2005 23:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVEDWCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 18:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVEDWCj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 18:02:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:14753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261918AbVEDWCW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 18:02:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j44M1cU3006137
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 May 2005 15:01:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j44M1bRm018697;
	Wed, 4 May 2005 15:01:37 -0700
To: Chris Mason <mason@suse.com>
In-Reply-To: <200505041344.51637.mason@suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 4 May 2005, Chris Mason wrote:
>
> Yes, if Linus does take the patches, it's really important for people to be 
> able to easily continue without deltas/packing if they want.

I'll happily take the patch and just not use the delta packing myself (at 
least until I trust it). But before I take the patch I want to make sure 
that people agree on it, and that it's been tested well enough that it 
won't cause people to corrupt their repositories.

For example, I do _not_ want to be in the situation SVN is in, where if
you corrupt your SVN database, you're totally screwed. There's a real
advantage to not having fancy data structures or complicated consistency
rules.

			Linus
