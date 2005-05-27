From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 11:13:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271112240.17402@ppc970.osdl.org>
References: <42971EB4.2050403@oberhumer.com> <Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org>
 <Pine.LNX.4.58.0505271024280.17402@ppc970.osdl.org> <42975C1F.8070102@oberhumer.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 20:11:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbjH1-0001kY-Iu
	for gcvg-git@gmane.org; Fri, 27 May 2005 20:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVE0SLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 14:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVE0SLc
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 14:11:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:11711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261978AbVE0SL1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 14:11:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RIBNjA026762
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 11:11:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RIBMRn001321;
	Fri, 27 May 2005 11:11:23 -0700
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
In-Reply-To: <42975C1F.8070102@oberhumer.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Markus F.X.J. Oberhumer wrote:
> 
> Many thanks. BTW, this is probably completely irrelevant on all 
> real-world machines and calling conventions, but still, lying on the 
> number of arguments in vararg-functions is not my favourite practice.

Only using a subset is guaranteed to work - it's not about "real-world 
machines", it's about the fact that it's not a C compiler any more if it 
doesn't work.

		Linus
