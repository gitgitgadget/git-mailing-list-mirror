From: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
Subject: Re: [ANNOUNCE] Guilt v0.31
Date: Mon, 8 Sep 2008 14:43:22 -0400
Message-ID: <20080908184322.GE27550@josefsipek.net>
References: <20080908135244.GB27550@josefsipek.net> <36ca99e90809081133s58e3d32h8b85804f5bb76902@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	guilt@lists.josefsipek.net, Brandon Philips <brandon@ifup.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:44:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcliw-0005KY-3r
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 20:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbYIHSnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 14:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbYIHSnX
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 14:43:23 -0400
Received: from josefsipek.net ([141.211.133.196]:44235 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbYIHSnW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 14:43:22 -0400
Received: by josefsipek.net (Postfix, from userid 1000)
	id 26B0C1C00D92; Mon,  8 Sep 2008 14:43:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <36ca99e90809081133s58e3d32h8b85804f5bb76902@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95288>

On Mon, Sep 08, 2008 at 08:33:23PM +0200, Bert Wesarg wrote:
> Hi,
> 
> On Mon, Sep 8, 2008 at 15:52, Josef 'Jeff' Sipek <jeffpc@josefsipek.net> wrote:
> > Guilt v0.31 is available for download.
> 
> Is it possible to include pre-generated docs in the tarballs?
> 
> I downloaded one and run 'make doc' and get these messages:
> 
> fatal: Not a git repository
> 
> which looks like it comes from this line in Documentation/Makefile:
> 
> VERSION=$(shell git describe)
> 
> Its not critical, but looks awkward.

1) I already commit generated man pages for each release - on the man branch
   (there's also html branch with the html-formated man pages).

2) I'm aware of the git error you saw, and it is on my todo list

3) I just checked the git tarballs, and they don't include man pages either.
   Should I include the manpages in the source tarball, or should I just
   create another tarball with the manpages? (The git error will get fixed
   regardless - that's the only invocation of git during the manpage build
   process, and it's there only to get a nice looking version number to
   include in the manpages.)

Josef 'Jeff' Sipek.

-- 
Bad pun of the week: The formula 1 control computer suffered from a race
condition
