From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 01 Apr 2009 09:53:53 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49D339B2.4388.6B1DEF@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <f9d2a5e10903292318w6108bc50u2ddc830a6d9d85df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 09:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LovJ4-0001gO-Vd
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 09:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760375AbZDAHy3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2009 03:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753668AbZDAHy3
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 03:54:29 -0400
Received: from rrzmta2.rz.uni-regensburg.de ([194.94.155.53]:3732 "EHLO
	rrzmta2.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758245AbZDAHy2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Apr 2009 03:54:28 -0400
Received: from rrzmta2.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 4A09E9F4BC;
	Wed,  1 Apr 2009 09:54:29 +0200 (CEST)
Received: from mailgate.dvm.klinik.uni-regensburg.de (kgate2.klinik.uni-regensburg.de [132.199.176.19])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta2.rz.uni-regensburg.de (Postfix) with ESMTP id B77E1AAACF;
	Wed,  1 Apr 2009 09:54:27 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by mailgate.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20060824MT-1) with ESMTP id n317sJ2v025729;
	Wed, 1 Apr 2009 09:54:19 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    1 Apr 09 09:54:18 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 1 Apr 09 09:54:00 +0100
In-reply-to: <f9d2a5e10903292318w6108bc50u2ddc830a6d9d85df@mail.gmail.com>
X-mailer: Pegasus Mail for Windows (4.41)
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589357@20090401.075343Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115350>

On 29 Mar 2009 at 23:18, Russ Dill wrote:

> On Fri, Mar 27, 2009 at 2:50 AM, Ulrich Windl
> <ulrich.windl@rz.uni-regensburg.de> wrote:
> > On 27 Mar 2009 at 9:05, H.Merijn Brand wrote:
> >
> >> On Fri, 27 Mar 2009 08:21:36 +0100, "Ulrich Windl"
> >> <ulrich.windl@rz.uni-regensburg.de> wrote:
> >>
> >> > What I'd like to see in git (My apologies if some were already d=
iscussed to
> >> > death):
> >> >
> >> > 1) The ability to use the file's time at the time of add/commit =
instead of
> >> > =A0 =A0the current time, and the ability tho check outfiles with=
 the times stored
> >> > =A0 =A0in the repository.
> >> >
> >> > 2) Keyword substitution. I know it's controverse (dealing with b=
inary files),
> >> > =A0 =A0but I'd like to have some automatic version numbering key=
word at least:
> >> > =A0 =A0Initial idea is that every commit with a change increment=
s the number by
> >> > =A0 =A0one, and when merging numbers a and b, the resulting numb=
er is max(a, b) + 1.
> >>
> >> impossible. Even with checkin- and checkout hooks, you won't get t=
hat
> >> SCCS behaviour. They have to be better in something too :)
> >> /me still misses that but got used to it
> >
> > Hi,
> >
> > what made me wonder is this (about item 1): I thought I've read tha=
t blobs store
> > content and attributes, so very obviously I wondered why not store =
thr "right
> > attributes" (i.e. the time of the file). My reasoning: You make som=
e changes, then
> > test them (which might last several hours or days). The if I'm happ=
y I'll
> > "commit". Naturally I want to see the time of change for each file =
when the change
> > had been actually made, not when the change was committed. Likewise=
 when checking
> > out, I want to be able to see the time of modification, not the tim=
e of commit.
> > I'm aware that many people don't care about such differences...
> >
>=20
> Ok, so if Nancy did some work on the part number form 6 months ago,
> but it got merged into master yesterday. What date should the file
> have? This kind of incremental version number, and trusting of file

If Nancy committed it with my semantics, the file's date would be 6 mon=
ths old=20
before the merge. If the merge would not require any change, the file's=
 date would=20
still be six months old. If a change was required, the file's date woul=
d be the=20
time of change. That sounds quite logical to me.

> dates really only matters on a centralized system with a single
> branch.
>=20
> Not only that, but modification times are much more useful with make.
> Merging or pulling small changes into a tree shouldn't require a full
> rebuild of the entire tree which in some cases could take hours.

Git is not a build system, and I really dislike "full rebuilds", but fo=
r=20
stability, before releasing anything, one should test it with a full re=
build. I=20
think that's what configuration management systems are about. So for a =
merge or=20
checkout of any make source object (opposed to: make target object), an=
 automated=20
cleanup of the corresponding target objects should be made. I know that=
 you don't=20
like it, but for RCS you have the couce whether to check-in with "-d", =
or check=20
out with "-M". If it's optional in GIT also, you shouldn't be unhappy.

> Especially since 'git log <file>', 'gitk <file>', or 'git blame
> <file>' give much more information anyway.
>=20
> I know some people sort their directory by date to see what kind of
> stuff happened since they last worked on the repository, but it
> doesn't scale to a project with many directories and the log is much
> more useful anyway.

I agree.

Regards,
Ulrich
