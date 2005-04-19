From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Tue, 19 Apr 2005 13:20:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
X-From: git-owner@vger.kernel.org Tue Apr 19 22:16:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNz7y-00056E-J7
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 22:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVDSUTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 16:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVDSUTO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 16:19:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:28562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbVDSUTI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 16:19:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3JKIps4012850
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 19 Apr 2005 13:18:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3JKInic029302;
	Tue, 19 Apr 2005 13:18:50 -0700
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050419194728.GA24367@kroah.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 19 Apr 2005, Greg KH wrote:
> 
> Ok, if you want some practice with "real" merges, feel free to merge from
> the following two trees whenever you are ready:
> 	kernel.org/pub/scm/linux/kernel/git/gregkh/aoe-2.6.git/
> for 11 aoe bugfix patches, and:
> 	kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
> for 13 driver core, sysfs, and debugfs fixes.

Done, pushed out. Can you verify that the end result looks sane to you? I 
just cheched that the diffstat looks similar (mine claims just 108 lines 
changed in aoecmd.c - possibly due to different diff formats).

And yes, my new merge thing seems to have kept the index-cache much better 
up-to-date, allowing an optimized checkout-cache -f -a to work and only 
get the new files.

Pasky? Can you check my latest git stuff, notably read-tree.c and the 
changes to git-pull-script?

		Linus
