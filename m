From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 10:41:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506031035470.1876@ppc970.osdl.org>
References: <20050603152212.GA4598@jmcmullan.timesys>
 <Pine.LNX.4.58.0506030856490.1876@ppc970.osdl.org> <1117814982.32257.64.camel@jmcmullan.timesys>
 <Pine.LNX.4.58.0506030929150.1876@ppc970.osdl.org> <1117819137.32257.75.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 03 19:39:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeG5u-0000qL-21
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 19:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVFCRjm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 13:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVFCRjm
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 13:39:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:5867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261416AbVFCRjl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 13:39:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j53HdbjA011846
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 3 Jun 2005 10:39:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j53HdaUD002889;
	Fri, 3 Jun 2005 10:39:37 -0700
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
In-Reply-To: <1117819137.32257.75.camel@jmcmullan.timesys>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 3 Jun 2005, McMullan, Jason wrote:
> 
> ###### Create a new local git repo
> 
> $ GITCONN="--tcp --host 192.168.1.1 --port 7777"
> $ git-init-db
> $ git-server $GITCONN -- request master

Ok. Am I to understand that I could do a push to a remote server with ssh 
using something like

	git-server -- send master |
		ssh master.kernel.org git-server --db /pub/scm/linux/kernel/git/torvalds/linux-2.6.git

or what?

Also, how do I send tags?

			Linus
