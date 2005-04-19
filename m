From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 15:49:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191548500.2274@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com>
 <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org> <20050419223945.GG9305@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Wed Apr 20 00:44:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1Ru-0007QT-UU
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 00:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbVDSWsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 18:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVDSWsL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 18:48:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:7874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261719AbVDSWsE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 18:48:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JMlls4025171
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 15:47:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JMljN6004503;
	Tue, 19 Apr 2005 15:47:46 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419223945.GG9305@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 20 Apr 2005, Petr Baudis wrote:
> 
> I will probably not buy git-export, though. (That is, it is merged, but
> I won't make git frontend for it.) My "git export" already does
> something different, but more importantly, "git patch" of mine already
> does effectively the same thing as you do, just for a single patch; so I
> will probably just extend it to do it for an (a,b] range of patches.

That's fine. It was a quick hack, just to show that if somebody wants to, 
the data is trivially exportable.

		Linus
