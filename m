From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: gitweb doesn't work with bare repositories
Date: Sun, 30 Nov 2008 01:01:16 +0100
Message-ID: <20081130000115.GB20403@frsk.net>
References: <4931D23A.10402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Evgeniy Ivanov <lolkaantimat@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 01:02:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Zlk-0002Tq-7V
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 01:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbYK3ABU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 19:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbYK3ABU
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 19:01:20 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:39406 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbYK3ABT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 19:01:19 -0500
Received: from asterix.samfundet.no
	([2001:700:300:1800::f] helo=asterix.frsk.net ident=Debian-exim)
	by cassarossa.samfundet.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1L6ZkT-0001bj-Br; Sun, 30 Nov 2008 01:01:17 +0100
Received: from fredrik by asterix.frsk.net with local (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1L6ZkS-0003HV-Uy; Sun, 30 Nov 2008 01:01:16 +0100
Content-Disposition: inline
In-Reply-To: <4931D23A.10402@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101936>

On Sun, Nov 30, 2008 at 02:37:30AM +0300, Evgeniy Ivanov wrote:
> Hi,

Hi.

Just checking now, but are the following corrections right?

> In projects I have created bare repo:
> mkdir some

mkdir some.git

> cd some.git
> git --bare init
> cd /some_git_repo
> git push /srv/www/gamekeeper/htdocs/projects master

git push /srv/www/gamekeeper/htdocs/projects/some.git master

> Permissions are ok, virtual host is ok since I get main page and have
> access to cloned repo.

You're sure the user the webserver is running as has access to the repo as
well?

- Fredrik

-- 
Kind regards,
Fredrik Skolmli
