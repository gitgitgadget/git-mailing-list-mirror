From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Git Server Repository Security?
Date: Mon, 18 May 2015 14:39:49 +0200
Message-ID: <20150518123948.GA17075@book.hvoigt.net>
References: <CABQ4iYiWu17H1XhPYebmP27x=R11SKW0P91AW2y9S=r-2c0B1A@mail.gmail.com>
 <20150518102633.GA15186@book.hvoigt.net>
 <CABQ4iYgjtdw46Psow_e7uGLqx0ZiFt+TQOgXvCmP1-W10LGEmg@mail.gmail.com>
 <20150518115749.GA16841@book.hvoigt.net>
 <CABQ4iYjwa-KmZAQV=p5efQYBZu3ymQRNwTC4TGXdpo4groArCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John McIntyre <joh98.mac@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 14:40:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuKKy-0008Ln-Pz
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 14:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbbERMj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 08:39:58 -0400
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:49266 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbbERMj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 08:39:56 -0400
X-Greylist: delayed 7995 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 May 2015 08:39:56 EDT
Received: from [195.71.20.144] (helo=book.hvoigt.net)
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YuKKI-00085L-0M; Mon, 18 May 2015 14:39:22 +0200
Content-Disposition: inline
In-Reply-To: <CABQ4iYjwa-KmZAQV=p5efQYBZu3ymQRNwTC4TGXdpo4groArCA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269232>

On Mon, May 18, 2015 at 01:32:07PM +0100, John McIntyre wrote:
> All right, so I'm a bit confused.  I followed the instructions to get
> gitolite, and put a public key, placing it on the server.  I then
> run..
> 
> ***
> gitolite setup -pk server-git01_rsa.pub
> Initialized empty Git repository in /home/git/repositories/gitolite-admin.git/
> Initialized empty Git repository in /home/git/repositories/testing.git/
> ***
> 
> Our repositories are under /opt/git/n where n is the name of the repo.
> 
> Is there a config file where this is defined?

I do not know, because I always used /home/git. In case not: How about
just using a symlink? And there is a lot of information on google ;-)

Cheers Heiko
