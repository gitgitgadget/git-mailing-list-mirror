From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: "sha1 information is lacking or useless" when rebasing with a
	submodule pointer conflict
Date: Wed, 30 Jan 2013 22:56:15 +0100
Message-ID: <20130130215615.GA1053@book.hvoigt.net>
References: <CAFyOhY8YAO4zx6jKQxrEW=-Vbo-TTjU6wJ7UgNVEjA7B2dasng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Michael Sims <michael.h.sims@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 23:03:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0fkh-0001YS-EY
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 23:03:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab3A3WDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 17:03:08 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:48211 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927Ab3A3WDH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 17:03:07 -0500
Received: from [77.21.76.82] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1U0fdg-0000Rd-IW; Wed, 30 Jan 2013 22:56:16 +0100
Content-Disposition: inline
In-Reply-To: <CAFyOhY8YAO4zx6jKQxrEW=-Vbo-TTjU6wJ7UgNVEjA7B2dasng@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215075>

Hi,

On Wed, Jan 30, 2013 at 12:43:31PM -0600, Michael Sims wrote:
> I'm seeing what might be a bug that was introduced in git 1.7.12 (also
> observed in 1.8.1.2).  If not a bug, it's a changed behavior from
> previous versions that I don't understand.
> 
> Here's the scenario:
> * I have a remote repo containing a pointer to a submodule.
> * Developer A and Developer B clone this repo, and both make a commit
> to first the submodule, and then the parent repo, changing some files
> and also the submodule pointer at the same time.
> * Developer A pushes his changes to both the submodule and the parent
> module to the shared remote
> * Developer B either does a "git pull --rebase" or a "git fetch && git
> rebase origin/master"

Thanks for the detailed bug report and the demo script. I can reproduce
the behavior here and will have a look into it. The submodule should be
marked as conflict.

Cheers Heiko
