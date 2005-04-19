From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 15:43:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191539000.2274@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com>  <20050419185807.GA1191@kroah.com>
  <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>  <20050419194728.GA24367@kroah.com>
  <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>  <20050419214009.GA25681@kroah.com>
  <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org> <1113949783.2129.4.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 00:39:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1Ma-0006us-9j
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVDSWmU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVDSWmT
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:42:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:52928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261712AbVDSWmN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:42:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JMg1s4024700
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 15:42:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JMfuK5004167;
	Tue, 19 Apr 2005 15:41:58 -0700
To: Martin Schlemmer <azarah@nosferatu.za.org>
In-Reply-To: <1113949783.2129.4.camel@nosferatu.lan>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Martin Schlemmer wrote:
> 
> Correct me if I am wrong, but the right way to do this is to set the
> hostname to just that - the hostname, and add 'domain foo.com'
> to /etc/resolv.conf. 

I'll correct you.

The fact is, that's not what people do. Not me, not kernel.org, not _any_
of the machines I've got access to. They put the fully qualified name in 
the hostname, and just do "search foo.com" in /etc/resolv.conf.

So clearly, expecting that people work the way you claim is being
extremely optimistic. I'm sure some people do that too, but I suspect I'm
in the majority. Both Fedora Core and YellowDog act the way I described, 
not the way you do..

		Linus
