From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-daemon --inetd
Date: Sat, 22 Oct 2005 14:05:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510221404230.10477@g5.osdl.org>
References: <43290EFF.3070604@zytor.com>  <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org>
  <4329BDD9.4010507@zytor.com>  <Pine.LNX.4.58.0509151142570.26803@g5.osdl.org>
  <4329C93D.2020701@zytor.com>  <Pine.LNX.4.58.0509151225410.26803@g5.osdl.org>
  <46a038f905091514447e13404d@mail.gmail.com>
 <2cfc40320510220645r6e8dc735w32b6ec3633b1d1ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: martin.langhoff@gmail.com, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 23:07:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETQZM-0002Pi-A8
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 23:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVJVVGF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 17:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVJVVGF
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 17:06:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54166 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751128AbVJVVGE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2005 17:06:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9ML5dFC029195
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 22 Oct 2005 14:05:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9ML5ceT027949;
	Sat, 22 Oct 2005 14:05:38 -0700
To: Jon Seymour <jon.seymour@gmail.com>
In-Reply-To: <2cfc40320510220645r6e8dc735w32b6ec3633b1d1ff@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10475>



On Sat, 22 Oct 2005, Jon Seymour wrote:
> 
> Is the concern with --merge-order the complexity of the logic (and
> hence size of object), the intrusiveness into rev-list.c or the fact
> that it uses the OPEN_SSL?

Some of all. But mostly just the basic fact being that right now, nobody 
can really use --merge-order anyway, because if somebody compiles without 
OPEN_SSL, it just won't be there. So it's _practically_ useless.

		Linus
