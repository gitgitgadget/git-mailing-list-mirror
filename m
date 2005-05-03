From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: git and symlinks as tracked content
Date: Tue, 03 May 2005 22:09:19 +0200
Message-ID: <1115150959.21105.116.camel@localhost.localdomain>
References: <1115145234.21105.111.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
	 <Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
	 <Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andreas Gal <gal@uci.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 22:04:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3bq-00045x-Hg
	for gcvg-git@gmane.org; Tue, 03 May 2005 22:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVECUJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 16:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVECUJX
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 16:09:23 -0400
Received: from soundwarez.org ([217.160.171.123]:38808 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261601AbVECUJU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 16:09:20 -0400
Received: from dhcp-113.off.vrfy.org (c169067.adsl.hansenet.de [213.39.169.67])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 694442C982;
	Tue,  3 May 2005 22:09:18 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-05-03 at 13:05 -0700, Linus Torvalds wrote:
> 
> On Tue, 3 May 2005, Andreas Gal wrote:
> > 
> > Yuck. Thats really ugly. Right now all files have a uniform touch to them. 
> > For every hash you can locate the file, determine its type/tag, unpack it, 
> > and check the SHA1 hash. The proposal above breaks all that. Why not just 
> > introduce a new object type "dev" and put major minor in there. It 
> > will still always hash to the same SHA1 hash value, but fits much better in the 
> > overall design. 
> 
> Hey, I don't personally care that much. I don't see anybody using 
> character device nodes in the kernel tree, and I don't think most SCM's 
> support stuff like that anyway ;)

Well, you need to be root to create device nodes, that is not a usual
requirement for an SCM checkout. :)

Kay

