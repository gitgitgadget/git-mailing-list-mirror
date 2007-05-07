From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 7 May 2007 08:35:05 +0200
Message-ID: <20070507063505.GA31269@diana.vm.bytemark.co.uk>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon May 07 08:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkwp6-000277-SP
	for gcvg-git@gmane.org; Mon, 07 May 2007 08:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbXEGGf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 7 May 2007 02:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbXEGGf1
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 02:35:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3744 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbXEGGf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 02:35:26 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HkwoL-00088z-00; Mon, 07 May 2007 07:35:05 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46417>

On 2007-05-06 23:53:13 +0100, Julian Phillips wrote:

> On Sun, 6 May 2007, Matthieu Moy wrote:
>
> > The reason why I'm posting this is that I was wondering whether
> > "commit -a" not being the default was supposed to be a message
> > like "you shouln't use it too often".
>
> Well, personally I practically never use it, I find that having a
> separation between what the current state of my tree is and what
> will be comitted to be one of the really "oh wow, why doens't
> everything else do this?" features. However, i tend to be working on
> more than one thing at once, and switch between them - so I commit
> work on A while work on B is still unfinished, then start C, finish
> B some point later and commit it, and then I can finish C. Git is
> the first VCS that supports a butterfly mind :P.

git-gui is really handy for adding/committing a subset of the changes
in your working tree. Especially for those of us with goldfish memory,
since it's so easy to see exactly what's happening: what's going to be
committed and what not.

> "git add -i" - this is a feature I have wanted since I started using
> version control ...

I thought "git add -i" was the best thing since sliced bread -- until
I found the same feature in git-gui, but with a _much_ better
interface. Just right-click on a hunk in a diff, and you have the
option of staging/unstaging that hunk. Pure magic.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
