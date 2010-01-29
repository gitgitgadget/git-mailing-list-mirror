From: Ron Garret <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:43:40 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-A90E72.13434029012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> <alpine.DEB.1.00.1001292131330.3749@intel-tinevez-2-302> <ron1-F6943B.13162129012010@news.gmane.org> <8c9a061001291325i4b8898b9m46054040c69f8fc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 22:45:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayeQ-0008Cz-Ll
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181Ab0A2VpI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 16:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176Ab0A2VpH
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:45:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:60741 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932172Ab0A2VpG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:45:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NayeH-00088K-GI
	for git@vger.kernel.org; Fri, 29 Jan 2010 22:45:05 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:45:05 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:45:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138373>

In article <8c9a061001291325i4b8898b9m46054040c69f8fc6@mail.gmail.com>,
 Jacob Helwig <jacob.helwig@gmail.com> wrote:

> On Fri, Jan 29, 2010 at 13:16, Ron1 <ron1@flownet.com> wrote:
> > I know that master^ is a commit and not a branch. =C2=A0I thought I=
 was
> > invoking the third variant of git-checkout (as given on the git-che=
ckout
> > man page) and checking out a commit (which the man page calls a
> > tree-ish).
> >
> > In any case, since my question seems to have sparked some discussio=
n,
> > I'd like to offer two observations:
> >
> > 1. =C2=A0Saying "isn't a local branch" is mightily confusing, becau=
se it is
> > ambiguous whether the problem is that it isn't a branch or if it is=
n't
> > local.
> >
> > 2. =C2=A0If I pass something to git checkout (or any other command =
for that
> > matter) that it expects to be a branch but isn't a branch it would =
be
> > much better if it just gave an error and did nothing rather than gi=
ve a
> > (confusing) warning and try to extrapolate the user's intentions.
> > Whatever a user could possibly mean by 'git checkout master^' it is
> > almost certainly not what that command actually does at the moment.
> >
>=20
> I don't think that #2 would be possible.

Of course it's possible.  It git can complain and do something (which i=
s=20
what it does now) then it can just as easily complain and do nothing.

> My understanding is that
> branches are basically just there as convenient "names" for arbitrary
> commits.  In other words (in my understanding): There is no place tha=
t
> expects a "branch" where a commit (SHA-1) would not work (and be a
> perfectly valid use).

No, that's not true.  Branches have names that are recorded separately=20
from non-branch commits.  It's not a big difference, but it is a=20
difference.

rg
