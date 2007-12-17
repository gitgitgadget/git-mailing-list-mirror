From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 00/17] Series short description
Date: Mon, 17 Dec 2007 23:48:12 +0100
Message-ID: <20071217224812.GA6342@diana.vm.bytemark.co.uk>
References: <20071214105238.18066.23281.stgit@krank> <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OmP-0007mT-8M
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765131AbXLQWsZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 17:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765064AbXLQWsY
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:48:24 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2598 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760433AbXLQWsX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:48:23 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J4Oku-0001oK-00; Mon, 17 Dec 2007 22:48:12 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68644>

On 2007-12-17 11:09:06 +0000, Catalin Marinas wrote:

> On 14/12/2007, David K=E5gedal <davidk@lysator.liu.se> wrote:
>
> > The following series an emacs interface to stgit patch stacks. It
> > shows a buffer with the the output of "stg series" and allows you
> > to do some common operations on it, such as push/pop,
> > commit/uncommit, edit, rename, repair, and coalesce.
>
> That's really cool stuff! Thanks.

Yes, incredibly useful.

I've put this series in kha/safe -- except for the mark and coalesce
patches, which are at the tip of kha/experimental. The latter because
it obviously has to be, the former because the latter is the only
thing using it and it's _extremely annoying_ to be able to mark
patches but not, say, push or pop all marked patches.

My stack is now 53 patches deep, so running the test suite on every
patch is getting time consuming -- I'd guess about two hours on my
poor laptop. And I plan to sleep while that runs, so I won't actually
push this until tomorrow.

> > The coalesce command obviosly requires the kha/experimental
> > branch. The edit command requires the edit fixes in kha/safe.
>
> I'll start this week merging patches from kha/experimental (I'm a
> bit slow because of the Christmas activities).

Be careful about merging past the "goto" patch -- I'm pretty sure it
breaks when called from a subdirectory, and I don't have time to fix
that right now. (It should be a clean fix, though -- just adjust the
cwd for precisely those git subprocesses that need it, which is very
few. I think.)

If you like, I can advance "safe" to include as many patches as I
think you should merge right now.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
