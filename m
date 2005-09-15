From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
Date: Thu, 15 Sep 2005 07:39:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509150737030.26803@g5.osdl.org>
References: <7255.1126583985@kao2.melbourne.sgi.com> 
 <1126674993.5681.9.camel@localhost.localdomain> <1126745323.7199.3.camel@localhost.localdomain>
 <Pine.LNX.4.58.0509142018410.26803@g5.osdl.org> <43290486.5020301@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 16:43:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFutj-0001NF-0q
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 16:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbVIOOjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 10:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965266AbVIOOjY
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 10:39:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41882 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965265AbVIOOjX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 10:39:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8FEdHBo022552
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Sep 2005 07:39:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8FEdDj6004227;
	Thu, 15 Sep 2005 07:39:15 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43290486.5020301@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8607>



On Wed, 14 Sep 2005, H. Peter Anvin wrote:
> 
> Generally you want to honour $PAGER if it is defined.

We do. But it falls back to "less" by default.

I realize that UNIX tradition is to fall back to "more", but let's face
it, that's just old and broken. There's "tradition" and there's "being
stupid and unable to change".

Of course, if RPM supports the notion of "suggest", maybe we can make 
"less" a suggestion rather than a requirement, since you can still use git 
without it as long as you set PAGER.

		Linus
