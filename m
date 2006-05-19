From: Sven Ekman <svekman@yahoo.se>
Subject: Re: [PATCH] built-in tar-tree and remote tar-tree
Date: Fri, 19 May 2006 23:43:18 +0200 (CEST)
Message-ID: <20060519214318.38240.qmail@web25910.mail.ukl.yahoo.com>
References: <7v7j4ik1fr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 23:43:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhCko-0005Y3-K9
	for gcvg-git@gmane.org; Fri, 19 May 2006 23:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWESVnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 17:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWESVnU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 17:43:20 -0400
Received: from web25910.mail.ukl.yahoo.com ([217.12.10.208]:51082 "HELO
	web25910.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964857AbWESVnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 17:43:19 -0400
Received: (qmail 38242 invoked by uid 60001); 19 May 2006 21:43:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.se;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=T4Scw+0J5elzjO4VRyK4bzjU4dbT2BET8H05iE6Vo2x8mrwirpOrCcQ30HU9vDFsZgih6ZvIpUJlKUVP3lGx5NRGyBr0TAMJJeAxpFDkCsqkFnhY43wGuDYeFaJDdHcNZbY2/1pvxgWN276eTmtcbS8lpmldHDI7XMcyZCzbcs0=  ;
Received: from [140.78.95.135] by web25910.mail.ukl.yahoo.com via HTTP; Fri, 19 May 2006 23:43:18 CEST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j4ik1fr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20357>

Junio C Hamano <junkio@cox.net> skrev:

> Sorry for sending a crapoid that does not even
> compile.  I ran format-patch while on a wrong 
> branch.
> 
> Tonight's "pu" will have a fixed up one for 
> people who are interested to play with.

Hi Junio,

Thanks for your answer. I'm looking forward to try the
remote tar-tree at the weekend.  While this will
definitely make it much more easy to grab single
revisions out of a git tree, it only solves a part of
the issue I was trying to address. If one wanted a
simple snapshot of the source, it's usually easier to
download a tarball. 

The great thing about having the kernel source in a
git repository is that it lets me upgrade the kernel
source tree in place with a single simple command. No
firing up a browser, downloading and applying a patch.
It is also braindead easy to maintain a set of local
patches across different kernel versions. Git makes
all this quick and easy.

Is there a simple way to retrieve a single object or a
list of objects _without_ any of their parents? If so
one could retrieve the wanted commit and the
corresponding tree and parse it on the client side to
retrieve its descendents and commits.  If so, the
number of roundtrips would be roughly proportional to
the depth of the trees, which would probably still be
acceptable.

Greetings, Sven
