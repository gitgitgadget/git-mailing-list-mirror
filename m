From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Wed, 10 Aug 2005 21:17:39 -0600
Message-ID: <E1E33Zb-0004dT-Bx@highlab.com>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net> <7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net> <7vacjsdcbj.fsf@assigned-by-dhcp.cox.net> <7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net> <pan.2005.08.10.21.15.41.143251@smurf.noris.de> <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de>
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 05:17:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E33Xm-0005Dg-OH
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 05:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVHKDPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 23:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVHKDPi
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 23:15:38 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:10388 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932241AbVHKDPh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 23:15:37 -0400
Received: from highlab.com ([67.165.222.77])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005081103153701300ojm56e>; Thu, 11 Aug 2005 03:15:37 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1E33Zb-0004dT-Bx; Wed, 10 Aug 2005 21:17:39 -0600
To: Matthias Urlichs <smurf@smurf.noris.de>
In-reply-to: <20050810233953.GV28270@kiste.smurf.noris.de> 
Comments: In-reply-to Matthias Urlichs <smurf@smurf.noris.de>
   message dated "Thu, 11 Aug 2005 01:39:53 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs <smurf@smurf.noris.de> wrote:
> Cogito 0.12.1 (which includes git) has been packaged by Sebastian
> Kuzminsky <seb@highlab.com>; it's in Debian Unstable. I assume
> he'll do something about packaging the current version; I just filed a
> wishlist bug in Debian.
> 
> The current "cogito" package in Debian renames both the git and cg
> command line programs because there are already packages with conflicting
> commands in Debian ("git" and "cgvg"). I consider that to be a mistake,
> to be honest.

I agree completely - it's super bogus to rename the two central programs.
It makes Debian essentially incompatible with the rest of the world.

My cogito Debian package initially conflicted with the original git
(GNU Interactive Tools), so that both could install /usr/bin/git, but
I got flamed pretty good for this on the debian-devel list, and as a
junior maintainer I followed the recommendations of the more experienced
maintainers - renaming "our" git executable was their choice.

I even suggested using update-alternatives, but that was nixed too.


I predict the current "native" debian package of git will be critizised
for the same reason: because it conflicts with GNU Interactive
Tools.  Before uploading it to the Debian archive I (or someone)
will have to either mangle it like cogito.deb (renaming /usr/bin/git
to /usr/bin/something-else), or convince the Debian people to change
their minds.  If it's the former, I assume everyone who cares will just
compile their own version of git and install that.


-- 
Sebastian Kuzminsky
