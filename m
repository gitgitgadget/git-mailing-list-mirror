From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Git Server Repository Security?
Date: Mon, 18 May 2015 12:26:33 +0200
Message-ID: <20150518102633.GA15186@book.hvoigt.net>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John McIntyre <joh98.mac@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 12:27:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuIGO-0001hn-VX
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 12:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbbERK1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 06:27:09 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:33509 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbbERK1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 06:27:07 -0400
Received: from [195.71.20.144] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YuIFq-0000xg-S6; Mon, 18 May 2015 12:26:39 +0200
Content-Disposition: inline
In-Reply-To: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269226>

Hi,

On Mon, May 18, 2015 at 11:07:02AM +0100, John McIntyre wrote:
> Hi,
> I've been asked to set up a git repository for a few projects.  So I
> have a Linux CentOS server running git.   I place the repositories
> under /opt and I use the .ssh/authorized_keys of the git user, to
> grant access. The user sends me his private key, and I paste it into
> the end of the file.
> 
> And now, I realise that there's a problem.  If I have /opt/repo1.git
> and /opt/repo2.git, then all users can access both repositories.
> 
> Is there a way to prevent this?

If you want a simple tool using ssh-keys have a look at gitolite[1].
It quite simple to setup and with it you can specify all kinds of access
rights.

Cheers Heiko

[1] http://gitolite.com/gitolite/index.html
