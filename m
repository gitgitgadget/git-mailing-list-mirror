From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GSoC] What is status of Git's Google Summer of Code 2008 projects?
Date: Wed, 9 Jul 2008 12:18:41 +0200
Message-ID: <bd6139dc0807090318r4cbcac93s907871c6b45c03ac@mail.gmail.com>
References: <200807080227.43515.jnareb@gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Sam Vilain" <sam@vilain.net>,
	"Joshua Roys" <roysjosh@gmail.com>,
	"David Symonds" <dsymonds@gmail.com>,
	"Lea Wiemann" <LeWiemann@gmail.com>,
	"John Hawley" <warthog19@eaglescrag.net>,
	"Marek Zawirski" <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Miklos Vajna" <vmiklos@frugalware.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Stephan Beyer" <s-beyer@gmx.net>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 12:19:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGWlz-0001K9-3S
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 12:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbYGIKSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 06:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbYGIKSp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 06:18:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:23405 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbYGIKSn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 06:18:43 -0400
Received: by yx-out-2324.google.com with SMTP id 8so787439yxm.1
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5y9FE1QRhBwsmyGxVNp7TV6Yu7yMxW1+1nGXNoHZGXY=;
        b=xnr1MpmPa7rO4O1mrUZt0SlVZHh/siaHeeGIw8F5CUR6jbjSTjQYLJ798lbqz74Ow0
         rSFrnARgkB3tnjxJBoMa0uwaiqTdtea+0NCoMDcy2TVw1bBuSp8yd9nQPl36D/fXLfZ0
         H5qezUwbJ8uOkYGO1QJT79Da/RL26d7Cd55U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=rPifMHml3vZ6GUtb8m1oEeuPfqvV2/C85oL9LagV9nuzNnVITztKmkPxtk1dNI7IeF
         sCGzKOYMN5A7q02cew/n8kMbXdDjf1cFrKAzJra1pxz9j0sdsOfClFo87DJuw6+AvLHt
         dF9Cetnz3Ssy3Akk0ktMWs7vSGVUFs4P8CmyQ=
Received: by 10.142.223.20 with SMTP id v20mr2202243wfg.336.1215598721601;
        Wed, 09 Jul 2008 03:18:41 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Wed, 9 Jul 2008 03:18:41 -0700 (PDT)
In-Reply-To: <200807080227.43515.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87865>

[Once again I forgot to "reply to all", sorry Jakub ;)]

Heya,

On Tue, Jul 8, 2008 at 2:27 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> I'd very much like to have (or perhaps to wrote) some sort of interim
> progress report for Google Summer of Code 2008 projects on
> http://git.or.cz/gitwiki/SoC2008Projects.  Therefore I'd like you to
> expand and/or correct those mini-summaries below.

Would you like us to go to the wiki page and edit them ourselves, yes?
If so, I'll see about kicking up something interesting to put up there
soon.

> (It would be, I guess, good preparation for GSoC 2008 mid-term
> evaluations, which according to GSoC 2008 timeline
>  http://code.google.com/opensource/gsoc/2008/faqs.html#0.1_timeline
> are to take place July 7 -- July 14.)

Agreed.

> 2. git-statistics (?)
>
> Student: Sverre Rabbelier
> Mentor: David Symonds
>
> There were some posts about how git-statistics can be used:
>  http://thread.gmane.org/gmane.comp.version-control.git/81534
>  http://thread.gmane.org/gmane.comp.version-control.git/82027
> but it was mainly theoretical thread
>
> The git-stats repository at http://repo.or.cz/w/git-stats.git (gitweb)
> has some commits, but I don't remember any of them on git mailing list.
> Not ready?

I am not yet sure how I should send in my code for peer review.
$ git rev-list master | wc -l
151
A bunch of these patches introduce significant changes, a few are
fixes, and some are only changes to the changelog [0] which is
actually a pretty good way to see what I've been up to. Credit here
goes to David for suggesting I keep one. I am contemplating sending in
one patch per module since I've structured my code in such a way that
each module is mostly a stand-alone file that can be reviewed in
itself. I am not sure if there is any way to get such code reviewed,
most other projects had several distinct steps (e.g., modifying parts
of existing code first) they had to go through before they could write
new code. My project has been "new code" from the get go, so any
advice as to how to send this in for peer review is very welcome.

I have been working on GitStats, an attempt to gather metrics on a git
repository. For those who would like to know more about my goals,
please have a look at [1] or the more general [2]. Currently I have
quite a few metrics done, most of them are aimed at detecting whether
a commit is a bugfix. A short listing of metrics done:
* stats.py author -d: Shows file activity of a specific developer
measured in how often they made a modification to a file and total
lines added/removed (much like a diffstat, but now for a specific
developer instead of one commit).
* stats.py author -f: Shows file activity of a specific file meaured
in how often they made a modification to a file, could be extended to
also count changes like "author -d"
* stats.py branch -b: Shows which branch a specific file belongs to,
for more information on this metric see below
* stats.py commit -v: Shows all commits that are reverted by the
specified commit, will be extended to allow detection of partial
reverts
* stats.py diff -e: Shows whether two specific commits introduce the
same changes
* stats.py diff -e -n: ditto, but ignores what changes were made, only
looks at the changed lines
* stats.py diff -e -i: ditto, but inverts the comparison, instead of
comparing addition with addition and deletions with deletions, the
additions of the first diff are compared with the deletions of the
second diff, and vise versa. This way a revert is easily detected.
* stats.py index -t: Shows which commits touched the same paths as the
staged changes

I am working now on getting the 'is a bugfix' metric going, it's
sub-metrics are mostly done ('branch contains' , 'is revert', 'commit
msg matches', 'commit diff matches') with the exception of a few
simple ones ('is partial revert', 'modifies same lines') that are
already almost done. As a sneak peek into what I've been up to I'll
zoom in a bit on the development of the 'belongs to' metric.

One of the hardest things to tackle was the 'belongs to'
metric. It's goal is to determine how much a certain commit
'belongs to' a specific branch. When aggregating this
metric one can pick the best fit. This is useful when
trying to figure out if a commit was made on a maintenance
branch, and as such whether it should be marked as a 'fix'.
The definition of "belonging to" a branch was made as follows: "Each
branch that contains the target commit begins with a 'dilution' of 0,
for each merge on the way between it and the commit, increase the
dilution by one if it was not the primary parent of the merge. This
means that if a commit was "merged into" a branch instead of having
been made on that branch, it will have a higher dilution than if the
commit was made on that branch. This way, the lower the dilution, the
more a commit belongs on a branch.

The problem with this metric was not in writing it, but in
getting it to not be terribly slow on large repositories.
A few of the major problems include:
* Do not call git-rev-list on each commit, but instead
 gather all 'parentage' information beforehand. This
 avoids a lot of calls to the git binary, which is
 expensive. This simple optimization resulted in a huge
 speed increase, even on the small tests.
 With this in place it runs in under a second for the test
 repository, but the git.git repo still takes ages.
* Do not revisit commits that have already been checked
 _and had a lower or equal dilution_ in the previous
 check.
 Especially in the git.git repository this
 optimization made the algorithm go from 'unusable' to
 useful.
 With this in place it runs in under a second for recent
 commits. It takes under 20 seconds for the first commit
 in the repository.
* Keep a global memory too, that is, when multiple branches
 contain the commit, remember that we have already visited
 a commit in a global memory as well. When visiting
 a commit we check if we already visited it before but
 with a lower dilution, if so, this means that another
 branch is always going to be better than the current
 branch at this point, as such, we stop walking there.
 With this in place it still runs in under a second for
 recent commits. It takes about 7 seconds for the first
 commit in the repository.
* Do a rev-list on all branches we are interested in once,
 instead of once for each branch. In order to cut down the
 output by not listing 'subsets', the rev-lists of each
 individual branch was needed. By not doing this filtering
 a lot of time is saved.
 With this in place it still runs in under a second for
 recent commits. It takes a little over 5 seconds for the
 first commit in the repository.

The above timings were made on a rather outdated version of git.git,
after updating to today's latest the timings are as follows:

$ time stats.py branch -b e83c516331
Matching branches:
pu
next
master
maint
offcuts

real    0m6.360s
user    0m6.228s
sys     0m0.244s

It is plausible that there is no way to do this any faster
with the current approach. Walking all commits, examining
them, and calculating the dilution, all the way to the root
commit (on the git.git repo) just takes that long. The
algorithm itself is almost instant, most of the time is
spent waiting for git rev-list to return.

For a recent commit on the maint branch we can find the following
information (the -d flag was included to include 'debug' information,
so that we can see what other information was found, but left out in
the regular report):

sverre@Laptop-Sverre:~/code/git$ time stats.py branch -b 2b2828b -d
Retreiving branches that contain the commit...
Gathering information on the history...
Done.

Checking branches now:
origin/next
master
origin/maint
origin/pu
Done.

Listing found metrics:
Branch next, dilution: 2.
Branch master, dilution: 1.
Branch maint, dilution: 0.
Done.

Matching branches:
The minimal dilution is: 0
maint

real    0m6.431s
user    0m6.164s
sys     0m0.260s

>From the above one can see that master has recently merged in that
commit, but that next did not include it until after it merged in
master. In this way a commit can cascade through multiple merge, earch
merge increasing it's dilution by one.

I am very interested to hear comments on my progress so far, but also
on what is thought to be "important to work on next". It would be
awesome if a few people could give it a test drive. I recommend using
the setupRepo.py script in 'src/scripts' which will create a
metricsrepo in /tmp/ that is very well suited to experiment with the
'belongs to' metric. The testrepo also created in /tmp is better
suited to test some of the other metrics. Both repositories are used
by the testcases under 'src/t', which should all pass :). My
repository can be found at [3].

Thank you for reading, and I'm looking forward to review/comments.

[0] http://repo.or.cz/w/git-stats.git?a=blob;f=doc/changelog.txt
[1] http://alturin.googlepages.com/Use_cases.html
[2] http://alturin.googlepages.com/gsoc2008
[3] http://repo.or.cz/w/git-stats.git

--
Cheers,

Sverre Rabbelier
