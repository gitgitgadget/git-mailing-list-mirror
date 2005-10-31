From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Mon, 31 Oct 2005 13:39:52 -0700
Message-ID: <E1EWgRc-0003ME-Rg@highlab.com>
References: <43652934.8000308@zytor.com> <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net> <20051031064105.GV8041@shell0.pdx.osdl.net> <43663EEA.5050102@zytor.com> <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net> <46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com>
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 21:37:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWgNK-0005lE-Qf
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 21:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVJaUfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 15:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVJaUfV
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 15:35:21 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:51362 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751014AbVJaUfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 15:35:20 -0500
Received: from highlab.com ([67.173.252.245])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005103120351201300eftnre>; Mon, 31 Oct 2005 20:35:13 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1EWgRc-0003ME-Rg; Mon, 31 Oct 2005 13:39:52 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-reply-to: <46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com> 
Comments: In-reply-to Martin Langhoff <martin.langhoff@gmail.com>
   message dated "Tue, 01 Nov 2005 09:13:41 +1300."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10883>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 11/1/05, Junio C Hamano <junkio@cox.net> wrote:
> > I am currently generating i386 RPMs and i386 debs myself but I
> > am not particularly proud of the current setup.  I do not have
> > an RPM based machine that I can install the result myself to
> > test (which is what started this thread).  Since I am not a
> > Debian developer (and I do not particularly wish to become one
> > myself), the debs I generate will not be official anyway.
> > Personally I'd be happier if I can just lose rpm and deb targets
> > from the "upstream" Makefile (git-core.spec file and debian/
> > subdirectory as well while we are at it), ask "packaging
> > maintainers" to pull from kernel.org/ tree and do RPMs and Debs
> > outside.
> 
> I'd say you can probably keep the current setup, and as distro
> (format?) specific maintainers show up and start maintaining bits and
> pieces, merge from them. git should make that easy ;-)
> 
> I'm not a DD -- but I'm on the 'NM queue' which means I'm in the
> process of turning into one (delayed at the moment, but hapenning
> soonish). Have a package in the archive, and a few sponsors who are
> generally happy to upload my work. Would be happy to give it a go if
> noone else steps up.
> 
> (Sebastian _did_ indicate interest, and fought a long, hard battle in
> debian-devel about the naming of the git and cg utilities. I haven't
> seen him around lately (last post:
> http://marc.theaimsgroup.com/?l=3Dgit&m=3D112747921603277&w=3D2 ). May be
> on holiday? CC'd)

I'm here :-)

The GNU Interactive Tools people are changing their name (to "gitfm"),
but they want a script called "git" to remind people that the name
has changed...  So I still have to rename our git to "gt" or something,
until they remove their git script.

We're going to use update-alternatives so people who dont care about
GNU Interactive Tools can call their git "git".  This is in violation
of Debian Policy, but I'm hoping my sponsor will forgive me, as it is
just a temporary violation.


I hope to get this work done sometime this week, and if I have anything
useful I'll send the patches to the list.


-- 
Sebastian Kuzminsky
