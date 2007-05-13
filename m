From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Merging commits together into a super-commit
Date: Sun, 13 May 2007 20:43:27 +0200
Message-ID: <20070513184327.GA14078@diana.vm.bytemark.co.uk>
References: <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org> <20070510192106.GB4489@pasky.or.cz> <87tzuk31fu.wl%cworth@cworth.org> <20070512113430.GL19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070512140228.GB28039@diana.vm.bytemark.co.uk> <20070512144145.GF16903@nan92-1-81-57-214-146.fbx.proxad.net> <7vy7jtyh8q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, Carl Worth <cworth@cworth.org>,
	Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 20:45:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnJ4D-0001Zh-BV
	for gcvg-git@gmane.org; Sun, 13 May 2007 20:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbXEMSpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 14:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757674AbXEMSpI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 14:45:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4054 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757568AbXEMSpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 14:45:07 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HnJ2V-0003jm-00; Sun, 13 May 2007 19:43:27 +0100
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Yann Dirson <ydirson@altern.org>, Carl Worth <cworth@cworth.org>,
	Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy7jtyh8q.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47166>

On 2007-05-12 12:27:49 -0700, Junio C Hamano wrote:

> Yann Dirson <ydirson@altern.org> writes:
>
> > This supposes there is no valuable branch-level metadata.
> > Currently we have the description - something which could arguably
> > be moved to the git level as well. Otherwise that sounds
> > reasonable to me.
>
> Will it be something like
>
>       [branch "master"]
>               description =3D "My primary development line"

Yes, exactly. It's just a simple per-branch description string, just
like in your suggestion.

> if so I think that is a reasonable thing to do, from git-core's
> point of view. Obviously, gitk, tig, gitweb and friends can use
> this, too.

Absolutely.

> Are there other per-branch information StGIT wants to keep on an
> active branch that might benefit the core as well?

No, I'm pretty sure there isn't.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
