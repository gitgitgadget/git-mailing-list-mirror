From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 02:24:03 +0200
Organization: At home
Message-ID: <eh17q6$od$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org> <200610170155.10536.jnareb@gmail.com> <Pine.LNX.4.64.0610161704240.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Tue Oct 17 02:24:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZckN-0001dd-Ly
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422978AbWJQAXr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Oct 2006 20:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422977AbWJQAXp
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:23:45 -0400
Received: from main.gmane.org ([80.91.229.2]:19380 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422978AbWJQAXo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 20:23:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZck9-0001bn-FX
	for git@vger.kernel.org; Tue, 17 Oct 2006 02:23:41 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 02:23:41 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 02:23:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29004>

Linus Torvalds wrote:

>> > So there is seldom any real need or reason to actually have multip=
le=20
>> > checkouts. But it certainly _works_.
>>=20
>> But without .git being either symlink, or .git/.gitdir "symref"-link=
,
>> you have to remember what to ser GIT_DIR to, or parameter for --git-=
dir
>> option.
>=20
> I'd strongly suggest that people who do this should actually do
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git clone -l
>=20
> instead of actually playing games with symlinking .git/ itself or usi=
ng=20
> GIT_DIR. It means that the two checkouts get separate branch namespac=
es,=20
> but that's really what you'd want most of the time.=20

Or symlinking .git/objects (and perhaps .git/remotes and .git/branches)=
=2E
BTW. wouldn't it be rather git clone -l -s? What would happenm on repac=
k,
or on repack -a -d?

But it is true that there is no need to checkout different branches
to different working areas.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
