From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and symlinks as tracked content
Date: Tue, 3 May 2005 13:05:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org>
References: <1115145234.21105.111.camel@localhost.localdomain>
 <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
 <Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 21:57:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3WU-0002Hv-Hy
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVECUDy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 16:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVECUDy
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 16:03:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:45965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261671AbVECUDu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 16:03:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43K3as4014286
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 13:03:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43K3Z06012875;
	Tue, 3 May 2005 13:03:35 -0700
To: Andreas Gal <gal@uci.edu>
In-Reply-To: <Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Andreas Gal wrote:
> 
> Yuck. Thats really ugly. Right now all files have a uniform touch to them. 
> For every hash you can locate the file, determine its type/tag, unpack it, 
> and check the SHA1 hash. The proposal above breaks all that. Why not just 
> introduce a new object type "dev" and put major minor in there. It 
> will still always hash to the same SHA1 hash value, but fits much better in the 
> overall design. 

Hey, I don't personally care that much. I don't see anybody using 
character device nodes in the kernel tree, and I don't think most SCM's 
support stuff like that anyway ;)

If you want to make it a blob (and have a use for it), go wild. 

		Linus
