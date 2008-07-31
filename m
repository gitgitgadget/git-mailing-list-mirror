From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Merging submodules (was Re: Feature suggestion: git-hist)
Date: Thu, 31 Jul 2008 09:21:04 +0200
Message-ID: <20080731092104.1a6ce8bd@pc09.procura.nl>
References: <20080730230336.GA6481@Hermes>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/ew9GL+P5M6JHlCMNXTDlwrQ"
Cc: Git List <git@vger.kernel.org>,
	Lars Noschinski <lars-2008-1@usenet.noschinski.de>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 09:22:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOSUL-0001Cr-BH
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 09:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYGaHVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 03:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbYGaHVL
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 03:21:11 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:1599 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbYGaHVK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 03:21:10 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6V7L5Lc054666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2008 09:21:05 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080730230336.GA6481@Hermes>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90902>

--MP_/ew9GL+P5M6JHlCMNXTDlwrQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 30 Jul 2008 19:03:37 -0400, Brian Gernhardt
<benji@silverinsanity.com> wrote:

> This message got eaten by a syntax error somewhere.  This is a re-send, s=
orry for any duplicate messages.
>=20
> On Jul 30, 2008, at 12:26 PM, H.Merijn Brand wrote:
>=20
> > On Wed, 30 Jul 2008 11:15:55 -0400, Brian Gernhardt
> > <benji@silverinsanity.com> wrote:
> >=20
> > > Then you do something like:
> > >=20
> > > rm -rf module_{a,b,c}/.git # Do this in a test repository, obviously.=
..
> > > git add module_a module_b module_c
> > > git commit # Needed because '-s ours' uses current HEAD, not index
> >=20
> > So far so good.
> >=20
> > > git merge --no-commit -s ours module_a/master module_b/master module_=
c/master
> >=20
> > $ git merge --no-commit -s ours fnc/master i00f000/master
> > i99f000/master include/master l00m000/master l01f000/master
> > l02f000/master l03f000/master l06f000/master l90z000/master
> > leerpl/master mutbev/master prtabel/master rpt/master tabellen/master
> > zoomen/master Automatic merge went well; stopped before committing as
> > requested
> >=20
> > > git commit --amend
> >=20
> > $ git commit --amend
> > fatal: You are in the middle of a merge -- cannot amend.
>=20
> Hm.  I did mention this was completely untested, yes?  The problem comes
> from the fact that '-s ours' wants to use HEAD, not the index.  But you
> can't amend a normal commit into a merge, apparently.  And I don't think
> you want a commit that adds the files and a commit that "does the merge"
> as two separate steps.
>=20
> Well, I don't know how to make the porcelain do this then. But the
> plumbing can definitely do it.  Hopefully someone more used to doing
> strange things like this can give a simpler recipe, but this should
> work.
>=20
> # First reset to the commit you made with all the modules added.
> vim commit-message # Create a merge message
> commit=3D$(git commit-tree HEAD: -p HEAD^ -p module_a/master -p
                                 ^^^^^^^^
had to remove that part

> 		module_b/master -p module_c/master < commit-message)
> git update-ref HEAD $commit  # Update your current ref

Some history
---
I'm aware I started at the wrong end of being a git user. I had to move
from SCCS to `something better', and at that point only git, svn, and
hq seemed to be likely candidates.

hq being python, and our company not using python, but perl, made that
an easy drop. I gave up compiling svn on HP-UX in 64bit mode after
about a week, mainly because it depended on way too many things, and
the new VCS has to run on this platform, as it is our main development
system. I got git up and running in two days (compile in less than two
hours, but then I got to chase HP-UX and 64bit oddities).

By the I knew a lot about the git source code, make files, and test
scripts, but still had no idea about the whole plumbing/porcelain
approach. The plan was to make that someone else's job.

Once it was up and running, I had to create a way to convert all our
SCCS repo's to git, so we could get started and test if it met our
needs. That part went smooth, and with a little help from Sam Villain
to get some speed into the conversions using git-fast-import, it is now
available to the public on CPAN as VCS::SCCS, with git2sccs in the
examples folder.

Using git-gui and gitk my users were enthousiastic, and they saw all
the advantages of using git over SCCS. Of course, with every change
there are a few (serious) drawbacks, but we have to live with those.

Being a perl5 porter/maintainer, I was used to p4v (perforce) and still
wonder why there are two GUI's instead of just one, and why they don't
offer the functionality I love in p4v. Not that I think perforce is
better than git, but their GUI certainly is.
---

So, back to this merging issue. Now you might understand why I have all
those `silly' questions and have (still) no good idea of what all these
commands do. (The person that were to do all that never came into the
picture). I'm learning.

I'm VERY happy and thankful for the help I get from you here, and I get
the impression that my feedback on getting git running in our somewhat
different environment to you is also appreciated.

I had to cut down my number of modules to merge, as I got an error that
the maximum number of merges was 16. I had 18.

I will now be playing with the results a bit. I have attached the
script, in case you might want to use it in documentation or examples.
For now, all the mods are hardcoded. No arguments and so on.

Again, Thanks!

$ bash git-merge-mods.sh
Re-initialize GIT repo
Initialized empty Git repository in /work/lep/4gl/.git/
Recovering original module repo's
Fetching for i00f000
remote: Counting objects: 24, done.
remote: Compressing objects: 100% (14/14), done.
remote: Total 24 (delta 9), reused 24 (delta 9)
Unpacking objects: 100% (24/24), done.
=46rom i00f000
 * [new branch]      master     -> i00f000/master
Fetching for i99f000
:
:
Receiving objects: 100% (356/356), 139.05 KiB, done.
Resolving deltas: 100% (180/180), done.
=46rom rpt
 * [new branch]      master     -> rpt/master
Removing module repo's
Adding modules
Commit
Merge
Automatic merge went well; stopped before committing as requested
Commit
=3D=3D=3D=3D=3D=3D=3D=3D=3D
53229f046c5d85d11bbd500cf04b468fd3f62c08
=3D=3D=3D=3D=3D=3D=3D=3D=3D
Update
$




--=20
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/

--MP_/ew9GL+P5M6JHlCMNXTDlwrQ
Content-Type: application/x-shellscript; name=git-merge-mods.sh
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=git-merge-mods.sh

IyEvcHJvL2xvY2FsL2Jpbi9iYXNoCgpleHBvcnQgTU9EUwpNT0RTPSJpMDBmMDAwIGk5OWYwMDAi
Ck1PRFM9IiRNT0RTIGluY2x1ZGUgZm5jIgpNT0RTPSIkTU9EUyBsMDBtMDAwIGwwMWYwMDAgbDAy
ZjAwMCBsMDNmMDAwIGwwNmYwMDAgbDkwejAwMCIKTU9EUz0iJE1PRFMgcnB0IgoKZXhwb3J0IE1T
Rz0iTWVyZ2UgYWxsIDRHTCBtb2R1bGVzIGludG8gb25lIHJlcG8iCgplY2hvICJSZS1pbml0aWFs
aXplIEdJVCByZXBvIgpybSAtcmYgLmdpdCBjb21taXQtbWVzc2FnZQpnaXQgaW5pdAoKZWNobyAi
UmVjb3ZlcmluZyBvcmlnaW5hbCBtb2R1bGUgcmVwbydzIgp0YXIgeHpmIGxlcC1naXQudGd6Cgpm
b3IgbW9kIGluICRNT0RTIDsgZG8KICAgIGVjaG8gIkZldGNoaW5nIGZvciAkbW9kIgogICAgZ2l0
IGZldGNoICRtb2QgcmVmcy9oZWFkcy8qOnJlZnMvcmVtb3Rlcy8kbW9kLyoKICAgIGRvbmUKCmVj
aG8gIlJlbW92aW5nIG1vZHVsZSByZXBvJ3MiCmZvciBtb2QgaW4gJE1PRFMgOyBkbwogICAgcm0g
LXJmICRtb2QvLmdpdAogICAgZG9uZQoKZWNobyAiQWRkaW5nIG1vZHVsZXMiCmdpdCBhZGQgJE1P
RFMgPi9kZXYvbnVsbAoKZWNobyAiQ29tbWl0IgpnaXQgY29tbWl0IC1tICIkTVNHIiA+L2Rldi9u
dWxsCgplY2hvICJNZXJnZSIKZXhwb3J0IE1PRE1BU1RFUgpmb3IgbW9kIGluICRNT0RTIDsgZG8K
ICAgIE1PRE1BU1RFUj0iJE1PRE1BU1RFUiAkbW9kL21hc3RlciIKICAgIGRvbmUKCmdpdCBtZXJn
ZSAtLW5vLWNvbW1pdCAtcyBvdXJzICRNT0RNQVNURVIKCmV4cG9ydCBQTU9ETUFTVEVSCmZvciBt
b2QgaW4gJE1PRFMgOyBkbwogICAgUE1PRE1BU1RFUj0iJFBNT0RNQVNURVIgLXAgJG1vZC9tYXN0
ZXIiCiAgICBkb25lCgplY2hvICJDb21taXQiCmVjaG8gJE1TRyA+Y29tbWl0LW1lc3NhZ2UKY29t
bWl0PSQoZ2l0IGNvbW1pdC10cmVlIEhFQUQ6ICRQTU9ETUFTVEVSIDwgY29tbWl0LW1lc3NhZ2Up
CgplY2hvID09PT09PT09PQplY2hvICRjb21taXQKZWNobyA9PT09PT09PT0KCmVjaG8gIlVwZGF0
ZSIKZ2l0IHVwZGF0ZS1yZWYgSEVBRCAkY29tbWl0Cg==

--MP_/ew9GL+P5M6JHlCMNXTDlwrQ--
