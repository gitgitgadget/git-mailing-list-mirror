From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH Cogito] Fix cg-log -f behavior
Date: Thu, 26 May 2005 23:25:40 +0200
Message-ID: <1117142741.12036.66.camel@pegasus>
References: <1117137826.12036.57.camel@pegasus>
	 <7vk6llbv1j.fsf@assigned-by-dhcp.cox.net>
	 <1117139740.12036.59.camel@pegasus>
	 <7voeaxae0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 23:27:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbPs8-0001il-Jn
	for gcvg-git@gmane.org; Thu, 26 May 2005 23:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVEZV1q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVEZV1q
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 17:27:46 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:3513 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261806AbVEZV1Q
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 17:27:16 -0400
Received: from pegasus (p5487D46C.dip.t-dialin.net [84.135.212.108])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4QLReId020157
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 26 May 2005 23:28:26 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voeaxae0r.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> MH> I am not sure, because I never tried it. Does it use a different format?
> 
> I am not a Cogito user, but I am a bit wondering if you have
> read what is around what you are modifying.
> 
> 	# List all files for for the initial commit
> 	if [ -z $tree2 ]; then
> 		list_cmd="git-ls-tree $tree1"
> 	else
> 		list_cmd="git-diff-tree -r $tree1 $tree2"
> 	fi
> 	echo
> 	$list_cmd | while read modes type sha1s file; do
> 
> The code you changed is fed by either git-ls-tree or
> git-diff-tree, depending on whether you are talking about
> initial commit.  git-ls-tree gives "mode type sha1 file".

I assumed that both have the same output format.

> This is why I asked Linus about a slight format change for
> git-ls-tree (and git-ls-files) this morning.

To what is it changing?

Regards

Marcel


