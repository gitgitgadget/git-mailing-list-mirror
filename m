From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: avoid duplicate patches from git log ?
Date: Wed, 4 May 2016 13:58:57 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605041347170.9313@virtualbox>
References: <712E44CFAD1A41A982AEF1540C1F9F80@PhilipOakley><20160503220039.GB25133@sigill.intra.peff.net> <xmqqbn4mlrk2.fsf@gitster.mtv.corp.google.com> <E735FEEE2908434F874CAD1874307E38@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed May 04 13:59:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axvSU-00034a-SG
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 13:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbcEDL7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 07:59:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:51354 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656AbcEDL7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 07:59:07 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MEbYb-1ar2mR0tUP-00FiY0; Wed, 04 May 2016 13:58:58
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <E735FEEE2908434F874CAD1874307E38@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:kCJIXdgUFUTWr7UcD7mZnrRoE3/XfmP1mZtynyu/O5ovmjiR0kl
 wzMQ08Zrn7DnihrrxovKtdbs0X1hG3m5NI7prdM96k5K6IRnfDvtYz4McraZC9aIKsQnfkv
 Nhlrm6NoTcXnPIK2A+urO6cR5RFaHNzEUlJgemdu/Y/2+VLsGpe/bbIawFO1OJ9XDF7UkN1
 rugGBbAGNmlO2OHYWkUWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c43Q12u5+2Q=:xOZVvzYXW1QsgipEavL0U7
 QuXVlBnOSQXpBu+p0HmZY/2C5FksJ0Ydle6HEhCVFdddlHFnpNuBnQXzgYNJt7swoKqoGcsbP
 IMhU8MMTcW4mQ+ABFIsmZtSqk/uf6zUa5VmgyhdizeUtpSQKQielnD9uXPGf8x4wQAHyAHkZT
 H97Sl1VP78cyOeW48kCynR1s+vQLnOwj5jh0TtCXr5uD1jQh9eaEEfV0nMhCx1eMbJnulYjeu
 QqoPHX9UUeDnLDM2cdSY/d/2AztdTjHEFzWJ/Tt16fBLXXk1x0ANDa4qwL+4v62qkcg5nlzZ7
 Ij3GrmmbbIWSwpVKtGmAxj/PBpUlwBmUglBwydoTP7bT3Tyly0271QsOuKRTIz5DsWkAaK4BP
 SO+4Qu1gaidAvd+JI117Kw+tF6MUctCXH10ffg6wft8QEbvc1UOLyK3T96uvHdrHVFASJ1Pc3
 40pFowLJJqy9/PdLdF6AmcB+nCc0e8waSFVavXKYoDRzLxEu3QG6g5PyEAo6KH0zy2+7DdX+Y
 tv3W/rAmv7c+aNW69yAXbwxwLG/UEGEX+uYSdEzPJXaXUcw8iBicNoogP9xdmw3qqhjmzycAR
 PNuqXB8sBe/WM84Uk7W9c7kGnYG4Nc7oZjl6zXedKYgytXDLen8UvhUq8iyBJRF3wgZ+my67C
 jhrzqnml3q/3DYSAo5Tw6fAI7+34GfTF6DvHsv+m6JnMkOyK4ICwkvvOHN9LfcJibe/wfm7sQ
 qO1/XSrOGzKIxLHo4IOAlJj9ra48XWQ34ehs4ZXn4Ai6jjnkjmjp2sHPqmQkwtpr2ndwbse4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293542>

Hi Philip,

On Tue, 3 May 2016, Philip Oakley wrote:

> From: "Junio C Hamano" <gitster@pobox.com>
> > Jeff King <peff@peff.net> writes:
> >
> > > On Tue, May 03, 2016 at 09:11:55PM +0100, Philip Oakley wrote:
> > >
> > > > However, as the G4W project (https://github.com/git-for-windows/git/)
> > > > follows the main git repo and its releases, it needs to rebase it's
> > > > fixup
> > > > patches, while retaining their original series, so has repeated copies
> > > > of
> > > > those fix patches on the second parent path (a technique Dscho called
> > > > rebasing merges).
> > > >
> > > > for example:
> > > > > bf1a7ff (MinGW: disable CRT command line globbing, 2011-01-07)
> > > > > a05e9a8 (MinGW: disable CRT command line globbing, 2011-01-07)
> > > > > 45cfa35 (MinGW: disable CRT command line globbing, 2011-01-07)
> > > > > 1d35390 (MinGW: disable CRT command line globbing, 2011-01-07)
> > > > > 022e029 (MinGW: disable CRT command line globbing, 2011-01-07)
> > > >
> > > >
> > > > How can I filter out all the duplicate patches which are identical other
> > > > than the commit date?
> > > >
> > > > The --left --right and --cherry don't appear to do what I'd expect/hope.
> > > > Any
> > > > suggestions?
> > >
> > > I don't think there's a good way right now. The option that suppresses
> > > commits is --cherry-pick, but it wants there to be a "left" and "right"
> > > from a symmetric difference, and to cull duplicates from the various
> > > sides.
> > >
> > > I think you really just want to keep a running list of all of the
> > > commits you've seen and cull any duplicates. I guess you'd want this as
> > > part of the history simplification step, so that whole uninteresting
> > > side-branches are culled.
> > >
> > > The obvious choice for matching two commits is patch-id, though it can
> > > be expensive to generate. There have been patches playing around with
> > > caching in the past, but nothing merged. For your purposes, I suspect
> > > matching an "(author, authordate, subject)" tuple would be sufficient
> > > and fast.
> >
> > What would be really interesting is what should happen when the side
> > "rebase merge" branch that is supposed to be irrelevant for the
> > purpose of explaining the overall history does not become empty
> > after such filtering operation.  The merge commit itself may claim
> > that both branches are equivalent, but in reality it may turn out
> > that the merge failed to reflect the effect of some other changes in
> > the history of the side branch in the result--which would be a
> > ticking time-bomb for future mismerges waiting to happen.
> 
> I think that's a misunderstanding of the development process for an "on
> top of" project, where the upstream would not be expected to take all
> the fixups for that project's customers.

Exactly. The merging-rebase technique only makes sense when the entire set
of changes is rebased.

Please note that I do drop some patches from time to time, so what Junio
fears is actually not a time bomb, but rather the intended benefit.

The *real* advantage of the merging-rebase technique is that contributors
can easily call `git rebase origin/master` *even after* origin was
"rebased". Because it was both rebased, and not rebased.

> The releases of the project do need to be retained in the history, but
> because of the "on top of" policy, the prior release becomes a second
> parent to a "theirs" merge commit of the upstream (and subsequent rebase
> on top of that).

This is a secondary concern, true. But we could easily tag the releases
and then continue `master` with a rebased version, i.e. `master` would
usually not fast-forward from tagged commits.

But it would make contributing much harder than it already is.

> It may be that Peff's suggestion is a workable heuristic for a rebase
> flow where one could eliminate those duplicates quite easily. I just had
> a feeling that there was already something that did the patch-id thing
> for duplicate removals, but obviously I had that wrong.

Oh, we do have that logic, it is the --cherry option of the rev-list
machinery. It's just that due to the merging-rebase technique, you cannot
have your desired commits on one side and the undesired ones on the other
side of the "...".

Unless...

Unless you play games with the grafts. You *could* pretend that the "Start
the merging-rebase" commit had only its first parent, using a graft. Then
"git log --cherry --right-only SECOND_PARENT...HEAD" (where SECOND_PARENT
would be the culled second parent of that merge commit) would have the
intended result.

You should not forget to remove the graft afterwards, though. (You *might*
be able to finagle something more temporary by using `git replace`,
dunno, still finicky.)

Ciao,
Dscho
