From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 5/6] Refresh the main stg man page
Date: Tue, 7 Oct 2008 09:40:54 +0200
Message-ID: <20081007074054.GE31332@diana.vm.bytemark.co.uk>
References: <20081005155450.19886.43748.stgit@yoghurt> <20081005160157.19886.7137.stgit@yoghurt> <b0943d9e0810061414ja87488k6aef65fec0856144@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 09:42:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn7Cx-000314-VG
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 09:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbYJGHlF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Oct 2008 03:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYJGHlE
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 03:41:04 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1081 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYJGHlC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 03:41:02 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kn7Be-0008K2-00; Tue, 07 Oct 2008 08:40:54 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0810061414ja87488k6aef65fec0856144@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97681>

On 2008-10-06 22:14:05 +0100, Catalin Marinas wrote:

> 2008/10/5 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > --- a/Documentation/stg.txt
> > +++ b/Documentation/stg.txt
> [...]
> > +  * After making changes to the worktree, you can incorporate the
> > +    changes into an existing patch; this is called 'refreshing'. Y=
ou
> > +    may refresh any patch, not just the topmost one.
>
> I wouldn't advertise the refreshing of "any" patch as it doesn't
> always work (it actually fails in a lot of cases). Or at least we
> could mention that there are some restrictions.

Well, when it does fail, it fails in a controlled way, and lets the
user manually sort out the conflicts or undo. But I guess we could say
that.

When I wrote this, I didn't yet have a "Conflicts" chapter to point
to. :-)

> > +  * You can easily 'rebase' your patch stack on top of any other G=
it
> > +    branch.
>
> It might be better with something like "on top of a different Git
> commit". The first thought when reading the above is that you can
> move the patch stack to a different Git branch easily, which is not
> the case (you need to cherry-pick the patches).

Right, that makes sense. (We might want to mention "remote branch"
explicitly, though, since that's by far the most common case.)

> > +  * The patch stack is just some extra metadata attached to regula=
r
> > +    Git commits, so you can continue to use Git tools along with
> > +    StGit.
>
> Again, this is with some restrictions (or there aren't any with the
> new infrastructure?).

Well, "stg undo" can repair any havoc the git tools can make. And by
"havoc" I mean merge or rebase.

This should probably grow a short disclaimer, and point to the "git
interoperability" chapter.

> > +  Tracking changes from a remote branch, while maintaining local
> > +  modifications against that branch, possibly with the intent of
> > +  sending some patches upstream. You can modify your patch stack a=
s
> > +  much as you want, and when your patches are finally accepted
> > +  upstream, the permanent recorded Git history will contain just t=
he
> > +  final sequence of patches, and not the messy sequence of edits t=
hat
> > +  produced them.
>
> Maybe we could mention that the local history is also clean, not
> only the upstream tree (though you mention it later in a different
> hunk).

Hmm, yes. Though I can't immediately think of any wording that doesn't
make that paragraph a lot more complicated. Suggestions welcome.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
