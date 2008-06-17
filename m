From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Tue, 17 Jun 2008 09:37:14 +0200
Message-ID: <20080617073714.GB5346@diana.vm.bytemark.co.uk>
References: <20080616110113.GA22945@elte.hu> <20080616110918.GA30856@glandium.org> <20080616154851.GA6938@artemis.madism.org> <20080616155747.GB6938@artemis.madism.org> <bd6139dc0806160918w1eea96f3r6f676d7cf186652d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Mike Hommey <mh@glandium.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 17 09:39:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Vmw-0001kR-17
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 09:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbYFQHih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2008 03:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754470AbYFQHih
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 03:38:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1041 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbYFQHie (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 03:38:34 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K8Vkg-0001Yj-00; Tue, 17 Jun 2008 08:37:14 +0100
Content-Disposition: inline
In-Reply-To: <bd6139dc0806160918w1eea96f3r6f676d7cf186652d@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85274>

On 2008-06-16 18:18:40 +0200, Sverre Rabbelier wrote:

> On Mon, Jun 16, 2008 at 5:57 PM, Pierre Habouzit <madcoder@debian.org=
> wrote:
>
> > On Mon, Jun 16, 2008 at 03:48:51PM +0000, Pierre Habouzit wrote:
> >
> > > Actually it would be rather straightforward to put it in the
> > > usual git store, and represent the current rr-cache with a flat
> > > file that points to the in-git preimage/postimages, and make
> > > git-gc aware of those.
> >
> > Actually, this is probably a required step in the direction of
> > sharing such things btw.
>
> Perhaps an approach similar to the 'notes' implementation can be
> used, in which a separate branch is created to contain the notes.
> This way the rerere information (being the 'rerere' branch) can be
> shared easily (by just pulling the branch), and as said we get free
> compression. Another advantage would be that you automagically get
> the ability to unlearn a bad rerere by simply (partially) reverting
> a commit on the rerere branch!

=46WIW, StGit is well on its way to store its patch metadata in a git
branch, for much the same reasons.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
