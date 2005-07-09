From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What broke snapshots now?
Date: Sat, 9 Jul 2005 09:15:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507090908490.17536@g5.osdl.org>
References: <1120907336.8058.293.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 18:16:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrHzn-000383-Sr
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 18:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbVGIQPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jul 2005 12:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVGIQPn
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jul 2005 12:15:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47233 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261583AbVGIQPh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jul 2005 12:15:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j69GFQjA029784
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 9 Jul 2005 09:15:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j69GFPUZ006429;
	Sat, 9 Jul 2005 09:15:26 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1120907336.8058.293.camel@baythorne.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 9 Jul 2005, David Woodhouse wrote:
>
> Does git on master.kernel.org need to be updated to handle packed
> objects? See attached. 

Yes, looks that way. Except it's not "git on master.kernel.org", it's "git 
in your home directory", I suspect. I expressly held off packing the 
kernel repo until git had been updated on kernel.org.

So while the regular git on kernel.org should already be up-to-date, you
have

	PATH=/home/dwmw2/cogito:/usr/bin:/bin

in your script ;)

> Linus, please could you add the snapshot script to your regression
> testing? http://david.woodhou.se/git-snapshot.sh

None of the git-specific parts should have broken - you don't even do
anything strange there, I think we already have regression tests in git
for everything you use. But the fact that you had an old version is not 
something I can do much about ;)

		Linus
