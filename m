From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit: lost all my patches again
Date: Wed, 28 Nov 2007 11:58:14 -0500
Message-ID: <9e4733910711280858j5d03b3acleac0ece7b0a67f66@mail.gmail.com>
References: <9e4733910711271417l32ed9a77p9915aa34a780665b@mail.gmail.com>
	 <9e4733910711271512g790364e0ka4839b2be9fd4935@mail.gmail.com>
	 <20071128093403.GB12977@diana.vm.bytemark.co.uk>
	 <9e4733910711280706j45fe9c17t928396eb8e1de8bf@mail.gmail.com>
	 <20071128160410.GB19302@diana.vm.bytemark.co.uk>
	 <9e4733910711280821s3872eff5m95073ca6b1b8a689@mail.gmail.com>
	 <20071128164113.GA20749@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:59:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxQFC-00085e-88
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 17:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760877AbXK1Q6R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 11:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760757AbXK1Q6Q
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 11:58:16 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:31324 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760602AbXK1Q6O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 11:58:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1814408wah
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 08:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=A9CsdC5cHIYEQoak3KXX2ihKR3KoaaIl3Ug69QsUX10=;
        b=w8zl5F4jeoTXxMjkoedfdTsOy5xjMGeumFZKS+dPwc8UoDcs7JhKnHYCyqUYY6D9pVWd8kOjnqtEEQASkG2xpM6Vk1P0SxVcwoaBJ2m3NLxPSOV5vqEPodcUyO4ttahxfkb77DsbEnCIVtJC+xFEOFenGILVCNnSYaScmxI+S4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sZss5lva5RXxx6iHztI/t0jEzZ4tUAkSCasvAYxDBiwkrd5HI2BVNin1zC4eniU9JacbATviR9O6vF44P9xAoO3+QJU/nL8bpFocyNZLHrr8arEdy7IOC6t3rJmDfO2+3RQmHnswXKN1TMjosPiI2uLja883zoUdtopTf29IFLg=
Received: by 10.114.146.1 with SMTP id t1mr1248203wad.1196269094254;
        Wed, 28 Nov 2007 08:58:14 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 08:58:14 -0800 (PST)
In-Reply-To: <20071128164113.GA20749@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66382>

On 11/28/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-11-28 11:21:05 -0500, Jon Smirl wrote:
>
> > On 11/28/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > > On 2007-11-28 10:06:57 -0500, Jon Smirl wrote:
> > >
> > > > stg repair -- partial repair, some patches empty, half are push=
ed
> > >
> > > Modulo any bugs, this should have adjusted the appliedness of you=
r
> > > patches to match the new HEAD (patches are applied iff they are
> > > reachable from HEAD) and made patches of any non-patch commits
> > > sitting between a patch and HEAD. Nothing else. In particular, it
> > > doesn't change your existing patches or change HEAD, so those
> > > empty patches were empty even before the repair. (Modulo any bugs=
,
> > > of course, but that kind of bug seems really unlikely.)
> >
> > I don't know exactly what is going one, but all of my patches are i=
n
> > commits in front of the rebase. I believe when they were applied
> > again, git detected that the changes were already in the tree and
> > that why the patches are empty. Normally stg would have popped all
> > my patches before doing the rebase.
>
> Ah, yes, if you "stg push" after the repair, that's what you can
> expect to happen. And once you've done that, it gets a little messier
> to recover. (Basically, what you'd do is delete the messed-up patches=
,
> git-reset to where you were before the git-rebase, and then "stg
> uncommit".)
>
> > I have messed the branch up doing manual recover, but the condition=
s
> > are easy enough to recreate.
>
> So I guess "stg repair" is working as intended, and what needs
> changing is its documentation: point out in greater detail that you
> should
>

After someone runs the wrong command their first instinct will be to
run stg repair. Can stg repair be made smart enough to not attempt a
repair if it is unable to do so and print a message referring people
back to the manual on how to move the head back?

When I ran stg repair after the wrong git rebase command, I compounded
the problem further.


>   1. Figure out where you _want_ HEAD to be.
>
>   2. git-reset your way there.
>
>   3. Run stg repair if necessary. (And if you just reset back to wher=
e
>      StGit thinks you are, you don't need to. But it's safe to run
>      repair in that case too -- it'll just do nothing.)
>
> In that order.
>
> The only thing repair does is fix up StGit's metadata to match what
> HEAD is right now. If HEAD isn't what you want it to be, then you wan=
t
> to fix that first. In particular, to just go back to where you were
> the last time StGit heard from you, do
>
>   $ git reset --hard $(stg id $(stg top))
>
> We need a proper manual to explain this in. :-)
>
> --
> Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
