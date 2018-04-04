Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59EB1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 19:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeDDT7D (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 15:59:03 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:41381 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeDDT7C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 15:59:02 -0400
Received: by mail-pl0-f47.google.com with SMTP id bj1-v6so13165503plb.8
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UGG3kYxOrkX/29KaDG9P5mj24ADsE+IiF5Z60OndFc8=;
        b=BizXwmovOHEJm/kpgTpjJW5qQIaNcA7GGu4+WSRvZa7W3R/Y8bUtwk6m/4wlA6+ENs
         ErWS63iMihI5wo0/exSrAIjbEcDjLJAAboFeeiFZY4hkIhtAE4NqVRAOc7K7KoWuM2Yh
         4keKTIYOHpZi66q8qOLjTVwXWlQ3P6JNTB/mpTW6DhjDPh77N2laa4w0PeOP8Kdy0BF5
         A8wJPPO9ki3NCw1l3BPU6ToyLuJB5DF616tdqEnU5UZ6sSS0ltDWcVZtohqWvLGc4e+H
         pzWcznjK23NPourxhE0wj4WXIeuUvACFF8FAzy9XX0udMjnYb6es2mnjI4MN2YGyOPJ0
         RLtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UGG3kYxOrkX/29KaDG9P5mj24ADsE+IiF5Z60OndFc8=;
        b=h0JMqcI9zJZopVsVg9PqqFIjqHXzSzbNfzORirJu6iN5qnkKz/gWQIRY/F05twVzp9
         a03WN4XzCbuoVD5rgkQLBn7EGkDmfSbq8h+lk6TdMZkttICvJFI9HE/0Ym8awNR4yGn0
         GKv2hoefQEd7pN5tMovBD9uXhtFoazdRsj6o2IV7JFYzcxmDo4mrA6yxh3QDl0aDgUSz
         BPz0iOdOEIDFiBwQUoMGweyLccriNMQIppvKYDYF12IsHKEQQLiiBKBqRcL/0Rc/VDx8
         Q6H+ko/lCNes1zx5iEq+nP4gxOZ1qDMUA6edEeGvAzQXsThxX7KYqMbuZTnwvq418UxO
         o+aA==
X-Gm-Message-State: AElRT7Gc1rPIcUGZES9ADHfQoa/Xh+7YNbmy1xiXQFlR6rBclMEPNQoN
        0moxYCLMaeBm2GovFejKZspLv2dZr3HFjqJlqBs=
X-Google-Smtp-Source: AIpwx4/mAi+ZDpptvytK2xe33aodqcxo+uBkBW31F4gl45odefrt+RIUu26EdmctTYowFoE132cemxgDYbS9CWZ8iOk=
X-Received: by 10.98.211.211 with SMTP id z80mr14715790pfk.16.1522871942033;
 Wed, 04 Apr 2018 12:59:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.243.74 with HTTP; Wed, 4 Apr 2018 12:58:41 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Wed, 4 Apr 2018 15:58:41 -0400
Message-ID: <CANoM8SX_+UwSjFUgW77mW25d6Z1CxJJwbDduNqAkygGeKwru6A@mail.gmail.com>
Subject: Re: commit -> public-inbox link helper
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 4, 2018 at 12:35 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi team,
>
> I found myself in dear need to quickly look up mails in the public-inbox
> mail archive corresponding to any given commit in git.git. Some time ago,
> I wrote a shell script to help me with that, and I found myself using it a
> couple of times, so I think it might be useful for others, too.
>
> This script (I call it lookup-commit.sh) needs to be dropped into a *bare*
> clone of http://public-inbox.org/git, and called with its absolute or
> relative path from a git.git worktree, e.g.
>
>         ~/public-inbox-git.git/lookup-commit.sh \
>                 fea16b47b603e7e4fa7fca198bd49229c0e5da3d
>
> This will take a while initially, or when the `master` branch of the
> public-inbox mirror was updated, as it will generate two files with
> plain-text mappings.
>
> In its default mode, it will print the Message-ID of the mail (if found).
>
> With --open, it opens the mail in a browser (macOS support is missing,
> mainly because I cannot test: just add an `open` alternative to
> `xdg-open`).
>
> With --reply, it puts the mail into the `from-public-inbox` folder of a
> maildir-formatted ~/Mail/, so it is pretty specific to my setup here.
>
> Note: the way mails are matched is by timestamp. In practice, this works
> amazingly often (although not always, I reported findings short after
> GitMerge 2017). My plan was to work on this when/as needed.
>
> Note also: the script is very much in a 'works-for-me' state, and I could
> imagine that others might want to modify it to their needs. I would be
> delighted if somebody would take custody of it (as in: start a repository
> on GitHub, adding a README.md, adding a config setting to point to the
> location of the public-inbox mirror without having to copy the script,
> adding an option to install an alias to run the script, etc).
>
> And now, without further ado, here it is, the script, in its current glory:
>
> -- snipsnap --
> #!/bin/sh
>
> # This is a very simple helper to assist with finding the mail (if any)
> # corresponding to a given commit in git.git.
>
> die () {
>         echo "$*" >&2
>         exit 1
> }
>
> mode=print
> while case "$1" in
> --open) mode=open;;
> --reply) mode=reply;;
> -*) die "Unknown option: $1";;
> *) break;;
> esac; do shift; done
>
> test $# = 1 ||
> die "Usage: $0 ( [--open] | [--reply] ) <commit>"
>
> test reply != $mode ||
> test -d "$HOME/Mail" ||
> die "Need $HOME/Mail to reply"
>
> commit="$1"
> tae="$(git show -s --format='%at %an <%ae>' "$1")" ||
> die "Could not get Timestamp/Author/Email triplet from $1"
>
> # We try to match the timestamp first; the author name and author email are
> # not as reliable: they might have been overridden via a "From:" line in the
> # mail's body
> timestamp=${tae%% *}
>
> cd "$(dirname "$0")" ||
> die "Could not cd to the public-inbox directory"
>
> git rev-parse --quiet --verify \
>         b60d038730d2c2bb8ab2b48c117db917ad529cf7 >/dev/null 2>&1 ||
> die "Not a public-inbox directory: $(pwd)"
>
> head="$(git rev-parse --verify master)" ||
> die "Could not determine tip of master"
>
> prevhead=
> test ! -f map.latest-rev ||
> prevhead="$(cat map.latest-rev)"
>
> if test $head != "$prevhead"
> then
>         range=${prevhead:+$prevhead..}$head
>         echo "Inserting records for $range" >&2
>         git log --format="%at %h %an <%ae>" $range >map.txt.add ||
>         die "Could not enumerate $range"
>
>         cat map.txt map.txt.add 2>/dev/null | sort -n >map.txt.new &&
>         mv -f map.txt.new map.txt ||
>         die "Could not insert new records"
>
>         echo $head >map.latest-rev
> fi
>
> lines="$(grep "^$timestamp " <map.txt)"
> if test 1 != $(echo "$lines" | wc -l)
> then
>         test -n "$lines" ||
>         die "No records found for timestamp $timestamp"
>
>         echo "Multiple records found:"
>
>         for h in $(echo "$lines" | cut -d ' ' -f 2)
>         do
>                 git show -s --format="%nOn %ad, %an <%ae> sent" $h
>                 git show $h |
>                 sed -n -e 's/^+Message-Id: <\(.*\)>/\1/ip' \
>                         -e 's/^+Subject: //ip'
>         done
>
>         exit 1
> fi
>
> # We found exactly one record: print the message ID
> h=${lines#$timestamp }
> h=${h%% *}
> messageid="$(git show $h | sed -n 's/^+Message-Id: <\(.*\)>/\1/ip')" ||
> die "Could not determine Message-Id from $h"
>
> case $mode in
> print) echo $messageid;;
> open)
>         url=https://public-inbox.org/git/$messageid
>         case "$(uname -s)" in
>         Linux) xdg-open "$url";;
>         MINGW*|MSYS*) start "$url";;

         Darwin*) open "$url";;

>         *) die "Need to learn how to open URLs on $(uname -s)";;
>         esac
>         ;;
> reply)
>         mkdir -p "$HOME/Mail/from-public-inbox/new" &&
>         mkdir -p "$HOME/Mail/from-public-inbox/cur" &&
>         mkdir -p "$HOME/Mail/from-public-inbox/tmp" ||
>         die "Could not set up mail folder 'from-public-inbox'"
>
>         path=$(git diff --name-only $h^!) &&
>         mail="$(printf "%s_%09d.%s:2," $(date +%s.%N) $$ $(hostname -f))"
> &&
>         git show $h:$path >"$HOME/Mail/from-public-inbox/new/$mail" ||
>         die "Could not write mail"
>         ;;
> *)
>         die "Unhandled mode: $mode"
>         ;;
> esac
