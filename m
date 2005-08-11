From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 14:51:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508111450110.3295@g5.osdl.org>
References: <pan.2005.08.10.21.15.41.143251@smurf.noris.de>
 <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com>
 <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com>
 <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org>
 <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org>
 <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Kuzminsky <seb@highlab.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 23:52:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3Kxn-0006kN-Tx
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 23:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVHKVvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 17:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVHKVvp
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 17:51:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60636 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932244AbVHKVvo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 17:51:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7BLp5jA009317
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Aug 2005 14:51:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7BLp3Ed014101;
	Thu, 11 Aug 2005 14:51:04 -0700
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050811201558.GA2874@mars.ravnborg.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.43__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 11 Aug 2005, Sam Ravnborg wrote:
> 
> The easy fix is to kill the small git script that is not
> mandatory anyway (as far as my quick grep told me).

It's not "mandatory", but the tutorial etc use it as an example.

In other words, if you remove the git script, you are going to have a 
_bad_ package.

I'd suggest that people who don't like the naming just don't install "git" 
at all. Live with it.

		Linus
