From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-diff-tree for the first commit
Date: Thu, 19 May 2005 13:46:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505191345260.2322@ppc970.osdl.org>
References: <20050519195110.GG8105@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505191323060.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 22:46:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYrrY-00014n-VS
	for gcvg-git@gmane.org; Thu, 19 May 2005 22:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVESUoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 16:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVESUoN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 16:44:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:19620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261249AbVESUoK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 16:44:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4JKi6U3014118
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 May 2005 13:44:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4JKi5wV008103;
	Thu, 19 May 2005 13:44:06 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <Pine.LNX.4.58.0505191323060.2322@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 19 May 2005, Linus Torvalds wrote:
> 
> That said, a new flag that says "diff the root against the NUL tree" 
> wouldn't be wrong either, for when that is what you want.

Done. Use "git-diff-tree --root" if you want to see the root commit as a 
big diff against nothing.

		Linus
