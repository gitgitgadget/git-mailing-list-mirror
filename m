From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: as promised, docs: git for the confused
Date: Mon, 12 Dec 2005 21:29:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512122124290.15597@g5.osdl.org>
References: <20051209215414.14072.qmail@science.horizon.com>
 <7vmzj9zwfu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0512120827440.15597@g5.osdl.org>
 <20051212195319.11d41269.tihirvon@gmail.com> <Pine.LNX.4.64.0512121010550.15597@g5.osdl.org>
 <86y82qyrqs.fsf@blue.stonehenge.com> <20051213035842.GF10371@always.joy.eth.net>
 <86d5k1y7dp.fsf@blue.stonehenge.com> <7vzmn5bmlk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 06:31:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Em2jq-0001vu-Mt
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 06:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVLMFaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 00:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVLMFaA
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 00:30:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750801AbVLMF37 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 00:29:59 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBD5TmDZ022652
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Dec 2005 21:29:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBD5Tl30004433;
	Mon, 12 Dec 2005 21:29:47 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmn5bmlk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.128 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13570>



On Mon, 12 Dec 2005, Junio C Hamano wrote:
> 
> The only Plumbing support is that ls-files takes --exclude-from=
> and --exclude-per-directory= options.  It is up to the Porcelain
> layer what names to use.

The only _core_ plumbing support is the git-ls-files option, but some of 
the git helper functions do use it. Notably, "git add" and "git status" 
both use those options, which in turn then indirectly means that when 
using "git commit" the commit message template won't list ignored files 
etc.

So the git "mini-porcelain" layer does in fact use .gitignore and friends. 

		Linus
