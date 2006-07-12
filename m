From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-read-tree: fatal: Entry 'Kbuild' not uptodate. Cannot merge.
Date: Wed, 12 Jul 2006 15:39:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607121538300.5623@g5.osdl.org>
References: <44B57932.4090708@gentoo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 00:39:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0nMk-0006eO-LJ
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 00:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWGLWjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 18:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWGLWjb
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 18:39:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932323AbWGLWjb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 18:39:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6CMdTnW018783
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Jul 2006 15:39:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6CMdSIT030820;
	Wed, 12 Jul 2006 15:39:28 -0700
To: Daniel Drake <dsd@gentoo.org>
In-Reply-To: <44B57932.4090708@gentoo.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23801>



On Wed, 12 Jul 2006, Daniel Drake wrote:
>
> git-read-tree: fatal: Entry 'Kbuild' not uptodate. Cannot merge.
> 
> $ git diff
> diff --git a/Kbuild b/Kbuild
> diff --git a/zd_chip.c b/zd_chip.c
> diff --git a/zd_chip.h b/zd_chip.h
> ...

Do "git update-index --refresh", does it go away?

Although "git checkout -f" should also have done it (much more 
expensively)

		Linus
