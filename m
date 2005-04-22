From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mozilla SHA1 implementation
Date: Fri, 22 Apr 2005 08:40:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504220838340.2344@ppc970.osdl.org>
References: <87hdi5oet6.dancerj@netfort.gr.jp> <Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org>
 <20050418055824.42d621b8.froese@gmx.de> <Pine.LNX.4.58.0504211238150.2344@ppc970.osdl.org>
 <17000.43340.760901.175004@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0504220824480.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Edgar Toernig <froese@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 17:35:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP0AX-0003ny-0Y
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 17:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVDVPij (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 11:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVDVPij
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 11:38:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:14523 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261968AbVDVPi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 11:38:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3MFcOs4011234
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 08:38:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3MFcNuB029784;
	Fri, 22 Apr 2005 08:38:23 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.58.0504220824480.2344@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Apr 2005, Linus Torvalds wrote:
> 
> > I get the opposite result on my 2GHz G5: the Mozilla version does
> > 45MB/s, the openssl version does 135MB/s, and my version does 218MB/s.
> > The time for a fsck-cache on a linux-2.6 tree (cache hot) is 8.0
> > seconds for the Mozilla version, 5.2 seconds for the openssl version,
> > and 4.4 seconds for my version.
> 
> I get 16 seconds for the openssl one, and 8 for the Mozilla one. I'll try 
> your version.

Ok, I get 4.9s on my kernel archive, so this is definitely a big win. 

Can you sign off on the thing, since this is real new code? Let's do it 
right.

		Linus
