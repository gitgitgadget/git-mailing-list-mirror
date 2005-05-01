From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 30 Apr 2005 22:27:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504302224510.2296@ppc970.osdl.org>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org> <7vis231y7y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 07:20:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS6sL-0002PW-1F
	for gcvg-git@gmane.org; Sun, 01 May 2005 07:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVEAF0D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 01:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVEAF0D
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 01:26:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:39896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261532AbVEAFZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 01:25:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j415Pps4011313
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Apr 2005 22:25:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j415PotY001465;
	Sat, 30 Apr 2005 22:25:51 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis231y7y.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Apr 2005, Junio C Hamano wrote:
>  Its output would look something like this:
> 
>     patch -p1 <<\EOF
>     --- /dev/null
>     +++ fs/ext9/Makefile
>     @@ ....
>     EOF
>     chmod -x 'fs/ext9/Makefile'
>     git-update-cache --add --remove -- 'fs/ext9/Makefile'
> 
> Maybe I can make the default diff output just like the above?
> As you say, normal patch would not look at those shell script
> part at all anyway.

I actually do end up looking at diffs, and I'd hate it. I'd much rather
have as little extra fluff as possible, and putting shell scipt fragments
in it definitely counts as distraction.

The fewer lines there are that don't usually tell a human anything, the 
better. Dense is good. 

		Linus
