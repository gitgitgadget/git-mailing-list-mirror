From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz 
 origin/frotz"
Date: Mon, 7 Jun 2010 22:11:34 +0200
Message-ID: <20100607221134.002ae81a@jk.gs>
References: <20100605110930.GA10526@localhost>
	<AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com>
	<20100605135811.GA14862@localhost>
	<AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com>
	<20100606161805.GA6239@coredump.intra.peff.net>
	<20100606165554.GB10104@localhost>
	<AANLkTinTI3XaE6P_WZ_k56fgI4LNOLSalv_1GlVZNO7n@mail.gmail.com>
	<20100606173233.GA11041@localhost>
	<AANLkTilvHl-8eA6CbEDs4ty3h0h670L_enGsXunHxaPE@mail.gmail.com>
	<20100607182956.GA17343@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jacob Helwig <jacob.helwig@gmail.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Jun 07 22:11:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLifj-0008Rc-Ik
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 22:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab0FGULm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 16:11:42 -0400
Received: from zoidberg.org ([88.198.6.61]:53413 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678Ab0FGULm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 16:11:42 -0400
Received: from jk.gs (xdsl-78-35-146-157.netcologne.de [::ffff:78.35.146.157])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Mon, 07 Jun 2010 22:11:39 +0200
  id 00404075.4C0D527B.00004A7E
In-Reply-To: <20100607182956.GA17343@localhost>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148623>

Clemens Buchacher <drizzd@aon.at> wrote:

> > Other than "unexpected success", how is the DWIM behavior confusing,
> > given that it says exactly what it's doing when the DWIM behavior is
> > invoked?  I'm still not clear what the confusion you're referring to
> > is on this one.
> 
> I am telling git to checkout a branch. Instead it creates a branch.
> That is what is confusing to me. Until I found the commit that
> introduced it, I was sure it must be a bug.

I usually see the opposite kind of confusion on #git: someone cloned a
repository and wants to work on one of the branches. After all, we tell
everyone that clone copies all the history.

So they type "git checkout <that branch>"... and they get a weird
error (what's a pathspec, anyway?). OMGWTFBBQ! Not knowing what's going
on, they drop by in #git and hear they need to type something much less
straightforward than "git checkout <that branch>". They don't really
know why, so they probably assume it's because git is just so damn
complicated and overengineered.

I have yet to see any newish users complain about the new syntax, by the
way. You don't qualify, sorry. ;)
