From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: GIT character codecs
Date: Sun, 13 Nov 2005 09:51:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511130948020.3263@g5.osdl.org>
References: <20051113081443.38296.qmail@web26309.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 18:54:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbM1Q-0004jL-8D
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 18:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbVKMRwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 12:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVKMRwE
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 12:52:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751361AbVKMRwC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 12:52:02 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jADHpvnO002079
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 13 Nov 2005 09:51:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jADHpucD011247;
	Sun, 13 Nov 2005 09:51:56 -0800
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051113081443.38296.qmail@web26309.mail.ukl.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11744>



On Sun, 13 Nov 2005, Marco Costalba wrote:
> 
> If encoding is a per-blob _and_ per-log message property a real solution, although cumbersone,
> could be that git stores encoding togheter with the blob and the commits.

We'd be much better off with just saying "we encourage people to use 
utf-8, but if you don't, just set your locale to make things show up 
properly".

utf-8 is clearly the future, and if we make git internally aware of 
locales, that's just going to complicate things. And usually for no good 
reason, since users don't really care that much.

I really hate codepages. I'd much rather say:
 - git is 8-bit clean, so you can use any damn encoding you want
 - utf-8 is strongly recommended for all the same reasons it's recommended 
   for anything else.

Hmm?

		Linus
