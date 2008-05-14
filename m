From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Emacs mode: automatically cd up to root of worktree
Date: Wed, 14 May 2008 10:13:21 +0200
Message-ID: <20080514081321.GB21708@diana.vm.bytemark.co.uk>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk> <20080514014820.7140.28591.stgit@yoghurt> <87r6c5uyhb.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed May 14 10:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwC8X-0002mt-Ap
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 10:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762057AbYENINf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 May 2008 04:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761969AbYENINe
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 04:13:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4105 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761221AbYENIN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 04:13:29 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JwC6z-0005ru-00; Wed, 14 May 2008 09:13:21 +0100
Content-Disposition: inline
In-Reply-To: <87r6c5uyhb.fsf@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82086>

On 2008-05-14 09:38:24 +0200, David K=E5gedal wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > git's emacs mode automatically finds the root of the worktree, so
> > that the user doesn't have to. Teach StGit's emacs mode the same
> > trick by borrowing the git-get-top-dir function from git.
> >
> > The borrowed code was written by Alexandre Julliard
> > <julliard@winehq.org>.
> >
> > Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
>
> Signed-off-by: David K=E5gedal <davidk@lysator.liu.se>

I guess you mean "Acked-by"?

> Excellent. It's an itch that I've been meaning to scratch for some
> time.

Me too. I've gotten into the habit of running "C-x b *stgit*" to get
to the StGit buffer, just so I don't have to give the right directory
every time.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
