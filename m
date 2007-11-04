From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit RFC] A more structured way of calling git
Date: Sun, 4 Nov 2007 19:34:57 +0100
Message-ID: <20071104183457.GA6032@diana.vm.bytemark.co.uk>
References: <20071026192418.GA19774@diana.vm.bytemark.co.uk> <b0943d9e0711030356j4dcd31cbl54d838107240b3d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 19:35:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IokK0-0003HE-G2
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 19:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbXKDSfa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 13:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753801AbXKDSfa
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 13:35:30 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2479 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788AbXKDSf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 13:35:29 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IokJF-0001nF-00; Sun, 04 Nov 2007 18:34:57 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0711030356j4dcd31cbl54d838107240b3d0@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63426>

On 2007-11-03 10:56:36 +0000, Catalin Marinas wrote:

> On 26/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > I wanted to build an StGit command that coalesced adjacent patches
> > to a single patch. Because the end result tree would still be the
> > same, this should be doable without ever involving HEAD, the
> > index, or the worktree.
>
> Wouldn't HEAD need to be modified since the commit log changes
> slightly, even though the tree is the same. Or am I misunderstanding
> this?

I'm refering to the HEAD tree. The HEAD commit will of course change.

> > StGit's existing infrastructure for manipulating patches didn't
> > lend itself to doing this kind of thing, though: it's not modular
> > enough. So I started to design a replacement low-level interface
> > to git, and things got slightly out of hand ... and I ended up
> > with a much bigger refactoring than I'd planned.
>
> Thanks for this. I'll need a bit of time to read it all and give
> feedback. In general, I welcome this refactoring.
>
> I'll go through the whole e-mail in the next days and get back to
> you.

Thanks, I appreciate it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
