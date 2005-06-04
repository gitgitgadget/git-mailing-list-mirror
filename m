From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-shortlog script
Date: Sat, 4 Jun 2005 16:45:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
References: <42A22C20.10002@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 01:40:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeiFS-0006uu-AF
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 01:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVFDXnT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 19:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVFDXnS
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 19:43:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:39589 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261434AbVFDXnN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 19:43:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j54Nh6jA018429
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Jun 2005 16:43:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j54Nh5hh010120;
	Sat, 4 Jun 2005 16:43:05 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42A22C20.10002@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 4 Jun 2005, Jeff Garzik wrote:
> 
> Attached is the 'git-shortlog' script I whipped up, to mimic the 
> shortlog script that was used back in the BitKeeper days.

Thanks, I'll add this to the git stuff, and next kernel release will have 
a proper shortlog.

Btw, it shows how broken your merge script is: you don't fill in the 
AUTHOR field properly for some reason:

 <jgarzik@pretzel.yyz.us>:
  Automatic merge of /spare/repo/netdev-2.6 branch r8169-fix
  Automatic merge of /spare/repo/linux-2.6/.git branch HEAD
  Automatic merge of /spare/repo/netdev-2.6 branch use-after-unmap
  Automatic merge of rsync://rsync.kernel.org/.../torvalds/linux-2.6.git branch HEAD

but "committer" is right. Pls fix.

		Linus
