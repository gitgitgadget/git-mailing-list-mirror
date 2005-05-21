From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] show changed tree objects with recursive git-diff-tree
Date: Fri, 20 May 2005 20:20:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505202019330.2206@ppc970.osdl.org>
References: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 05:18:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZKUy-0003sj-Ck
	for gcvg-git@gmane.org; Sat, 21 May 2005 05:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVEUDSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 23:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVEUDSz
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 23:18:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:32394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261646AbVEUDSy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 23:18:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4L3IijA017308
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 May 2005 20:18:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4L3IhaD015925;
	Fri, 20 May 2005 20:18:44 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505202131520.4397@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 20 May 2005, Nicolas Pitre wrote:
>
> When -p is not used, git-diff-tree currently shows changed tree objects
> but only when not recursive.  This patch makes the recursive output
> show tree objects as well.

That sounds wrong. That would seem to make diff-helper confused, no? 

		Linus
