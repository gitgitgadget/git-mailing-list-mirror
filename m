Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60FE71F404
	for <e@80x24.org>; Wed,  4 Apr 2018 16:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeDDQgC (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 12:36:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:47271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeDDQgB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 12:36:01 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MJjUO-1f2evT3fhE-0019sG for <git@vger.kernel.org>; Wed, 04 Apr 2018 18:35:59
 +0200
Date:   Wed, 4 Apr 2018 18:35:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
Subject: commit -> public-inbox link helper
Message-ID: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n2NCHp2X1OZ/HzALoHLYM2HPfT6Y7h/kxN8iZ/9lCtdCEIMqHZQ
 86AxbBQ8SOjBI9ETCeK1M06b7Vd09fRdhGjW3eIU/9iG1LjnyWCWLlmGKq4PhFg+96ffWDe
 us3MTunpUrpOLqwaiMnxUYqGY+wRsDKdoPYdbbqiR2n8xnpvzWV62LLpxFTXpH2dEe95TLp
 gyDtUlCTMUDqCkA8Hlbaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:77JlIbxHuTk=:TbZNKz75k0R4EMTe7enleV
 LCcNoTs2f/ALZnXCj5vEfCvG2wXXi4HEsv5WPyGZqGHgLruqgE1ZqXUhuFKAo1yvP9hzBJ1ve
 TNUAB/hQi7Lz7QUvUZMpp1GPKYveP/YJkVWVPm10gPP/7wS8OyBzK9j7MxinlSC4/JkvNq9k8
 gWX8BrwVNSwGLBvMxRri5qFrZHCDPRUDhLSPzY1Q6OBWZ/Ikp5pUWHUO9h9YmY0U/aoabWLoH
 O9cUQkIZ8shXquHs0fqE6p5GyTZKXLmvbMfB3f3FGdOpVT0C9tv6gYPYvHMlFNxIFjb8+vUlQ
 HTy3WBYawVpZi+SM9jwylJ29YqeXokZiziRTMupZVi0NjsR+SSDTahzh3OywMDQyGac7Q0kh/
 ZX2D6nkCSakQ4UmaTd7I9DuzNXvGNuqx8vN7CS8up80DlnOxhIIzE3RkLBWsxg7PJCB6F1CAI
 /mf+cxFooR+0rLMhYtq9WJyKXFKq/phAyj01wpI8gn1P81aA3QtJk2eUYUYUiO7rbxSF+u1J9
 SBlj9XfLrdYRRJMsS6EnOemoAaGI1Pzt2vZ2aOLfx6F97aDDHXGXyayEYXJ6NJDp1MVGoAYLO
 xIIwj3ERjpX0j5mIwX2jgOQqL0WeaQ47FiIyTtRJAubnSyVSa3RYwojNK01fNZZkItJ1f126Z
 6Bv47PsfrggcE8eIx87/2sNX0IL18MmtrrW5gzsaMvb01jrsLsmjxU4kfKqOr9JzwX6NCVEme
 8R5Lv1PKtbv5tWD+1GO0RA6J1EHEEHR27LxB3KOs/uBsO7VohXEJUzgmUyYp+nyz82w3+ynzk
 L4TUqIjB0HlZUvOShPHSftrzHSJlmTS/1/QUDjRjE0oA4wOyN8m/GcHE+hvamvbXGYSh9ks
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi team,

I found myself in dear need to quickly look up mails in the public-inbox
mail archive corresponding to any given commit in git.git. Some time ago,
I wrote a shell script to help me with that, and I found myself using it a
couple of times, so I think it might be useful for others, too.

This script (I call it lookup-commit.sh) needs to be dropped into a *bare*
clone of http://public-inbox.org/git, and called with its absolute or
relative path from a git.git worktree, e.g.

	~/public-inbox-git.git/lookup-commit.sh \
		fea16b47b603e7e4fa7fca198bd49229c0e5da3d

This will take a while initially, or when the `master` branch of the
public-inbox mirror was updated, as it will generate two files with
plain-text mappings.

In its default mode, it will print the Message-ID of the mail (if found).

With --open, it opens the mail in a browser (macOS support is missing,
mainly because I cannot test: just add an `open` alternative to
`xdg-open`).

With --reply, it puts the mail into the `from-public-inbox` folder of a
maildir-formatted ~/Mail/, so it is pretty specific to my setup here.

Note: the way mails are matched is by timestamp. In practice, this works
amazingly often (although not always, I reported findings short after
GitMerge 2017). My plan was to work on this when/as needed.

Note also: the script is very much in a 'works-for-me' state, and I could
imagine that others might want to modify it to their needs. I would be
delighted if somebody would take custody of it (as in: start a repository
on GitHub, adding a README.md, adding a config setting to point to the
location of the public-inbox mirror without having to copy the script,
adding an option to install an alias to run the script, etc).

And now, without further ado, here it is, the script, in its current glory:

-- snipsnap --
#!/bin/sh

# This is a very simple helper to assist with finding the mail (if any)
# corresponding to a given commit in git.git.

die () {
	echo "$*" >&2
	exit 1
}

mode=print
while case "$1" in
--open) mode=open;;
--reply) mode=reply;;
-*) die "Unknown option: $1";;
*) break;;
esac; do shift; done

test $# = 1 ||
die "Usage: $0 ( [--open] | [--reply] ) <commit>"

test reply != $mode ||
test -d "$HOME/Mail" ||
die "Need $HOME/Mail to reply"

commit="$1"
tae="$(git show -s --format='%at %an <%ae>' "$1")" ||
die "Could not get Timestamp/Author/Email triplet from $1"

# We try to match the timestamp first; the author name and author email are
# not as reliable: they might have been overridden via a "From:" line in the
# mail's body
timestamp=${tae%% *}

cd "$(dirname "$0")" ||
die "Could not cd to the public-inbox directory"

git rev-parse --quiet --verify \
	b60d038730d2c2bb8ab2b48c117db917ad529cf7 >/dev/null 2>&1 ||
die "Not a public-inbox directory: $(pwd)"

head="$(git rev-parse --verify master)" ||
die "Could not determine tip of master"

prevhead=
test ! -f map.latest-rev ||
prevhead="$(cat map.latest-rev)"

if test $head != "$prevhead"
then
	range=${prevhead:+$prevhead..}$head
	echo "Inserting records for $range" >&2
	git log --format="%at %h %an <%ae>" $range >map.txt.add ||
	die "Could not enumerate $range"

	cat map.txt map.txt.add 2>/dev/null | sort -n >map.txt.new &&
	mv -f map.txt.new map.txt ||
	die "Could not insert new records"

	echo $head >map.latest-rev
fi

lines="$(grep "^$timestamp " <map.txt)"
if test 1 != $(echo "$lines" | wc -l)
then
	test -n "$lines" ||
	die "No records found for timestamp $timestamp"

	echo "Multiple records found:"

	for h in $(echo "$lines" | cut -d ' ' -f 2)
	do
		git show -s --format="%nOn %ad, %an <%ae> sent" $h
		git show $h |
		sed -n -e 's/^+Message-Id: <\(.*\)>/\1/ip' \
			-e 's/^+Subject: //ip'
	done

	exit 1
fi

# We found exactly one record: print the message ID
h=${lines#$timestamp }
h=${h%% *}
messageid="$(git show $h | sed -n 's/^+Message-Id: <\(.*\)>/\1/ip')" ||
die "Could not determine Message-Id from $h"

case $mode in
print) echo $messageid;;
open)
	url=https://public-inbox.org/git/$messageid
	case "$(uname -s)" in
	Linux) xdg-open "$url";;
	MINGW*|MSYS*) start "$url";;
	*) die "Need to learn how to open URLs on $(uname -s)";;
	esac
	;;
reply)
	mkdir -p "$HOME/Mail/from-public-inbox/new" &&
	mkdir -p "$HOME/Mail/from-public-inbox/cur" &&
	mkdir -p "$HOME/Mail/from-public-inbox/tmp" ||
	die "Could not set up mail folder 'from-public-inbox'"

	path=$(git diff --name-only $h^!) &&
	mail="$(printf "%s_%09d.%s:2," $(date +%s.%N) $$ $(hostname -f))"
&&
	git show $h:$path >"$HOME/Mail/from-public-inbox/new/$mail" ||
	die "Could not write mail"
	;;
*)
	die "Unhandled mode: $mode"
	;;
esac
