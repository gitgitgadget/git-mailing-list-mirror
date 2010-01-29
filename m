From: Ron1 <ron1@flownet.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 13:16:21 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-F6943B.13162129012010@news.gmane.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com> <alpine.DEB.1.00.1001292131330.3749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 22:16:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayD1-0000vm-P3
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab0A2VQq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 16:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755536Ab0A2VQq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:16:46 -0500
Received: from lo.gmane.org ([80.91.229.12]:44753 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463Ab0A2VQp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:16:45 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NayCo-0000qK-Ry
	for git@vger.kernel.org; Fri, 29 Jan 2010 22:16:42 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:16:42 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 22:16:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138357>

In article <alpine.DEB.1.00.1001292131330.3749@intel-tinevez-2-302>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
>=20
> On Fri, 29 Jan 2010, Jacob Helwig wrote:
>=20
> > On Fri, Jan 29, 2010 at 12:20, Ron1 <ron1@flownet.com> wrote:
> > > [ron@mickey]$ git checkout master
> > > Already on 'master'
> > > [ron@mickey]$ git checkout master^
> > > Note: moving to 'master^' which isn't a local branch
> > > If you want to create a new branch from this checkout, you may do=
 so
> > > (now or later) by using -b with the checkout command again. Examp=
le:
> > > =C2=A0git checkout -b <new_branch_name>
> > > HEAD is now at 7be05e0... test
> > > [ron@mickey]$ git branch
> > > * (no branch)
> > > =C2=A0master
> > > [ron@mickey]$
> > >
> > > Huh?!?
> > >
> > > This is a test repository which has never been pulled from nor pu=
shed to
> > > anywhere. =C2=A0So how is it possible that I have a non-local bra=
nch?
> >=20
> > master^ is a commit (the first parent of master), not a branch (loc=
al
> > or otherwise).
>=20
> Indeed.  Maybe you (Ron1) need to get a bit more acquainted to Git be=
fore=20
> complaining.


Chill, dude. =C2=A0I'm not complaining. =C2=A0I'm just confused.

I know that master^ is a commit and not a branch. =C2=A0I thought I was=
=20
invoking the third variant of git-checkout (as given on the git-checkou=
t=20
man page) and checking out a commit (which the man page calls a=20
tree-ish).

In any case, since my question seems to have sparked some discussion,=20
I'd like to offer two observations:

1.  Saying "isn't a local branch" is mightily confusing, because it is=20
ambiguous whether the problem is that it isn't a branch or if it isn't=20
local.

2.  If I pass something to git checkout (or any other command for that=20
matter) that it expects to be a branch but isn't a branch it would be=20
much better if it just gave an error and did nothing rather than give a=
=20
(confusing) warning and try to extrapolate the user's intentions. =20
Whatever a user could possibly mean by 'git checkout master^' it is=20
almost certainly not what that command actually does at the moment.

rg
