From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Diffcore updates.
Date: Sun, 22 May 2005 09:40:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505220939390.2307@ppc970.osdl.org>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
 <7vbr73ha2c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 18:38:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZtSL-00064n-NA
	for gcvg-git@gmane.org; Sun, 22 May 2005 18:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVEVQiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 12:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVEVQiu
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 12:38:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:19864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261828AbVEVQit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 12:38:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4MGcgjA005348
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 09:38:43 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4MGcfT3018175;
	Sun, 22 May 2005 09:38:42 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr73ha2c.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 22 May 2005, Junio C Hamano wrote:
>
> Linus, this truly makes diff-tree with the pickaxe very pleasant to
> use.  Please give it a try.

I can't. You split "diffcore_pathspec()" into a new common library file, 
but you didn't add that to the archive, so your patch doesn't contain it.

Maybe you should make "jit" warn about unadded files ;)

		Linus
