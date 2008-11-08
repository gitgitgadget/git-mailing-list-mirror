From: Jakub Narebski <jnareb@gmail.com>
Subject: How it was at GitTogether'08 ?
Date: Sat, 8 Nov 2008 02:54:52 +0100
Message-ID: <200811080254.53202.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 02:56:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyd42-0001uC-CD
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 02:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbYKHBzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 20:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbYKHBzG
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 20:55:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:19579 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbYKHBzC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 20:55:02 -0500
Received: by nf-out-0910.google.com with SMTP id d3so771358nfc.21
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 17:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Igh4h0Jxgw7JTPdNTQjD1eVg1Omy+ijgEACaI+ZJaJw=;
        b=n6BvAxKAq6v/Ltq8S1nsGm76IP3rYwZyFEVdFSGcyAjBELM/Z73OYmTgIqRIK9lg89
         PXIqIEIFOi5HhpWgPB5qfnidThjZsa8mihLduDNdQ48tAqFuawKlYKF/FJTKmFWDiJa1
         sMXSaoVyTODmDpHKEoIdPSKwj5ax6Od1pCFJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=aAxomub+H9/p96BLwt59szLhGas9ivMwYOaSJRbHbQzdn3NoilMsRp8MGaBOhMPZub
         /HLHi+QNtRPrKdowjiizeV6Avv8QMNXu//ZNROqk4Me9zKzFuiyj358pXyjUjmB4ACh8
         KqsoPc2fwfspzFrRcdUfRMRsi0aLfAB+jH8ps=
Received: by 10.210.29.11 with SMTP id c11mr961349ebc.165.1226109300185;
        Fri, 07 Nov 2008 17:55:00 -0800 (PST)
Received: from ?192.168.1.11? (abwx16.neoplus.adsl.tpnet.pl [83.8.247.16])
        by mx.google.com with ESMTPS id 23sm4861942eya.7.2008.11.07.17.54.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Nov 2008 17:54:58 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100371>

GitTogether 2008, which took place October 27(Mon)-29(Wed), has ended more
than week ago.  Therefore I'd like to ask you impressions (while it is still
fresh) from GitTogether, describe talks which are not described below,
correct wrong information in below, etc.

Please reply to this email while GitTogether is on front of your mind...


Talks at GitTogether 2008
=========================

Mon, Oct 27, 2008
-----------------
* Dscho: Contributing with Git
  http://www.youtube.com/watch?v=j45cs5_nY2k

* Junio: Git Chronicle

  blog: Junio went though a sort of statistical history of the Git project
  that was fascinating (turns out there are still about 220 lines of code
  still around from Linus original first commit).

  http://userweb.kernel.org/~junio/200810-Chron.pdf

* Jeff: Helping new contributors join

* Petr: Renames Again and Again and Again

  IRC: detection of wholesame renames of directories (WIP) and '--follow'
  limitation were mentioned, but outcome is unclear; pasky plans to hack
  together some patch implementing explicit renames hinting

* Sam: GitTorrent

  IRC: briefly the history if GitTorrent: way underannounced, not completely
  finished, GTP/0.1 was "published" long ago. There was a GSoC project this
  year, mentored by mugwump. Unfortunately, the student turned out to be a
  procrastinator or something, and this project was mainly pushed forward by
  the mentor. Now after the summer, mugwump took a step back and analyzed
  the protocol with all the experience won from implementing a large part of
  it. Turns out that a lot of the stuff was not really necessary, but copied
  because the BitTorrent protocol had it all.  So, plan is to really strip
  down GTP.  And not have a separate protocol for GitTorrent, but rather
  have it as part of git-daemon. [...] Turns out that warthog9 had a few
  really important things to say that should end up (at least in the 2nd
  version) in having a more robust discovery/exchange.

  http://utsl.gen.nz/talks/gittorrent/start.html

* Tom: GitHub

  IRC: a tour, some history, and insight into how it works; some nice
  gimmicks, such as "gist" (a git backed pastebin), or like network graphs
  (look graphically at forks of a repository).

  blog: Tom got to demonstrate GitHub and Gist to the group, most of whom
  are very command line oriented and had not used either before.

* Shawn: JGit

* Scott: Linkable Library

  blog: got to talk about the need for a linkable git library

  http://thread.gmane.org/gmane.comp.version-control.git/99608

* Sam: perl.git

  blog: Sam demonstrated the work he went through to import 20 years of Perl
  history into the git repository that the Perl team is just now finishing
  transitioning to from Perforce.

  http://utsl.gen.nz/talks/perl-history/slides/


Tue, Oct 28, 2008
-----------------
* Shawn: Pack v4

  IRC: Shawn gave a pretty good summary of packv4, and he said what are the
  major blocks: we need a refactoring of the tree walker first, and then it
  would add a pretty complex heap of code to make use of the packv4 format
  for tree walking.  Main concern was _not_ the size of pack (for spearce at
  least), but the speed of rev-list parsing with path delimiters [...] The
  tree walking needs a different interface. (Path-delimiting must be a part
  of it, not an afterthought. Mode filtering must be a part of it, not an
  afterthought.)  Estimations for packv4: 10% decrease in size, 25% increase
  in speed.  [...] reworking packv4 to do it for OBJ_BLOB too (and the
  obvious path to speed-optimize git grep -w) has not been touched at all.

* Jeff: What needs refactoring?

* David Brown: Life with Git
  http://www.davidb.org/git/git-corp.pdf

* Lighting Round Talks
  - Scott: iGitHub - git daemon and repository browser on the iPhone
  - Jeff: Portability autobuilders
  - Petr: Quick TopGit introduction, problems, future plans

  IRC: iGitHub - its a tiny app you run on your iphone to make your iphone
  act as a git server/client. since apple doesn't let you tether your laptop
  through your iphone to get wireless internet you can instead push a
  repository to the iphone via the laptop, then push from there to the
  world, or fetch from the world to the iphone, then from the iphone to the
  laptop. it also has a small history browser and stuff built in.

* Jeffrey Altman: Discussion with OpenAFS

  IRC: was about them trying to convert their franken-CVS repo to
  Git. Basically, they use CVS, but have a layer on top of it that logically
  combines two related commits into a single "delta", and they want to
  preseve those as single git commits to the extent possible (sometimes it
  is not possible because of conflicts). They are looking for ways to script
  the conversion.

  The OpenAFS guys were also interested in helping with libgit and windows
  TortoiseGit work (separate conversation).

* Tim: Git as a Media Repository
  http://www.thousandparsec.net/~tim/media+git.pdf

* Petr: Git UI

  IRC: pasky talked a little bit about what he still misses in git.git CLI:
  commit -m piping through fmt; the "reset and checkout" vs "switch, reset
  and restore" paradigm; add vs stage; a bit about submodules [...] and
  spent most of the time in a bikeshed argument about
  add/rm/stage/unstage/staged/revert/restore/switch/. [...] Basically, reset
  and checkout sucks and has chaotic behaviour with various switches and
  argument combinations (files given vs not given etc.) So in ideal world,
  reset and checkout might've been deprecated and instead, switch, restore
  and unstage would be introduced... but that's not gonna happen.

  blog: The other important, highly visual thing that was discussed, and
  even a few patches are already in for, is for little improvements to the
  UI. The full planning document is on Gist, but already things like making
  use of the term 'stage' for things that happen in the index (such as using
  "git diff --staged" instead of "git diff --cached") is being worked
  on. I'm excited that staging files may soon be done via "git stage"
  rather-than/in-addition-to "git add". This is nice for new users who often
  have a hard time seeing why you have to keep "git add"ing to stage your
  changes.

  http://pasky.or.cz/~pasky/cp/gittogether-ui.sxi
  http://gist.github.com/20818

  http://thread.gmane.org/gmane.comp.version-control.git/99572
  http://thread.gmane.org/gmane.comp.version-control.git/99541

* Steven: Life with git-svn


Wed, Oct 29, 2008
-----------------
* Shawn: Bundle Project

  IRC: Gerrit is issue tracker / code review tool, which takes full bundles
  and moves them around, and only when it was reviewed, it is actually
  applied.

  http://android.git.kernel.org/?p=tools/gerrit.git

* Discussion on notes

* Petr: introduce the secret pickaxe project
  http://repo.or.cz/w/giddy.git

* Petr: Git in Pharma Corp
  http://pasky.or.cz/~pasky/cp/gittogether-novartis.sxi
  http://pasky.or.cz/g/gitweb.cgi?p=templatedemo.git;a=summary

* Tim: Large media in Git (Repeat)

  IRC: Large = 100M and more (e.g. audio or video assets for a game). the
  idea was that you would have shallow _and_ lazy clones. There was not much
  discussion about implementation details, though; except that there should
  be a mode where blobs are _not_ fetched, and that every non-blob has to be
  local.

  IRC: Tim Ansell (mithro) of Thousand Parsec still uses SVN for this
  because he can checkout just one file, edit it, and push it
  back. Basically he wants to clone the metadata (commits and trees and
  small blobs) and have large blobs (e.g. >25 MB or some limit) kept on the
  origin, lazily fetched over a git transport on demand. Tim started to work
  up a prototype using HTTP. folks thought the idea showed promise, but we
  need to see code and the impacts it has and where it breaks down to really
  understand if it is worth doing or not.

  blog: Tim talked about something that I think will be one of the next huge
  (highly visible) changes in Git you\u2019re likely to see in the next year
  \u2013 handling large meda well, and being able to do narrow and sparse
  clones, (and shallow clones better). This means being able to clone part
  of a Git repository, such as just the last revision (shallow), just the
  \u2018lib\u2019 directory (narrow) or just a single file
  (sparse). Importantly, you would be able to see the history of everything
  still (it would download the commit and tree objects, which are generally
  small, but not the larger blobs), and you would be able to do pushes back
  (which shallow clones can\u2019t currently do).

  http://www.thousandparsec.net/~tim/media+git.pdf  

* JH: $$$ discussion

  IRC: It was about the Google Summer of Code 2008 mentor money. It was
  decided (given most of the mentors were there) to use it to help a few
  folks cover their travel expenses to the GitTogether. Most folks actually
  had their costs covered by their employer (yay for some big companies!)
  but a few paid out of pocket, so we are helping them defray it a bit. and
  the rest is being used to order and distribute some git t-shirts.

* Sam: Git as a DB Backend

  IRC: mugwump had this idea of running a sql sort of database in git, using
  the git logs as a way to implement an ACID complaint database. to be
  honest i was busy reading email or something and didn't pay much attention
  to his talk, but folks seemed to think it was an abuse of git

* Petr: GUI Even a Designer Uses

  IRC: it was rather short and ambiguous; mostly arguing whether to and in
  what language/toolkit to reimplement git-gui


Sources:
========
* http://git.or.cz/gitwiki/GitTogether
* http://google-opensource.blogspot.com/2008/11/gittogether-08.html
* http://github.com/blog/196-gittogether-2008
* Calendar ID: amj5rbmljs66k9rtibs34kc2c8@group.calendar.google.com
* http://colabti.org/irclogger/irclogger_log_search/git
  #git channel on irc.freenode.org


-- 
Jakub Narebski
