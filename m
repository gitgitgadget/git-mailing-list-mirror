From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 22:23:15 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-E17C62.22231529012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <7vaavwh6yh.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001291833580.1681@xanadu.home> <7vy6jgcutb.fsf@alter.siamese.dyndns.org> <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com> <7viqakcu56.fsf@alter.siamese.dyndns.org> <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com> <alpine.LFD.2.00.1001292013150.1681@xanadu.home> <ron1-F006CF.18381129012010@news.gmane.org> <7vbpgc8fhb.fsf@alter.siamese.dyndns.org> <76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 07:23:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb6kJ-0000Od-6U
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 07:23:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab0A3GXq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 01:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194Ab0A3GXq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 01:23:46 -0500
Received: from lo.gmane.org ([80.91.229.12]:38589 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847Ab0A3GXq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 01:23:46 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nb6k7-0000IA-IO
	for git@vger.kernel.org; Sat, 30 Jan 2010 07:23:39 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 07:23:39 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 07:23:39 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138454>

In article=20
<76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com>,
 Jay Soffian <jaysoffian@gmail.com> wrote:

> On Fri, Jan 29, 2010 at 9:59 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
> > Ron Garret <ron1@flownet.com> writes:
> >
> >> 1. =C2=A0The term "detached HEAD" is inherently misleading. =C2=A0=
A detached HEAD
> >> isn't detached from anything, it's just pointing to the middle of =
a
> >> branch, which is to say, to a commit that happens to already have
> >> descendants. =C2=A0For that matter, the name HEAD is itself mislea=
ding, since
> >> HEAD need not be the head of a branch (though normally it is). =C2=
=A0A better
> >> name for HEAD would have been CURRENT or ACTIVE. =C2=A0I recognize=
 it's
> >> probably too late to change it now.
> >
> > This description, especially the phrase "middle of a branch" shows =
that
> > you don't understand git yet. =C2=A0A git branch is _not_ a line (n=
or multiple
> > lines) of development. =C2=A0It is merely a _point_ in the history.
> >
> > "A commit that is in the middle of an ancestry chain with existing
> > descendants" can be at the tip of a branch and does not have anythi=
ng to
> > do with detached HEAD state.
> >
> > When HEAD points at a branch, making a commit advances _that_ branc=
h. =C2=A0And
> > we say you are "on that branch". =C2=A0When HEAD is detached, becau=
se it is not
> > attached to anything, it advances no branch. =C2=A0"detached HEAD" =
is detached
> > in the very real sense. =C2=A0It is not attached to _any_ branch.
>=20
> Let me try wording this slightly different, because I think I can see
> Ron's confusion.

[snip]

> So that was a really long explanation, but I hope it clears things up=
=2E

Yes, that was very helpful, thank you.

Might it make more sense to talk about "anonymous branches" or "unnamed=
=20
branches" instead of "detached heads"?  I think something like the=20
following would be much easier to grasp:

WARNING: Your HEAD is now pointing to a commit that is not a named
branch head.  As a result of this, any commits off of this one may
be lost during the next garbage collection.  If you want to prevent
this, you should give this branch head a name by doing ...

rg
