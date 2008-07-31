From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Merging submodules
Date: Thu, 31 Jul 2008 17:01:23 +0200
Message-ID: <20080731170123.79e0d3e9@pc09.procura.nl>
References: <20080730230336.GA6481@Hermes>
	<20080731092104.1a6ce8bd@pc09.procura.nl>
	<20080731143955.034f0577@pc09.procura.nl>
	<20080731130626.GQ32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>,
	Lars Noschinski <lars-2008-1@usenet.noschinski.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 31 17:02:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOZfl-00029n-5m
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 17:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbYGaPBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 11:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbYGaPBb
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 11:01:31 -0400
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29]:4335 "EHLO
	smtp-vbr9.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbYGaPBa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 11:01:30 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6VF1O3W095186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 17:01:24 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080731130626.GQ32184@machine.or.cz>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90951>

On Thu, 31 Jul 2008 15:06:26 +0200, Petr Baudis <pasky@suse.cz> wrote:

> On Thu, Jul 31, 2008 at 02:39:55PM +0200, H.Merijn Brand wrote:
> > On Thu, 31 Jul 2008 09:21:04 +0200, "H.Merijn Brand"
> > <h.m.brand@xs4all.nl> wrote:
> > 
> > > I will now be playing with the results a bit. I have attached the
> > > script, in case you might want to use it in documentation or examples.
> > > For now, all the mods are hardcoded. No arguments and so on.
> > > 
> > > Again, Thanks!
> > 
> > There is a slight problem with this merging approach. The path names
> > are as they are/were in the submodules. In module_a, foo.pl was without
> > a leading module_a/ path, and now after integration, it still is. Is it
> > possible to rethink this whole process that integrates/merges the
> > several git repo's in subfolders into the current folder, as-if they
> > would have been in this folder in the first place?
> 
> I would suggest re-reading Santi's suggestions:
> 
> > You have, basically, two possibilities:
> > 
> > 1) Add the module_# as submodules:
> >   http://www.kernel.org/pub/software/scm/git/docs/git-submodule.html
> >   http://git.or.cz/gitwiki/GitSubmoduleTutorial
> > 2) Add the submodules as subtrees (as gitk and git-gui in git.git)
> >   http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html
> 
> I think the latter is specifically what you want.

I got stuck in that process, as the new repo thinks all the files from
the sub-folders belong to the top-folder: After this process, there are
a lot of files from subfolder include in the "new" top-level folder.

--8<--- git-join.sh
#!/bin/sh

export MODS
MODS="include fnc"
MODS="$MODS i00f000 i99f000"
MODS="$MODS l00m000 l01f000 l02f000 l03f000 l06f000 l90z000"
MODS="$MODS rpt"
MODS="$MODS leerpl mutbev prtabel tabellen zoomen"

echo "Creating merge environment"
rm -rf new
mkdir new
cd new

echo "Recovering original repo's"
tbz -s -x ../lep4gl-git

echo "Initializing new repo"
git init

for mod in $MODS ; do
    echo "Merging $mod ..."
    git remote add -f B$mod $mod
    git merge -s ours --no-commit B$mod/master
    git read-tree --prefix=$mod/ -u B$mod/master
    git commit -m "Merge $mod as our subdirectory"
    git pull -s subtree B$mod master
    done

echo Done
-->8---



-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
