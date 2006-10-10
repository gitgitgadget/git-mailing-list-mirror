From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Does GIT has vc keywords like CVS/Subversion?
Date: Tue, 10 Oct 2006 09:37:57 +0200
Message-ID: <452B4DD5.6060508@lsrfire.ath.cx>
References: <4b3406f0610081825y1d066579yba305b6540c8d0e9@mail.gmail.com>	 <4529B77A.707@gmail.com>	 <Pine.LNX.4.64.0610090904360.3952@g5.osdl.org> <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>,
	Liu Yubao <yubao.liu@gmail.com>,
	Dongsheng Song <dongsheng.song@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 09:38:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXCBz-0001Zk-3W
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 09:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWJJHiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 03:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWJJHiT
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 03:38:19 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:9654
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S965078AbWJJHiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 03:38:19 -0400
Received: from [10.0.1.3] (p508E408B.dip.t-dialin.net [80.142.64.139])
	by neapel230.server4you.de (Postfix) with ESMTP id 8E35F39016;
	Tue, 10 Oct 2006 09:38:17 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90610091408y29f60a12gea7040b5412331c6@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28615>

Martin Langhoff schrieb:
> For the outside of the SCM case, keyword subst is useful indeed if
> someone has a $version_unknown tarball, unpacks it and hacks away. It
> is a pretty broken scenario, and less likely to happen nowadays with
> easy access to SCM tools.

If you still have the tar file, and if it has been created using
git-archive or git-tar-tree it may contain the commit ID in an archive
comment.  You can use git-get-tar-commit-id to extract it in that case.

This won't work with official git project tarballs btw., as commit ID
embedding has been turned off.  The reason is that older tar versions
extracted the comment as a regular file, which confused users.

Ren=E9
