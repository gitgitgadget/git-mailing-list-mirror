From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 15:47:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191544410.2274@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com>
 <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org> <20050419214009.GA25681@kroah.com>
 <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org> <20050419222738.GA14566@nevyn.them.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:41:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1PV-0007B9-0X
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVDSWpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVDSWpm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:45:42 -0400
Received: from fire.osdl.org ([65.172.181.4]:31169 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261715AbVDSWph (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:45:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JMjYs4024963
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 15:45:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JMjTox004365;
	Tue, 19 Apr 2005 15:45:31 -0700
To: Daniel Jacobowitz <dan@debian.org>
In-Reply-To: <20050419222738.GA14566@nevyn.them.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Daniel Jacobowitz wrote:
> 
> Easiest might be to punt to hostname --fqdn, or an equivalent to its
> algorithm - which appears to be fetch the hostname from uname, do a DNS
> lookup on that, and a reverse DNS lookup on the result.

Hah. I'll just commit my patch, and for any setup where that doesn't work, 
people can set COMMIT_AUTHOR_EMAIL by hand.

		Linus
