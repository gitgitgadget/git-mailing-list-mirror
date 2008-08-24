From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] mtn to git conversion script
Date: Sun, 24 Aug 2008 15:46:59 -0700
Message-ID: <20080824224658.GA16590@spearce.org>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com> <20080824131405.GJ23800@genesis.frugalware.org> <94a0d4530808241133n5cc9f17arc79a1a5013187869@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	monotone-devel@nongnu.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 00:48:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXONR-0003jk-TA
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 00:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbYHXWrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 18:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753598AbYHXWrA
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 18:47:00 -0400
Received: from george.spearce.org ([209.20.77.23]:40040 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753424AbYHXWq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 18:46:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 188BB38375; Sun, 24 Aug 2008 22:46:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <94a0d4530808241133n5cc9f17arc79a1a5013187869@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93572>

Felipe Contreras <felipe.contreras@gmail.com> wrote:
> On Sun, Aug 24, 2008 at 4:14 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> > On Sun, Aug 24, 2008 at 12:18:50PM +0300, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> >> What do you think? Does it makes sense to have a 'write-raw' command?
> >> Or should I somehow use 'fast-import'?
> >
> > Yes, you should. ;-)
> >
> > The syntax of it is not so hard, see for example 'git fast-export
> > HEAD~2..' on a git repo and you'll see.
> >
> > This should help a lot if you are like me, who likes to learn from
> > examples.
> 
> Is it possible to create a fast-import from the index? I realize this
> is not the best thing to do, but for now I would like to do that.

No, fast-import uses its own internal structure and avoids the
index file.

Also, look at `git-hash-objects -w` as a replacement for your
git-write-raw tool if you aren't going to use git-fast-import.

-- 
Shawn.
