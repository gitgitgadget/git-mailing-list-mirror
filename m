From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: empty patch-2.6.13-git? patches on ftp.kernel.org
Date: Fri, 2 Sep 2005 02:00:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509020159110.3613@evo.osdl.org>
References: <Pine.BSO.4.62.0508311527340.10416@rudy.mif.pg.gda.pl>
 <1125649389.6928.19.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 11:00:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB7PD-0007Dt-1Z
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 11:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVIBJAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 05:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVIBJAK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 05:00:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32440 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750901AbVIBJAI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 05:00:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j828xkBo001671
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Sep 2005 01:59:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j828xh9A030561;
	Fri, 2 Sep 2005 01:59:45 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1125649389.6928.19.camel@baythorne.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8010>



On Fri, 2 Sep 2005, David Woodhouse wrote:
> 
> 	rm -rf tmp-empty-tree
> 	mkdir -p tmp-empty-tree/.git
> 	cd tmp-empty-tree

Ahh. Please change that to

	rm -rf tmp-empty-tree
	mkdir tmp-empty-tree
	cd tmp-empty-tree
	git-init-db

because otherwise you'll almost certainly hit something else later on..

		Linus
