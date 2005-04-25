From: Andrew Morton <akpm@osdl.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.2 && heads-up on upcoming changes
Date: Mon, 25 Apr 2005 04:27:22 -0700
Message-ID: <20050425042722.5e06e5e8.akpm@osdl.org>
References: <20050420205633.GC19112@pasky.ji.cz>
	<20050420211919.GA20129@kroah.com>
	<20050420215117.GJ19112@pasky.ji.cz>
	<Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, greg@kroah.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 13:23:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ1g6-0003J8-CZ
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 13:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVDYL2B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 07:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVDYL2B
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 07:28:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:19903 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261554AbVDYL16 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 07:27:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3PBRgs4015078
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 04:27:42 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j3PBRfab010201;
	Mon, 25 Apr 2005 04:27:41 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201503050.6467@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> Yeah, yeah, it looks different from "cvs update", but dammit, wouldn't it 
>  be cool to just write "cg-<tab><tab>" and see the command choices? Or 
>  "cg-up<tab>" and get cg-update done for you..

zsh can do this for (for example) cvs.  Type "cvs <tab><tab><tab>" and 
you get "cvs annotate".

Type "cvs commit foo/bar/<tab>" and zsh will start cycling through the 
files which need committing in ./foo/bar/.  Yes, the shell knows about
and pokes around inside cvs files.

I just brought this up because I know how much you'd love the whole
concept ;)
