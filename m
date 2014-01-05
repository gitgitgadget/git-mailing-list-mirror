From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 2/2] Introduce git submodule attached update
Date: Sun, 5 Jan 2014 21:33:49 +0100
Message-ID: <20140105203349.GB3737@book.hvoigt.net>
References: <1388890249-3577-1-git-send-email-ceztko@gmail.com> <1388890249-3577-2-git-send-email-ceztko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Francesco Pretto <ceztko@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 05 21:33:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzuOT-0001dD-IQ
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 21:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbaAEUdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 15:33:54 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:40045 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbaAEUdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 15:33:53 -0500
Received: from [77.20.146.74] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VzuOM-0000UI-Ue; Sun, 05 Jan 2014 21:33:51 +0100
Content-Disposition: inline
In-Reply-To: <1388890249-3577-2-git-send-email-ceztko@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239971>

On Sun, Jan 05, 2014 at 03:50:49AM +0100, Francesco Pretto wrote:
> At the current state, the following use-case is not supported very
> well in git:
> - a maintainer adds a submodule, checking out a specific branch of
> the repository. He doesn't track the upstream submodule revision sha1;
> - a developer checkout the repository branch decided by the maintainer.
> Subsequent "merge" or "rebase" update operations don't detach the HEAD.

Could you please extend the description of your use-case so we can
understand your goal better?

The following questions directly pop into my mind:

 - What means the maintainer does not track the submodules sha1? Does
   that mean the superproject always refers to submodule commits using
   branches?
 - What happens if you want to go back to an earlier revision? Lets say
   a tagged release? How is ensured that you get the correct revision in
   the submodules?
 - In which situations does the developer or maintainer switch between
   your attached/detached mode?
 - What is the "repository branch" which is given to the developer by
   the maintainer used for? Who creates this branch and who merges into
   it?
 - What are these subsequent "merge" or "rebase" update operations? Do
   you mean everyone has submodule.name.update configured to merge or
   rebase?

Still puzzled.

Cheers Heiko
