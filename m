From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix interesting git-rev-list corner case
Date: Sat, 30 Jul 2005 21:44:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507302142380.29650@g5.osdl.org>
References: <Pine.LNX.4.58.0507291542060.29650@g5.osdl.org> <m31x5gob8k.fsf@telia.com>
 <Pine.LNX.4.58.0507300913000.29650@g5.osdl.org> <m3fytwm313.fsf@telia.com>
 <Pine.LNX.4.58.0507301354000.29650@g5.osdl.org> <Pine.LNX.4.58.0507302259140.26128@telia.com>
 <Pine.LNX.4.58.0507301428300.29650@g5.osdl.org> <Pine.LNX.4.58.0507301507390.29650@g5.osdl.org>
 <m3ack3nb3c.fsf@telia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 06:44:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz5gd-000366-Ur
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 06:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVGaEoY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 00:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVGaEoX
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 00:44:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261613AbVGaEoW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 00:44:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6V4iFjA004687
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Jul 2005 21:44:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6V4iFRa030529;
	Sat, 30 Jul 2005 21:44:15 -0700
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m3ack3nb3c.fsf@telia.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 31 Jul 2005, Peter Osterlund wrote:
>
> > I bet there is a smarter way to do this, but this _should_ fix the problem
> > Peter sees. Peter?
> 
> Yes, it does fix the problem. Thanks.

Ok, Junio, can you apply the git-merge-base patch? It's not perfect, but
it's clearly better than what's there right now.

Add a "Signed-off-by: Linus Torvalds <torvalds@osdl.org>" and edit the 
description a bit, perhaps.

		Linus
