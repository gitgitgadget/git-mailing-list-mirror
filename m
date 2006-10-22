From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 15:51:54 +0200
Organization: At home
Message-ID: <ehft1f$9le$1@sea.gmane.org>
References: <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org> <20061021130111.GL75501@over-yonder.net> <87ac3p1jn7.wl%cworth@cworth.org> <20061022124635.GR75501@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Sun Oct 22 15:52:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gbdk8-0008T1-8P
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWJVNv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 09:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWJVNv5
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:51:57 -0400
Received: from main.gmane.org ([80.91.229.2]:25739 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750945AbWJVNv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 09:51:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gbdjw-0008RS-Kk
	for git@vger.kernel.org; Sun, 22 Oct 2006 15:51:48 +0200
Received: from host-81-190-23-110.torun.mm.pl ([81.190.23.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 15:51:48 +0200
Received: from jnareb by host-81-190-23-110.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 15:51:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-23-110.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29747>

Matthew D. Fuller wrote:

> =A0 It can also be useful in looking at cases where you don't
> =A0 necessarily have the tool. =A0Compare putting CVS's rcsid tags in
> =A0 strings in the source. =A0static const char *rcsid =3D "$Id"; and=
 the
> =A0 like. =A0Then you can use 'ident' on the compiled binaries to see=
 the
> =A0 revs of files in them. =A0If somebody says "foo.c has a bug in 1.=
34,
> =A0 fixed in 1.37", I can without any VCS interaction just look at th=
e
> =A0 compiled binary and tell whether I'm prior to the bug, have the b=
ug,
> =A0 or after the fix. =A0If the binary is known to be compiled from a
> =A0 particular branch, a tree-wide revno tells me that too. =A0A revi=
d
> =A0 (even one containing a date) won't tell me that; I'll have to fin=
d
> =A0 the tool and a copy of the tree and find out if my rev contains t=
hat
> =A0 other rev.

We use signed tags for tagging official releases (e.g. v1.4.0 tag),
and we use "git describe" output to be embedded during build time
in resulting binary. For example my current output of git-describe
on my clone of git repository is:

 $ git describe=20
 v1.4.3.1-g2c8a022

Git project does this, gitweb does this, Linux kernel does this.
This is quite coarse grained, i.e. you know ahich released version
it is after, but you need git tools (or access to git tools via
gitweb) to check if it is after or before the fix.

Of course that is when you run GIT version of tool...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
