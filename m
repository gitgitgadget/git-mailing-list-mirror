From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-grep: convert from bash to sh
Date: Sun, 18 Dec 2005 11:57:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512181155360.4827@g5.osdl.org>
References: <20051218152639.5c14bc26.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 20:58:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo4f3-0004B8-Td
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 20:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbVLRT5f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 14:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965262AbVLRT5f
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 14:57:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965261AbVLRT5e (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 14:57:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBIJvRDZ009513
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Dec 2005 11:57:28 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBIJvQNS023800;
	Sun, 18 Dec 2005 11:57:27 -0800
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20051218152639.5c14bc26.tihirvon@gmail.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13800>



On Sun, 18 Dec 2005, Timo Hirvonen wrote:
> 
> sh does not support arrays so we have to use eval instead.

This seems horribly broken.

If I'm not mistaken, this breaks

	git grep "it's a happy coincidence"

badly. I didn't test, just looking at the patch.

Dammit, I'd rather depend on "bash"/"ksh" than have a broken "git grep".

Tell people to get a real shell.

		Linus
