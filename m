Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953B41F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 18:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeKMECp (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 23:02:45 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:39284 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMECp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 23:02:45 -0500
Received: by mail-vs1-f43.google.com with SMTP id h78so5654491vsi.6
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 10:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jsINAScxY29C1b4fIGVBjRndHF6jBik1CUbV2AQXtqI=;
        b=eclcLNP73CQycm58pBXZktWinsS4bYjdJAKUsSmtX8rBAgUqyctrA9dAhpronRnYC4
         YIB/rhbq/H29fm72PoP+M/CMIgrDvZ6TENg2VOC9H7Pxah4M4FBEmREqrL6+Jv5q/SdV
         HSQIzvFHQuPdlklGaUo1RegogWk23JuAHZJGhr/WJqjZSqc1PIqIc661bvW/7kRwQI6J
         ML3vUmBdkgciaX8SUb7mao3k1IEVOrj6M62Q8MyCkzTCnuLI7LSV7NkEvHS0jwC52LWX
         Q22R5XcfC74pl/stfuLN9LH1uQCX+jIG0gmDdQTjYS9MDavC5AKbsic6GZbEX3hGaiT5
         r5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsINAScxY29C1b4fIGVBjRndHF6jBik1CUbV2AQXtqI=;
        b=XrqBMuKoEqvpnL7bllORkiKcKfBc3TOTyu3CbxzV+B7w1GBedVB1D5gOI0NHuWdDF/
         6l8sNxhzwahKfjv0oKOxMaIHN5++FmKHwhXgJnuC94RfEcDkg5BE+Pc42vuo4OIzFEra
         +27TfmkBF/2rGZwS3YH02H0UkO2KFj5tTOgnSQKSL0AT4/KPYV/f6sNKJgaeVLGOKT92
         N6FpHzpewoEEY+GmS8tYm5ixL3IiiDKkDSl5Y+ejKmVGoKbF64siyMegwAc7Xpii9Sy+
         /zHgPDCVVB2dmt88EUgDhCkKsua2BOnuLXlaXMinlsoUiy5dBg7g7su/vcssgWNd1L4O
         R0xA==
X-Gm-Message-State: AGRZ1gJOGDQ27ZYFgdCXrG86z/a7zeLxuqD8jJKrbk4D+gyPm3vy0TQi
        yyC9LkPaW8x77XoOIdvmzjMAqRONNQCmpUsS2x8=
X-Google-Smtp-Source: AJdET5erbVxdXzfpLdmxQB2InPUusfBCfjzVc8viEvhHGuBbphikWn0r5U/URzbYdaziCqK5SpeiIzT7uet9loU3Ifw=
X-Received: by 2002:a67:f696:: with SMTP id n22mr875151vso.175.1542046102998;
 Mon, 12 Nov 2018 10:08:22 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-11-newren@gmail.com>
 <20181111072356.GJ30850@sigill.intra.peff.net> <CABPp-BGREOAvF-6DBymdwsUL2LpyPNqy8dCw0RuUKZf2Da6cJA@mail.gmail.com>
 <20181112125847.GI3956@sigill.intra.peff.net>
In-Reply-To: <20181112125847.GI3956@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Nov 2018 10:08:10 -0800
Message-ID: <CABPp-BHjPq-2JoeXur+FMs+T==arqvMaAW1uLKMSHKBKBS60rA@mail.gmail.com>
Subject: Re: [PATCH 10/10] fast-export: add --always-show-modify-after-rename
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 4:58 AM Jeff King <peff@peff.net> wrote:
> On Sun, Nov 11, 2018 at 12:42:58AM -0800, Elijah Newren wrote:
>
> Maybe I don't understand what you're trying to accomplish. I was
> thinking specifically of your "cat-file can tell you the large objects,
> but you don't know their names/commits" from above.

Fair enough.  And just to be clear, the first 9 patches were fixes and
features around trying to rewrite history; patch 10 is orthogonal and
was used for a separate run to just gather data.  It is entirely
possible I could gather that data other ways.

> I would do:
>
>    git log --raw $(
>      git cat-file --batch-check='%(objectsize:disk) %(objectname)' --batch-all-objects |
>      sort -rn | head -3 |
>      awk '{print "--find-object=" $2 }'
>    )
>
> I'm not sure how renames enter into it at all.

How did I miss objectsize:disk??  Especially since it is right next to
objectsize in the manpage to boot?  That's awesome, thanks for that
pointer.

I do have a separate cat-file --batch-check --batch-all-objects
process already, since I can't get sizes out of either log or
fast-export.  However, I wouldn't use your 'head -3' since I'm not
looking for the N biggest, but reporting on _all_ objects (in reverse
size order) and letting the user look over the report and deciding
where to stop reading.  So, this is a big and expensive log command.
Granted, we will need a big and expensive log command, but let's keep
in mind that we have this one.

> > One of the problems with filter-branch that people often run into is
> > they know what they want at a high-level (e.g. extract the history of
> > this directory for a new repository, or rewrite the history of this
> > repo to appear at a subdirectory so it can be merged into a bigger
> > repo and people passing filenames to log will still get the history of
> > those files, or I want to remove some of the big stuff in my history),
> > but often times that's not quite enough.  They need help finding big
> > objects, or may be unaware that the subset of files they want used to
> > be known by alternative names.
> >
> > I want a simple --analyze mode that can report on all files that have
> > been renamed (so users don't just say "all I care about is these N
> > files, give me a rewritten history just including those" -- we can
> > point out to them whether those N files used to be known by other
> > names), as well as reporting on all big files and if they've been
> > deleted, and aggregations of the "big files" information across
> > directories and file extensions.
>
> So this seems like a separate problem than what the commit message talks
> about.
>
> There I think you'd want to assemble the list with something like "git
> log --follow --name-only paths-of-interest" except that --follow sucks
> too much to handle more than one path at a time.
>
> But if you wanted to do it manually, then:
>
>   git log --diff-filter=R --name-only
>
> would be enough to let you track it down, wouldn't it?

Without a -M you'd only catch 100% renames, right?  Those aren't the
only ones I'd want to catch, so I'd need to add -M.  You are right
that we could get basic renames this way, but it doesn't cover
everything I need.  Let's use this as a starting point, though, and
build up to what I need...

I also want to know when files were deleted.  I've generally found
that people are more okay with purging parts of history [corresponding
to large ojbects] that were deleted longer ago than more recent stuff,
for a variety of reasons.  So we could either run yet another log, or
modify the command to:

  git log -M --diff-filter=RD --name-status

However, I don't just want to know when files were deleted, I'd like
to know when directories are deleted.  I only knew how to derive that
from knowing what files existed within those directories, so that
would take me to:

  git log -M --diff-filter=RAD --name-status

[Edit: I just saw your other email and for the first time learned
about the -t rev-list option which might simplify this a little,
although "need to worry about deleted files being reinstated" below
might require the 'A' anyway.]

At this point, let's remember that we had another full git-log
invocation for mapping object sizes to filenames.  We might as well
coalesce the two log commands into one, by extending this latest one
to:

  git log -M --diff-filter=RAMD --no-abbrev --raw

Also, I wanted commit date rather than author date, so we need to
extend the headers a bit.  Also, for reasons I won't bother detailing,
I think I want to traverse commits in reverse topological order.  So
our command is:

  git log --pretty=fuller --topo-order --reverse -M --diff-filter=RAMD
--no-abbrev --raw

But that still leaves us with four problems, three of which we can
solve with further extensions to this command:

1) There are some weird edge cases with deletions and renames.  Lots
of them in fact.  At a simple level, branching and merging and
multiple refs means that "is-this-deleted" isn't a binary flag for a
given filename (but rather a binary flag per-ref).  Also, it makes
"the set of names associated with a single 'file' as perceived by the
user" possibly rather ill-defined as well.  This can get really hairy,
but I'd at least like to handle the very basic cases of (a) "user
re-instates filename that used to be deleted" (i.e. the file isn't
deleted anymore) and (b) "user re-instates a filename that used to
exist but was renamed to something else" (in such cases, we can't just
treat the two filenames as being different names of the same content).
Handling the (b) usecase sanely requires some topology information, so
we need parents as well.  So our command extends to:

   git log --parents --pretty=fuller --topo-order --reverse -M
--diff-filter=RAMD --no-abbrev --raw

2) log is not plumbing, so parsing the stuff before the file
modifications is not a good idea. This could be fixed by using
--format:

  git log --format='%H%n%P%n%cd' --date=short --topo-order --reverse
-M --diff-filter-RAMD --no-abbrev --raw

3) log won't show changes for merge commits by default; we'd need to add -c:

  git log --format='%H%n%P%n%cd' --date=short --topo-order --reverse
-M --diff-filter-RAMD --no-abbrev --raw -c

4) log is not plumbing, revisited: although at this point I've
specified the log output explicitly enough that it ought to be safe to
parse, there are a few things that make me slightly worried.  I can
depend on fast-export to be stable; it only gives 'M' and 'D' unless
you explicitly ask for more types (e.g. -M to detect renames will add
'R').  With log, I'm no so sure; do I need to worry about new types
appearing in the future?  Also, should I just drop --diff-filter=RAMD
since it covers just about everything anyway?  Also, while --raw is
stable, is the combination of -c and --raw stable?  Is --date=short
stable (most likely, but still seems more likely to change than
fast-export would be)?  Is there something else I need to be worried
about?  Granted, each of those is only a small worry with log, but
they add up and give me pause about whether I should be parsing it
output in another tool.



So we've come up with an alternate way to get the data I need, though
with some worries.

I could potentially switch to using this and drop patch 10/10.  Maybe
there's even a good reason to prefer using log.  But at the time I was
thinking in terms of "I already have a tool that parses fast-export
output and I know it's stable...and it has access to all the
information I need so why not just get the information from it?"  So I
did that, and then realized towards the end that although it had all
the needed info, it stripped one piece from me.  Namely, when it had a
100% rename, I'd only get
   R oldname newname
and wouldn't know the sha1sum of newname (for mapping object sizes to
all their names).  If I cached the information about all file shas for
all trees I could pull it from that cache (which could be expensive
memory-wise for large repos), or I could use the original-oid
directive and keep another long running "git cat-file
--batch-check='%(objectname)' process and just pass it
"$ORIGINAL_OID:$NEWNAME" lines as I come across them.  However,
fast-export had the information and did special work to try to avoid
showing it when it thought it woudln't be needed, so why not just add
a flag to tell it to just give me the filemodify?

At this point, if folks don't like this patch, I'm more likely to use
the supplementary cat-file process than switching to log, unless
someone can ameliorate my concerns with it and suggest a good reason
why it's actually better.



Anyway, I hope it makes a little more sense why I created this patch.
Does it, or have I just made things even more confusing?

...and if you've read this far, I'm impressed.  Thanks for reading.
