From: Chris Wright <chrisw@osdl.org>
Subject: Re: Add uninstall target to Makefile
Date: Fri, 16 Sep 2005 11:08:10 -0700
Message-ID: <20050916180810.GK8041@shell0.pdx.osdl.net>
References: <20050916125814.GA8084@igloo.ds.co.ug> <7vfys5ndor.fsf@assigned-by-dhcp.cox.net> <20050916175402.GC22825@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 16 20:12:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGKgr-0007zz-OB
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 20:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbVIPSLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbVIPSLt
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 14:11:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43968 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161223AbVIPSLr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 14:11:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GI8ABo003418
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 11:08:11 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GI8A0d004224;
	Fri, 16 Sep 2005 11:08:10 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j8GI8Aui004223;
	Fri, 16 Sep 2005 11:08:10 -0700
To: Junio C Hamano <junkio@cox.net>,
	Martin Atukunda <matlads@dsmagic.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050916175402.GC22825@tuxdriver.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8701>

* John W. Linville (linville@tuxdriver.com) wrote:
> > Sorry, I absolutely detest other peoples' Makefiles that has
> > this target.  Why would anybody want this?
> 
> Is this a serious question?  To uninstall the binaries e.g. if you
> installed them in the wrong place?

Of course package manager will do better at this, but it is useful to be
able to uninstall.  However, I don't think Martin's external script with
all the filenames hardcoded is the right approach.  There are $(PROG)
and $(SCRIPTS) which already know all these filenames.

thanks,
-chris
