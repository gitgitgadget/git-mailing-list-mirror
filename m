Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A8E1201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 10:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbdBTKVr (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 05:21:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:63456 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbdBTKVU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 05:21:20 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaqqY-1cuXsk2kVW-00KTGc; Mon, 20
 Feb 2017 11:21:00 +0100
Date:   Fri, 17 Feb 2017 18:50:00 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Josh Triplett <josh@joshtriplett.org>
cc:     git@vger.kernel.org
Subject: Re: Cross-referencing the Git mailing list archive with their
 corresponding commits in `pu`
In-Reply-To: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
Message-ID: <alpine.DEB.2.20.1702171841450.3496@virtualbox>
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NfiGRuD6H/CbdFTLwOgl6PBmH9NEcnzeJKFRBUhAgCIl+BSXyHl
 3sMS1gKJj3/GUSu3nyiUT3PrPuwqdKC6TNyj4Q03LULNSwbQal7pugTMbgRFiOv0ekrs8Ld
 JPp5aXDtlH0AIwuqTUdSzwIgxwK1TZgnFE9UdXWDJkpNeDQTpp2MR/QgnPKPHsfiHCVwtVF
 PlyFMQVgYGkkLicBSuvow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r7P1Yduj9Iw=:eoZD6vgHc3RVyzxAQu8PoD
 ykEclG3pd3kijCPCW283ulA0fZei4KoxIT5egQjrDemRP4BN58tdTBjrgwuMglnbZWhhaRXBV
 JDekRm0YDrgmrwUe/6ZaB54GnXBp9Lv15PNwhKhtbBqc7dfcb03uTd3UHKLiSa7UFgjVVhXSX
 F4ZawyfPVqSqS50snQG/ylgVzp98n2EOi25HCjWM4ViWwzXnZawfHLvNbxN17DGCER9TmqJYC
 WT4gUR1J2SsPT7d4mXSobIRW6EocTax55tb1PEgYbmJacYL0FS2nGx1vPqTeKKIaifQ5OyRL/
 4+XkUEp6pxkVLozYlZ9MGuotwecxsziQGD8P4lePsFn0MqB28Bk0f5ABuvNvq2wYaDGl4AMeb
 kk+yChk8LTgDmtbxfiUS2QdZw3DuHEf+kO09WdMe6YLnW9GodSaBHGEEhYnxj7jb6CnQZK1bA
 +X/yeHO3Ylzc91cIo8q/fcoZBtqj2jPBWB3JihK2Vd1T8OAWGcUlcWGW1zyrSIzTyYFkWyuh8
 GvwgOQD9731zXmoAuUegKUli9VePqNL00NRYki4uqwXzWmivXwWtBoMvQgyo8sSQfp0NywIvO
 IjuV8VKAYo/lFLiP2I5EUNgtjU5ja36ARI3bzUDE2hCdYRx2fnfKLv8Mrcxr2G+Z4AuBl7Co/
 /7XJ0O0Mz/emxsOaku4xEKL/v72gHQLyZMUHERZ0gWVkzJFvK+DzmQeqFsiE7ioIMr7sAC428
 L1LYqRJi1YZzRHiVrJYTR0EINJmLSeA+o3z7xO8svxz6tkaBle+EOyj/HTkIQfDot0/93xJgw
 /4OleIM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Josh,

On Mon, 6 Feb 2017, Johannes Schindelin wrote:

> as discussed at the GitMerge, I am trying to come up with tooling that
> will allow for substantially less tedious navigation between the local
> repository, the mailing list, and what ends up in the `pu` branch.

I found a little bit more time last Friday to play with the
cross-correlation between commits in `pu` and mails in
public-inbox/git.git and it is worse than I previously assumed.

Just as a reminder: my plan was to start developing tools that will
ultimately help me as well as other contributors with the arcane mailing
list model of patch submission. And my first target was the seemingly
simple task of figuring out the mail corresponding to any given commit in
`pu` (i.e. the mail that contained the patch, and whose mail thread is
hence expected to have the entire patch review, and to which I would be
expected to respond if I find a problem with that commit).

And since it is all-too-common that the oneline is adjusted before
applying the patch, the Subject:/oneline pair is not a good candidate to
find matches.

My next best guess was that the author date would not be touched, so the
pair of Date: and authordate should make a good candidate.

My initial finding was that this is not without problems, as some mails
were sent with identical Date: lines (most likely due to bugs in the
tools, e.g. the well-known and already fixed bug in git-am, and hence
git-rebase, where it would apply all patches using the first patch's
author date), and worse: some of those mails contained actual patch series
that actually made it into Git's commit history.

But those are not the only problems.

For starters, I tried to cross-correlate *just* the commits that entered
`pu` since one week ago (git rev-list --since=1.week.ago upstream/pu) with
mails of the past month in the mailing list archive.

One obvious caveat is that RFC 2822 is ambiguous when it comes to the date
format. While it seems nice that you *can* write single-digit day numbers
as single digit if you want, or with a leading zero, or with a leading
space, it makes it impossible to get away with exact matching. I did not
really want to complicate my research by parsing the dates and normalizing
them to epoch + timezone, also because I wanted results quick, so I simply
normalized the dates to have leading zeroes for single-digit day numbers,
that seems to work for the moment).

The first category of problematic commits come as no surprise: merges. We
do not even have a way to represent them as mails. I simply excluded them
from the remainder of this study.

The second category should not be all that surprising, too: Junio often
adjusts the release notes without sending those patches out for review.
Those commits are:

363588f (### match next, Junio C Hamano 2017-02-17)
2076907 (Git 2.12-rc2, Junio C Hamano 2017-02-17)
076c053 (Hopefully the final batch of mini-topics before the final,
	Junio C Hamano 2017-02-16)
ae86372 (Revert "reset: add an example of how to split a commit into two",
	Junio C Hamano 2017-02-16)
d09b692 (A bit more for -rc2, Junio C Hamano 2017-02-15)

There is a third category, and this one *does* come as a surprise to me.
It appears that at least *some* patches' Date: lines are either ignored or
overridden or changed on their way from the mailing list into Git's commit
history. There was only one commit in that commit range:

3c0cb0c (read_loose_refs(): read refs using resolve_ref_recursively(),
	Michael Haggerty 2017-02-09)

This one was committed with an author date "Thu, 09 Feb 2017 21:53:52
+0100" but it appears that there was no mail sent to the Git mailing list
with that particular Date: header and the *actual* mail containing the
patch was sent with a Date: header "Fri, 10 Feb 2017 12:16:19 +0100"
(Message-ID:
d8e906d969700acbca8dc717673d0a9cdc910f62.1486724698.git.mhagger@alum.mit.edu).

It is labor-intensive, but possible to find the correlation manually in
this case because the Subject: line has been left intact.

However, this points to a serious problem with my approach: I try to
re-create information that is actually not available (which Message-ID
corresponds to a given commit name). Since that information is not
available, it is quite possible that this information cannot be retrieved
accurately (and Michael's commit demonstrates that this is not a merely
theoretic consideration). I do not know that I can fix this on my side.

> P.S.: I used public-inbox.org links instead of commit references to the
> Git repository containing the mailing list archive, because the format
> of said Git repository is so unfavorable that it was determined very
> quickly in a discussion between Patrick Reynolds (GitHub) and myself
> that it would put totally undue burden on GitHub to mirror it there
> (compare also Carlos Nieto's talk at GitMerge titled "Top Ten Worst
> Repositories to host on GitHub").

Since the main problem was the unfavorable commit history structure, I
*think* that it may be possible to auto-process public-inbox.org/git.git
into a frequently-rewritten branch that squashes all commits from past
years into single, per-year commits (and the same for recent months, the
past days, and a single commit accumulating the current day's commits) and
that that may solve the problematic structure. The blob names would remain
identical to what is on public-inbox, of course.

Ciao,
Johannes

P.S.: The *mini* scripts I used were

cat generate-date-index.sh <<\EOF
#! /bin/sh

cd public-inbox-git

since_commit="$1"
test -n "$since_commit" ||
since_commit=$(git rev-list --since=1.month.ago master --reverse | head -n 1)
for sha1 in $(git diff --raw --no-abbrev $since_commit..master | cut -f 4 -d \ )
do
	printf '%s\t%s\n' \
		"$(git cat-file blob $sha1 |
		sed -n \
			-e 's/^Date:[ 	]*\([^,]*,\) *\([1-9] .*\)/\1 0\2/p' \
			-e 's/^Date:[ 	]*\([^,]*,\) *\([0-9][0-9] .*\)/\1 \2/p' \
			-e '/^$/q')" \
		$sha1
done | less -S
EOF

to generate a file date-index.txt containing "date\tblob" pairs where the blob
refers to the SHA-1 of the mail in public-inbox/git.git, and

cat >match-pu.sh <<\EOF
#! /bin/sh

for commit in $(git rev-list --since=1.week.ago --no-merges upstream/pu)
do
	date="$(git show -s --format=%aD $commit |
		sed 's/, \([1-9]\) /, 0\1 /')" # fix up Git's idea of RFC 2822
	mail_id=$(grep "^$date" date-index.txt | sed 's/.*	//')
	case "$mail_id" in
	'')
		echo "ERROR: no mail found for $commit (date $date)" >&2
		git show -s --pretty='tformat:%h (%s, %an %ad)' --date=short \
			$commit >&2
		;;
	*' '*)
		echo "ERROR: multiple candidates found for $commit ($mail_id)" >&2
		;;
	*)
		echo "$date $mail_id"
		;;
	esac
done
EOF

to try to match the author dates with the ones in date-index.txt. The
obvious next improvement is to list also Message-ID in date-index.txt.
