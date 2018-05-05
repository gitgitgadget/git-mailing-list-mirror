Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B38B200B9
	for <e@80x24.org>; Sat,  5 May 2018 20:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751736AbeEEUY3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 16:24:29 -0400
Received: from mout-xforward.gmx.net ([82.165.159.41]:34747 "EHLO
        mout-xforward.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751230AbeEEUY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 16:24:28 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgGDK-1f0GOb1oZS-00Nl07; Sat, 05
 May 2018 22:24:19 +0200
Date:   Sat, 5 May 2018 22:24:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <CABPp-BERh1FGzEJSu+6Z0aGC3dJxx+P=9xwdCCsPgnG8jWvQMg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805052220360.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com> <nycvar.QRO.7.76.6.1805032224150.77@tvgsbejvaqbjf.bet>
 <850f1ad6-752d-85ae-ebad-feae09a76c54@ramsayjones.plus.com> <nycvar.QRO.7.76.6.1805040829390.77@tvgsbejvaqbjf.bet> <CABPp-BERh1FGzEJSu+6Z0aGC3dJxx+P=9xwdCCsPgnG8jWvQMg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zjnwZxYAxhDAQe7fOQEDZTVASklgfSoQ0h67p0UOAARwC8NuKGS
 EguKgTqVv0l5flzx2OxvGjyaS7hO5QLdNKDbWEPJZh75JW4piv+YAOQ3MJiIoW+wc2mlpAV
 xxF+baE7HpBNMhlExzVp1zH4Y/aXt6G82vWCegsJVv1AXiohpi4lxJefWGVzn+eV7jAp9zU
 LVAG+oI+XpG6Lb6G7H9bg==
X-UI-Out-Filterresults: junk:10;V01:K0:hZq6FVK+cr4=:ek7+EptzWcu9ZQ5PkySPLnty
 fnNCHmA9QgMNIfBcxsZkeCnNfz/13cwzettrglonYJlWQLhFCT67UNNaYfLTKpa5cjSuyBs2L
 TFW4/hOCFwQGETcQDNxUDaqNSU+IqGfEHNbaguSMpYj4eh09sWY15iZnTVv4Vqbxzjnoj98cG
 kl8nOQveXUIFjfmA7i348c4QPPxovKTs7qWP62vZmcHvOiT2yhXVsDvuBBOYbZnisr+hV6l4Q
 WpV1YUTsPOy0pJFeNM6CkoeiAsxYtYjEoaO8cmDe8HYs9G402Y+YeUUcA1vy56M+Eu61SUkAA
 6amvNc+ahAIPxc8zYmHvKvhznTtrXGOprPPbWOPehSUpaOQAks2O+ox/5jBTU/CynBzsz0Rec
 Sc9HHs/1CgFZMDuO42LMM+gHaV2Dm5lzGilLVGPWqpZXjDJZDxXFKVTrNiCcuMlujTLHen6gC
 PKLBBgzRE0CrRKqNMeVQ1vDRGZeOq4WXccoOwm6mPgiVfOZnwJm3vodvu229qhbP4n5Fi0I1Z
 bQithppbt5akC8Z6xR8x9rXSNGmITkN6/O1AWh9JxkT5rzPIHHi20kFKbWIglHoERcVxUUE4h
 Cpu//DW2gYswwXZqj9FlFxV+y2pRiekAaAOEdIOTpJc6LG/E8Gucgb9IPTnnjtGqi8uE50I6a
 4L6q2vYz32wuOPmmZP+G7611lIAilW01o67bJ2oostgiyBmM99pMrrHY0QeMiDDlXKsKxh+d8
 puUmHjj9Tt2wr3qlnbPGYU/bRk8zrhXYkYp0Cy3s1rjEGcxDyDSnnzCbc3OBbpXbLeFzxonIS
 GWZlfUd3A7wHlaweW5JteGCwPvS4uGYmEY0V3IYtvveY3qTyYiko1ZitptMxztOfXKsHsuH4E
 PUi0fF5I3+PVN3BahPaON4tWc7RvQYUaEAWLksM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 4 May 2018, Elijah Newren wrote:

> On Thu, May 3, 2018 at 11:40 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > I actually have a hacky script to fixup commits in a patch series. It lets
> > me stage part of the current changes, then figures out which of the
> > commits' changes overlap with the staged changed. If there is only one
> > commit, it automatically commits with --fixup, otherwise it lets me choose
> > which one I want to fixup (giving me the list of candidates).
> 
> Ooh, interesting.  Are you willing to share said hacky script by chance?

It is part of a real huge hacky script of pretty much all things I add as
aliases, so I extracted the relevant part for you:

-- snip --
#!/bin/sh

fixup () { # [--upstream=<branch>] [--not=<tip-to-skip>]
	upstream=
	not=
	while case "$1" in
	--upstream) shift; upstream="$1";;
	--upstream=*) upstream="${1#*=}";;
	--not) shift; not="$not $1";;
	--not=*) not="$not ${1#*=}";;
	-*) die "Unknown option: $1";;
	*) break;;
	esac; do shift; done

	test $# -le 1 ||
	die "Need 0 or 1 commit"

	! git diff-index --cached --quiet --ignore-submodules HEAD -- || {
		git update-index --ignore-submodules --refresh
	        ! git diff-files --quiet --ignore-submodules -- ||
		die "No changes"

		git add -p ||
		exit
	}
	! git diff-index --cached --quiet --ignore-submodules HEAD -- ||
	die "No staged changes"

	test $# = 1 || {
		if test -z "$upstream"
		then
			upstream="$(git rev-parse --symbolic-full-name \
				HEAD@{upstream} 2> /dev/null)" &&
			test "$(git rev-parse HEAD)" != \
				"$(git rev-parse $upstream)" ||
			upstream=origin/master
		fi

		revs="$(git rev-list $upstream.. --not $not --)" ||
		die "Could not get commits between $upstream and HEAD"

		test -n "$revs" ||
		die "No commits between $upstream and HEAD"

		while count=$(test -z "$revs" && echo 0 || echo "$revs" | wc -l | tr -dc 0-9) &&
			test $count -gt 1
		do
			printf '\nMultiple candidates:\n'
			echo $revs | xargs git log --no-walk --oneline | cat -n

			read input
			case "$input" in
			[0-9]|[0-9][0-9]|[0-9][0-9][0-9])
				revs="$(echo "$revs" | sed -n "${input}p")"
				count=1
				break
				;;
			h|hh)
				revs=$(history_of_staged_changes $upstream..)
				continue
				;;
			hhhh)
				history_of_staged_changes -p $upstream..
				continue
				;;
			p)
				git log -p --no-walk $revs
				continue
				;;
			[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f])
				revs=$input
				continue
			esac
			revs="$(git rev-list --no-walk --grep="$input" $revs)"
		done

		test $count = 1 ||
		die "No commit given"

		set $revs
	}

	git commit --fixup "$1"
	message="$(git show -s --format=%s%n%n%b)"
	case "$message" in
	'fixup! fixup! '*)
		message="${message#fixup! }"
		message="${message#fixup! }"
		message="${message#fixup! }"
		git commit --amend -m "fixup! $message"
		;;
	esac
}

history_of_staged_changes () { # <commit-range>
	pretty=
	if test "a-p" = "a$1"
	then
		pretty=-p
		shift
	fi

	test $# -le 1 ||
	die "Usage: $0 <commit-range>"

	test $# = 1 || {
		upstream=$(git rev-parse --verify HEAD@{u} 2>/dev/null) ||
		upstream=origin/master
		set $upstream..
	}

	args=$(for file in $(git diff --no-color --cached --name-only)
		do
			for hunk in $(get_hunks --cached -- "$file")
			do
				hunk1=${hunk%:*}
				start1=${hunk1%,*}
				end1=$(($start1+${hunk1#*,}-1))
				echo "'$file:$start1-$end1'"
			done
		done)

	test -n "$args" ||
	die "No staged files!"

	eval hunk_history $pretty "$1" -- $args
}

hunk_history () { # <commit-range> -- <file>:<start>[-<end>]...
	pretty=
	if test "a-p" = "a$1"
	then
		pretty=t
		shift
	fi

	test $# -ge 3 && test a-- = "a$2" ||
	die "Usage: $0 <commit-range> -- <file>:<start>[-<end>]..."

	range="$1"
	shift; shift

	files="$(for arg
		do
			echo "'${arg%:*}'"
		done)"

	for commit in $(eval git rev-list --topo-order "$range" -- $files)
	do
		if test -z "$lines"
		then
			lines="$(echo "$*" |
				tr ' ' '\n' |
				sed "s/^/$commit /")"
		fi

		touched=
		for line in $(echo "$lines" |
				sed -n "s|^$commit ||p")
		do
			file="${line%:*}"
			curstart="${line#$file:}"
			curend="${curstart#*-}"
			curstart="${curstart%%-*}"

			diff_output=
			parentstart=$curstart
			parentend=$curend
			parents=$(git rev-list --no-walk --parents \
					$commit -- "$file" |
				cut -c 41-)
			if test -z "$parents"
			then
				touched=t
			fi

			for parent in $parents
			do
				for hunk in $(get_hunks ^$parent $commit -- \
					"$file")
				do
					hunk1=${hunk%:*}
					start1=${hunk1%,*}
					end1=$(($start1+${hunk1#*,}-1))

					hunk2=${hunk#*:}
					start2=${hunk2%,*}
					end2=$(($start2+${hunk2#*,}-1))

					if test $start2 -le $curend &&
						test $end2 -ge $curstart
					then
						touched=t
					fi

					if test $end2 -le $curstart
					then
						diff=$(($end1-$end2))
						parentstart=$(($curstart+$diff))
					elif test $start2 -le $curstart
					then
						parentstart=$start1
					fi

					if test $end2 -le $curend
					then
						diff=$(($end1-$end2))
						parentend=$(($curend+$diff))
					elif test $start2 -le $curend
					then
						parentend=$end1
					fi
				done

				if test -n "$pretty" &&
					test $curstart != $parentstart ||
					test $curend != $parentend
				then
					test -n "$(echo "$diff_output" |
						sed -n "s|^\([^ -]\[[^m]*m\)*diff --git a/$file b/||p")" ||
					diff_output="$(printf '%s%s\n' "$diff_output" \
						"$(git diff --color \
							^$parent $commit -- $file |
						sed '/^\([^ -]\[[^m]*m\)*@@ /,$d')")"
					prefix="$(git rev-parse --git-dir)"
					oldfile="${prefix}${prefix:+/}.old"
					git show $parent:$file 2>/dev/null |
					sed -n "$parentstart,${parentend}p" >$oldfile
					newfile="${prefix}${prefix:+/}.new"
					git show $commit:$file |
					sed -n "$curstart,${curend}p" >$newfile
					diff1="$(git diff --no-index --color $oldfile $newfile |
						sed '1,4d')"
					diff_output="$(printf '%s%s\n' "$diff_output" \
						"$diff1")"
				fi

				# TODO: support renames here
				prefix="$parent $file:"
				lines="$(printf '%s\n%s%s' "$lines" "$prefix" \
					"$parentstart-$parentend")"
			done
		done
		test -z "$touched" || {
			if test -z "$pretty"
			then
				echo $commit
			else
				git show --color -s $commit --
				echo "$diff_output"
			fi
		}
	done
}

# takes a commit range and a file name
# returns a list of <offset>,<count>:<offset>,<count>
get_hunks () {
	# TODO: support renames here
	git diff --no-color -U0 "$@" |
	sed -n -e 's/\([-+][0-9][0-9]*\) /\1,1 /g' \
		-e 's/^@@ -\([0-9]*,[0-9]*\) +\([0-9]*,[0-9]*\) .*/\1 \2/p' |
	fix_hunks
}

fix_hunks () {
	while read hunk1 hunk2
	do
		case $hunk1 in
		*,0)
			printf '%d,0:' $((${hunk1%,0}+1))
			;;
		*)
			printf '%s:' $hunk1
		esac
		case $hunk2 in
		*,0)
			printf '%d,0\n' $((${hunk2%,0}+1))
			;;
		*)
			printf '%s\n' $hunk2
		esac
	done
}

fixup "$@"
-- snap --

Quite a handful to read, eh? And no code comments. I always meant to
annotate it with some helpful remarks for future me, but never got around
to do that, either. These days, I would probably

1. write the whole thing based on `git log -L <line-range>:<file>`, and

2. either implement it in node.js for speed, or directly in C.

> (And as a total aside, I found your apply-from-public-inbox.sh script
> and really like it.  Thanks for making it public.)

You're welcome! I am glad it is useful to you.

Ciao,
Dscho
