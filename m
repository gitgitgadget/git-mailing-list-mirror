From: Linus Torvalds <torvalds@osdl.org>
Subject: Comments on recursive merge..
Date: Mon, 7 Nov 2005 08:48:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 17:51:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZAAO-0004NY-30
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 17:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVKGQsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 11:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVKGQsR
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 11:48:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7334 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932202AbVKGQsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 11:48:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA7Gm7nO002716
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 7 Nov 2005 08:48:08 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA7Gm6Wo009135;
	Mon, 7 Nov 2005 08:48:06 -0800
To: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11269>


Guys,

  I just hit my first real rename conflict, and very timidly tried the 
"recursive" strategy in the hopes that I wouldn't need to do things by 
hand.

It resolved things beautifully. Good job. 

My only worry is that I don't read python, so I don't really know how it 
does what it does, which makes me nervous. Can somebody (Fredrik?) add 
some documentation about the merge strategy and how it works.

Considering that the stupid resolve strategy really requires you to know 
how git works when rename conflicts happen (things left in unmerged state 
are really quite hard to handle by hand unless you know exactly what 
you're doing), I'd almost suggest making "recursive" the default. I'm a 
bit nervous about it, but knowing how it works would probably put most of 
that to rest.

		Linus
