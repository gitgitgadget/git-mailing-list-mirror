From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] Add USER environment variable to executed git
	commands when serving
Date: Wed, 3 Jun 2009 22:27:02 +0200
Message-ID: <20090603202701.GA8739@macbook.lan>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com> <20090602135659.GA4320@macbook.lan> <2e24e5b90906021804tf3db263qc41a6f8b171111e1@mail.gmail.com> <2e24e5b90906022324pe6769d5vfa5e3eec44daeaf3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tv@eagain.net
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBx3Q-0008RZ-5x
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 22:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884AbZFCU1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 16:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752458AbZFCU1F
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 16:27:05 -0400
Received: from darksea.de ([83.133.111.250]:43770 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751153AbZFCU1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 16:27:04 -0400
Received: (qmail 13341 invoked from network); 3 Jun 2009 22:26:49 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 3 Jun 2009 22:26:49 +0200
Content-Disposition: inline
In-Reply-To: <2e24e5b90906022324pe6769d5vfa5e3eec44daeaf3@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120639>

On Wed, Jun 03, 2009 at 11:54:50AM +0530, Sitaram Chamarty wrote:
> On Wed, Jun 3, 2009 at 6:34 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> 
> > I will test it out today at work and report back but it should work; I
> > don't see why it wouldn't, unless somewhere else there's a
> > sanitisation of env vars going on for security.
> 
> works beautifully!  Thanks again.

You are welcome. An interesting addition would be to propagate allowed
branchnames from gitosis.conf. That way you can implement write-
protected branches using an update hook.

Which enables better support for a maintainer based workflow for
centralized setups. Every developer would be allowed to push all branch
names he likes but the master branch is only writable by the maintainer.

A nice solution to steer this directly from gitosis.conf? I never got
around implementing it.

cheers Heiko
