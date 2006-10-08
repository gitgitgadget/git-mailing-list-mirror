From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-tar-tree & NEEDS_PREFIX
Date: Sun, 08 Oct 2006 15:44:32 +0200
Message-ID: <452900C0.6090406@lsrfire.ath.cx>
References: <4528F8AD.2040307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 08 15:44:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWYx9-0004GD-7r
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 15:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWJHNoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Oct 2006 09:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWJHNoY
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 09:44:24 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:28300
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751156AbWJHNoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 09:44:23 -0400
Received: from [10.0.1.3] (p508E73F3.dip.t-dialin.net [80.142.115.243])
	by neapel230.server4you.de (Postfix) with ESMTP id 6B5B726000;
	Sun,  8 Oct 2006 15:44:22 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Jiri Slaby <jirislaby@gmail.com>
In-Reply-To: <4528F8AD.2040307@gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28538>

Jiri Slaby schrieb:
> is there any good reason to have NEEDS_PREFIX flag for git-tar-tree
> builtin?
>=20
> I can't do --remote=3D tar-ing, but when I remove this flag from git.=
c, it
> seems to work correctly (prefix seems not to be used in any way).

Good point.  However, git-tar-tree has been deprecated in favour of
git-archive.  And NEEDS_PREFIX has been renamed to RUN_SETUP two months
ago, so an update might be in order. ;-)

Ren=C3=A9
