From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 12:25:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 21:23:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbNvg-0001cE-AH
	for gcvg-git@gmane.org; Thu, 26 May 2005 21:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVEZTXZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 15:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVEZTXZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 15:23:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:52398 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261702AbVEZTXT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2005 15:23:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4QJNBjA026533
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 26 May 2005 12:23:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4QJNAUt007771;
	Thu, 26 May 2005 12:23:10 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 26 May 2005, Linus Torvalds wrote:
> 
> So we'd change it from
> 
> 	deleted file mode 100644
> 
> to
> 
> 	deleted file mode 100644 arch/um/kernel/checksum.c
> 
> in this case..

I just realized that this same thing is equally true of just plain mode 
changes, where wif we don't have any content we just get

	diff --git a/name b/name
	old mode xxxx
	new mode yyyy

so I might as well parse the diff header here (I don't want to repeat the 
name twice for mode changes). Oh well.

		Linus
