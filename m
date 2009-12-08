From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: help: bisect single file from repos
Date: Tue, 8 Dec 2009 09:17:17 +0100
Message-ID: <200912080917.17220.chriscool@tuxfamily.org>
References: <4B1CFC4C.6090406@bfs.de> <4B1D1A5A.9060004@drmicha.warpmail.net> <4B1D27B6.7010900@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: wharms@bfs.de
X-From: git-owner@vger.kernel.org Tue Dec 08 09:15:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHvDo-0003yi-P0
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 09:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753670AbZLHIOo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 03:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605AbZLHIOn
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 03:14:43 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:50564 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408AbZLHIOm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Dec 2009 03:14:42 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 76C0F818042;
	Tue,  8 Dec 2009 09:14:42 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 69B4A8180EC;
	Tue,  8 Dec 2009 09:14:40 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <4B1D27B6.7010900@bfs.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134842>

Hi,

On lundi 07 d=C3=A9cembre 2009, walter harms wrote:
> Michael J Gruber schrieb:
> > walter harms venit, vidit, dixit 07.12.2009 13:59:
> >> Hi list,
> >> i am new to git (using: git version 1.6.0.2).
> >
> > though your git is not that new ;)
> >
> >> I would like to bisect a single file but i have only commit id, no
> >> tags.
> >>
> >> Background:
> >> I have a copy of the busybox git repos, and i know there is (perha=
ps)
> >> a bug in ash.c.
> >>
> >> how can i do that ?
> >
> > You don't need any tags for bisecting. The man page of git-bisect h=
as
> > several examples on how to use it. Do you have a test script which
> > exposes the bug?
>
> unfortunately no, the error shows up very nicely when booting my
> embdedded system but not else (this is the reason i would to bisect t=
hat
> file only and not busybox completely). And from the man pages i got t=
he
> impression that it is only possible the start with a tag.

The man page says:

git bisect start [<bad> [<good>...]] [--] [<paths>...]

and then:

"This command uses git rev-list --bisect to help drive the binary searc=
h=20
process to find which change introduced a bug, given an old "good" comm=
it=20
object name and a later "bad" commit object name."

> i already had the hint that i need to do:
> git bisect start bad_commit_id good_commit_id -- ash.c

So did you try that?

> Ntl, there is one more question, how can i make sure that
> i use the right version ?

If you mean the right git version, then I think any 1.6.X should be eno=
ugh.

> first i toughed  that cherry-pick is the right=20
> idea but it seems that that will apply onyl certain patches ?

If you want to find the commit that introduced a bug, then you should n=
ot=20
need cherry-pick.

Regards,
Christian.
