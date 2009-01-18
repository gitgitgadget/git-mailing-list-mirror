From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: easy way to make tracking branches?
Date: Sun, 18 Jan 2009 16:53:38 +0100
Message-ID: <20090118155338.GK11992@leksak.fem-net>
References: <20090118105530.GG11992@leksak.fem-net> <slrngn6j4t.9he.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:55:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZzW-0003CG-Ei
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933651AbZARPxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933633AbZARPxu
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:53:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:58742 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932147AbZARPxt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:53:49 -0500
Received: (qmail invoked by alias); 18 Jan 2009 15:53:47 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp009) with SMTP; 18 Jan 2009 16:53:47 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+RRFJyJi6RGLtG+FzTYVsllj0lakjkjqCukJtKiB
	M7wC4qt/Ik/8ST
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LOZxy-00037P-8w; Sun, 18 Jan 2009 16:53:38 +0100
Content-Disposition: inline
In-Reply-To: <slrngn6j4t.9he.sitaramc@sitaramc.homelinux.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106231>

Hi,

Sitaram Chamarty wrote:
> > Now I want to make "foo" a tracking branch for "bar".
> > I do:
> >
> > 	git config branch.foo.remote srv
> > 	git config branch.foo.merge refs/heads/bar
> 
> I just do a "git pull srv" when the tracking is *not* setup,
> and git reminds me what commands to use.

Oh, this is great! (Just tested.)

Usually (in my use case) there is no need to pull before I set up
a tracking branch, so I never tried this.

And git only reminds you if you have no tracking branch set for
srv yet. But that's no problem, because if one is set I can
copy&paste the lines in .git/config.

Altogether, this is a solution I can live with.

> > And to get a comfortable git-push, I do:
> >
> > 	git config --add remote.srv.push foo:bar
> 
> This one you'll just have to remember, I guess :-)

This is not too hard. :-)

> > 	git checkout -b foo2 srv/bar
> > 	git branch -d foo
> > 	git branch -m foo
> >
> > which is suboptimal because deleting foo can remove some
> > other settings for the branch, e.g. mergeoptions.
> 
> it also doesn't seem to set remote.srv.push, as far as I can
> tell.

Right.


Thanks,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
