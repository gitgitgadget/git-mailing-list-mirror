From: Mark Lundquist <lundquist.mark@gmail.com>
Subject: [noob] questions about git-svn, svk
Date: Fri, 06 Jun 2008 22:51:40 -0700
Message-ID: <g2d7ld$8dq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 07:56:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4rPD-0007BA-IV
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 07:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbYFGFzF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 01:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755841AbYFGFzF
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 01:55:05 -0400
Received: from main.gmane.org ([80.91.229.2]:53092 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181AbYFGFzE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 01:55:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K4rOI-0004iP-6S
	for git@vger.kernel.org; Sat, 07 Jun 2008 05:55:02 +0000
Received: from c-24-22-114-191.hsd1.mn.comcast.net ([24.22.114.191])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 05:55:02 +0000
Received: from lundquist.mark by c-24-22-114-191.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 05:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-22-114-191.hsd1.mn.comcast.net
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84175>

Hi,

Okay, I'm an experienced SVN & SVK user, and I'm ready to start the=20
process of switching to git.  I just have a couple of questions...

I'm a complete noob to the ways of git, so plz bear with me :-)

All our projects are contained in our main svn repository, for the usua=
l=20
reasons.  I've been mirroring that repository with SVK on my local=20
machine for the last year or two and using SVK as my Subversion=20
front-end.  So, I have all these working copies of various projects, an=
d=20
of course these are all checkouts of SVK local branches (which under th=
e=20
hood are svn copies of within the mirror, in the depot repository).

That was a lame explanation... if you know SVK then you alread know all=
=20
that, and if you don't then it doesn't matter anyway :-/ but the point=20
is that I have something like

	work/
	   projects/
	      project-A/
		.
		.
	      project-B/
		.
		.
	      project-C/
		.
		.


So, I'd like to start out by using git-svn, just changing how I do my=20
own work and developing my git-fu before I roll this learning curve out=
=20
to the server side :-).


1) So I understand that each of project-A, project-B etc. will be a=20
local git repository, so.. how do init/clone/whatever these things to=20
track the remote svn repository, but so that they each just contain the=
=20
corresponding project, rather than all projects from the remote repo?

2) Apparently, I can get the ball rolling by importing my SVK mirror=20
(using "git svn init --use-svm-props") instead of cloning the remote=20
repository directly... I was thinking to do that and save the long=20
network suck time.  But then since my git repo would be tracking my SVK=
=20
depot, I'd have to use SVK to mediate all my syncs (in SVK jargon) to=20
the remote.  Anyway, I don't have any desire to keep on using SVK, I=20
really just want to take advantage of my local depot mirror to speed up=
=20
the initial clone, then I want to cut the cord.  Is there a way to poin=
t=20
my git-svn repo at the remote Subversion repo after I import, and leave=
=20
the SVK mirror behind?

3) One possibly (I don't know! :-) complicating factor... most of these=
=20
projects are actually web site implementations, and these all began lif=
e=20
as Subversion copies of a skeletal, "template" project that contains a=20
bunch of stuff to configure our web application framework, etc.  There'=
s=20
some version history there that has some value and I'd like to preserve=
=20
it.  Any special considerations in view of that?

4) Soon the time will come to switch to Subversion on the server side.=20
Whatever that setup looks like, I'd like it to reflect git best=20
practices and not have anything that smells like "well yeah, this is=20
weird, but see, it's that way because these projects used to be=20
maintained under Subversion."  So, what will be the best way to "get=20
from here to there?"  And when I have that, will that then break my=20
git-svn project repositories that I am about to make on my local=20
machine?  Will I have to start over with all new project repos tracking=
=20
the git repos on the server?

Any help / ideas / random thoughts appreciated... :-)

cheers,
=97ml=97
