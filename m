Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E746B1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 19:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeKAEP1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 00:15:27 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33274 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAEP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 00:15:26 -0400
Received: by mail-wr1-f43.google.com with SMTP id u1-v6so17766385wrn.0
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qAOuTSp2tXxYIUYsFUQ/SqBX7+hN+m45bZYgPz9Q9HI=;
        b=bjFt27ljEz//31q7DqoaU739vYfjzlpKzWrpk7JIolDT6/qprY7lmZvjVra5itqkn9
         lUDeIw2FjUdJVTfn4CHgvEC7wDC3NouY+97XLhB5gZlgN/qrGK7pv5CmZLpTqQSeyppY
         QEM3yXrVgsO447Qxci5+jPhPpTfkJQunAw01BwwO8KjjHzhgcWrQnLe9wov3Ti8lQXlC
         JpSblmYjmwIPNHGQ7VOdSeOdal6Jwc/ulSuEzIBnb5TR9It/BmOOFZOYTGLbJM12/Ar+
         RHGcgPFLewlkIgIhELgt0lvYD5lmy2pLXC/3rHOH+rn6ZyPpQvHhFwmkbLeaS/6xdQ76
         8rGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qAOuTSp2tXxYIUYsFUQ/SqBX7+hN+m45bZYgPz9Q9HI=;
        b=dZ0AQ14g9FnVumRjubyU6OWoA0Csn/a23CuEO9hRltFKKe3piydBwUIvPGRFAHnhni
         uUCnhcwkMGQPHvWk4rzh0SAmTTBVu6DbG4AkxQ7Zw/g91F8hTd5BDmMyneBEewUMJdcd
         xVIa/rqpzXCWgkR9+ID878VHEjTHu3tLkY89TIrAvbG+mTsYFJQyG+4XGOi5W6zP3y3b
         t3cK0I99HVvRKQhBT+4exslxb1UooBVnKKHXzVJWN8zMi9hREKSxmjbGj49MNyaSj8nw
         rgEHFOn7c13DPtSHuPM501yVpqzj7Cqe3Cmh+pPQ8hQFIoZw/u+VNu/Y56Y8SF9Evvcn
         AQ8A==
X-Gm-Message-State: AGRZ1gIgJDIXMEpQp/OB0Ur3caGuNYew0nin5eY+raQjWwD7c7DB+6/q
        jawnpzqLCHvq2rYtDoerUjY=
X-Google-Smtp-Source: AJdET5drVvf9ZiC2nm+kG4cTKFJv/nePm5sQrCoBVT9xsb+cA4irB8/QKZf3QuqmVh0Oivu8/MEDgw==
X-Received: by 2002:adf:9501:: with SMTP id 1-v6mr4015863wrs.291.1541013361734;
        Wed, 31 Oct 2018 12:16:01 -0700 (PDT)
Received: from larsbook.fritz.box (p50900AEF.dip0.t-ipconnect.de. [80.144.10.239])
        by smtp.gmail.com with ESMTPSA id v19-v6sm13637583wmd.20.2018.10.31.12.16.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:16:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Import/Export as a fast way to purge files from Git?
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CABPp-BGL-3_nhZSpt0Bz0EVY-6-mcbgZMmx4YcXEfA_ZrTqFUw@mail.gmail.com>
Date:   Wed, 31 Oct 2018 20:15:59 +0100
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        me@ttaylorr.com, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <91771D9B-166D-403F-BB20-7E574444BB3B@gmail.com>
References: <F65AF000-7AE0-44C8-81C8-E58D6769FAA3@gmail.com>
 <CABPp-BGL-3_nhZSpt0Bz0EVY-6-mcbgZMmx4YcXEfA_ZrTqFUw@mail.gmail.com>
To:     Elijah Newren <newren@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Sep 24, 2018, at 7:24 PM, Elijah Newren <newren@gmail.com> wrote:
>=20
> On Sun, Sep 23, 2018 at 6:08 AM Lars Schneider =
<larsxschneider@gmail.com> wrote:
>>=20
>> Hi,
>>=20
>> I recently had to purge files from large Git repos (many files, many =
commits).
>> The usual recommendation is to use `git filter-branch --index-filter` =
to purge
>> files. However, this is *very* slow for large repos (e.g. it takes =
45min to
>> remove the `builtin` directory from git core). I realized that I can =
remove
>> files *way* faster by exporting the repo, removing the file =
references,
>> and then importing the repo (see Perl script below, it takes ~30sec =
to remove
>> the `builtin` directory from git core). Do you see any problem with =
this
>> approach?
>=20
> It looks like others have pointed you at other tools, and you're
> already shifting to that route.  But I think it's a useful question to
> answer more generally, so for those that are really curious...
>=20
>=20
> The basic approach is fine, though if you try to extend it much you
> can run into a few possible edge/corner cases (more on that below).
> I've been using this basic approach for years and even created a
> mini-python library[1] designed specifically to allow people to create
> "fast-filters", used as
>   git fast-export <options> | your-fast-filter | git fast-import =
<options>
>=20
> But that library didn't really take off; even I have rarely used it,
> often opting for filter-branch despite its horrible performance or a
> simple fast-export | long-sed-command | fast-import (with some extra
> pre-checking to make sure the sed wouldn't unintentionally munge other
> data).  BFG is great, as long as you're only interested in removing a
> few big items, but otherwise doesn't seem very useful (to be fair,
> it's very upfront about only wanting to solve that problem).
> Recently, due to continuing questions on filter-branch and folks still
> getting confused with it, I looked at existing tools, decided I didn't
> think any quite fit, and started looking into converting
> git_fast_filter into a filter-branch-like tool instead of just a
> libary.  Found some bugs and missing features in fast-export along the
> way (and have some patches I still need to send in).  But I kind of
> got stuck -- if the tool is in python, will that limit adoption too
> much?  It'd be kind of nice to have this tool in core git.  But I kind
> of like leaving open the possibility of using it as a tool _or_ as a
> library, the latter for the special cases where case-specific
> programmatic filtering is needed.  But a developer-convenience library
> makes almost no sense unless in a higher level language, such as
> python.  I'm still trying to make up my mind about what I want (and
> what others might want), and have been kind of blocking on that.  (If
> others have opinions, I'm all ears.)

That library sounds like a very interesting idea. Unfortunately, the=20
referenced repo seems not to be available anymore:
    git://gitorious.org/git_fast_filter/mainline.git

I very much like Python. However, more recently I started to
write Git tools in Perl as they work out of the box on every
machine with Git installed ... and I think Perl can be quite
readable if no shortcuts are used :-).=20


> Anyway, the edge/corner cases you can watch out for:
>=20
>  - Signed tags are a problem; you may need to specify
> --signed-tags=3Dstrip to fast-export
>=20
>  - References to other commits in your commit messages will now be
> incorrect.  I think a good tool should either default to rewriting
> commit ids in commit messages or at least have an option to do so
> (BFG does this; filter-branch doesn't; fast-export format makes it
> really hard for a filter based on it to do so)
>=20
>  - If the paths you remove are the only paths modified in a commit,
> the commit can become empty.  If you're only filtering a few paths
> out, this might be nothing more than a minor inconvenience for you.
> However, if you're trying to prune directories (and perhaps several
> toplevel ones), then it can be extremely annoying to have a new
> history with the vast majority of all commits being empty.
> (filter-branch has an option for this; BFG does not; tools based on
> fast-export output can do it with sufficient effort).
>=20
>  - If you start pruning empty commits, you have to worry about
> rewriting branches and tags to remaining parents.  This _might_ happen
> for free depending on your history's structure and the fast-export
> stream, but to be correct in general you will have to specify the new
> commit for some branches or tags.
>=20
>  - If you start pruning empty commits, you have to decide whether to
> allow pruning of merge commits.  Your first reaction might be to not
> allow it, but if one parent and its entire history are all pruned,
> then transforming the merge commit to a normal commit and then
> considering whether it is empty and allowing it to be pruned is much
> better.
>=20
>  - If you start pruning empty commits, you also have to worry about
> history topology changing, beyond the all-ancestors-empty case above.
> For example, the last non-empty commit in the ancestry of a merge on
> both sides may be the same commit, making the merge-commit have the
> same parent twice.  Should the duplicate parent be de-duped,
> transforming the commit into a normal non-merge commit?  (I'd say yes
> -- this commit is likely to be empty and prunable once you do so, but
> I'm not sure everyone would agree with converting a merge commit to a
> non-merge.)  Similarly, what if the rewritten parents of a merge have
> one parent that is the direct ancestor of another?  Can the extra
> unnecessary parent be removed as a parent?  (And again, such a commit
> is likely to become empty and be prunable itself.)
>=20
>  - If you try to avoid the extra work involved with pruning empty
> commits by passing path-specifiers as rev-list-args to fast-export,
> and use the --tag-of-filtered-object=3Drewrite option if needed, then
> depending on the topology you can hit any of three bugs: an outright
> die() (despite the --tag-of-filtered-object=3Drewrite), a branch being
> reset to a non-existent mark (causing fast-import to die), or find
> that a ref which you explicitly requested to be part of the export is
> silently omitted from the stream.  (granted, these aren't fundamental
> issues; they're just bugs in fast-export that I seem to have been the
> first to find.)
>=20
>  -  filter-branch has a nice ability to rewrite only the last few
> commits using a range specifier like HEAD~10..HEAD.  Trying the same
> with fast-export will get you a history with only 10 commits, the
> first of which squashes all early history together.  Trying to
> duplicate the filter-branch behavior can be done, but it requires
> multiple exports with different args and usage of --export-marks and
> --import-marks; it's cumbersome and somewhat non-obvious.
>=20
>  - some filters are difficult; e.g. if you want to mimick
> filter-branch's --parent-filter, or BFG's --strip-blobs-with-ids, you
> run into the issue that the fast-export stream doesn't provide the
> original sha1sums for commits or blobs and there's no easy way for you
> to associate it with the given mark.

Thanks a lot for these tips and tricks. I was aware of the empty commits
but the signed tags problem was not yet on my radar!

Thanks,
Lars=
