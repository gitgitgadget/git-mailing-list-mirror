From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 10:38:16 +0100
Message-ID: <20071219093816.GB4361@diana.vm.bytemark.co.uk>
References: <20071214105238.18066.23281.stgit@krank> <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com> <20071217224812.GA6342@diana.vm.bytemark.co.uk> <20071218052115.GA13422@diana.vm.bytemark.co.uk> <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com> <m3hcigot3h.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 10:38:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4vO0-00052q-I4
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 10:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbXLSJiW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 04:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752500AbXLSJiW
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 04:38:22 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4396 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbXLSJiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 04:38:21 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J4vNY-0001Df-00; Wed, 19 Dec 2007 09:38:16 +0000
Content-Disposition: inline
In-Reply-To: <m3hcigot3h.fsf@roke.D-201>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68875>

On 2007-12-18 08:39:52 -0800, Jakub Narebski wrote:

> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>
> > On 18/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > >       Remove "stg resolved"
> >
> > I'd like to keep this command. git-mergetool doesn't support the
> > tool I use (emacs + ediff and more stgit-specific file extensions
> > like current, patch etc.). I also don't find 'git add' to be
> > meaningful for marking a conflict as solved.
>
> I also would like to have this command kept (and shown in 'stg
> help'!). Contrary to 'git add' it can check and add to index /
> update index only for files with conflict; we have -r
> (ancestor|current|patched) to choose one side, and we could add
> --check to check if there are no conflict markers with files (useful
> with -a/--all).

This too sounds like stuff that could profitably be added to "git
add". Except for the ancestor/current/patched words, it is not
specific to patch stacks, so the implementation should be in git and
not in stg.

IMHO, of course. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
