Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 803AE1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 06:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3GV3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 02:21:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39706 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfJ3GV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 02:21:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so1130614otl.6
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 23:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JnP94kdIO2ejIFzqLH5XGV1Chv9kUyUYDgaznvhoJSQ=;
        b=amoewfAPH6N8QaS4QEtlmY8Oeep5R+cbYIv/YFRryeDX7Vf7dFqtDxt6sK4oTWMRbT
         v3ap6k6V9Amnab6bKOqD8LpwKuP31qPCvZrlQduzFgeKa+SAwaDbM9Z0agsknWPYvP2Z
         wYxJep+d5IqB/DfJISjEILrnDUmXlT0svbxK4SNktT3VLMAMiIJGSPAGBCxO39MBDtUv
         5LSxWV2+MxBBsEIKNBoug3+i804Dl2GYNnv2K2uHE1DJ8hLhU+ACQ/l6v0QTLG26PeNd
         fPHai+X3W0k8wdZWBi9fgpUlzxJkkc6IgE0PTfiC5v/Sfq031ER8hC3gIwXMca50uAow
         1U2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JnP94kdIO2ejIFzqLH5XGV1Chv9kUyUYDgaznvhoJSQ=;
        b=oNX+9Ab46Sxxa+MgUthCNO2ESnKFDrpRaEGQA5wAwvMPaCzXI/K2zuIfJcr0TxUHHu
         uvbcgrZJyoKuo88d0zyPWib7Bz/d8T6aFw/JRp6Okfa+d0ot4ZsP6OAifV9o92NrEmfF
         KHq0JatymIg4kb1tDJMbkGXqXXIES2iY2Wz77ZPVavBFLHqYP/jpd2IrNLTfh+DgN/aS
         lO2RSgcCHMD4nsWSfpC/LdLIkhtXkMODpeoimNW0L1d1Y7OtoVdGs/eFfV6ooqNswUwi
         nygHGRc5b926+zB78PNDX3vB46SNIRc9p/JN8YZ9j0gxbl8tTAkqgxX1kp0OQ8JaPRYs
         6luQ==
X-Gm-Message-State: APjAAAUE+RMN9Z2AkdeyHMVoWmDaHItlfuVvRc+mT3vm7nrHHBSa5K1z
        1Z4FX68CwD3Mkw25q9X4TMKbTD9DUddJKmhV8LE=
X-Google-Smtp-Source: APXvYqybDqC71P3v8OKh0kPy3wWu+ewjqbpUkbGSsBhQrrV8rUKKh8dHxhKHFQey7G3Owqq0Zas1+raMIgrzn+prYeA=
X-Received: by 2002:a9d:7a99:: with SMTP id l25mr21589795otn.316.1572416486168;
 Tue, 29 Oct 2019 23:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191023201310.thzpxyoeb3ta55dc@yadavpratyush.com>
 <CABPp-BEHy8c3raHwf9aFXvXN0smf_WwCcNiYxQBwh7W6An60qQ@mail.gmail.com> <86k18rbbyz.fsf@gmail.com>
In-Reply-To: <86k18rbbyz.fsf@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 29 Oct 2019 23:21:15 -0700
Message-ID: <CABPp-BG2SkH0GrRYpHLfp2Wey91ThwQoTgf9UmPa9f5Szn+v3Q@mail.gmail.com>
Subject: Re: RFC: Moving git-gui development to GitHub
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 26, 2019 at 11:25 AM Jakub Narebski <jnareb@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
> > On Thu, Oct 24, 2019 at 2:45 AM Pratyush Yadav <me@yadavpratyush.com> w=
rote:
> >>
> >> I recently had some discussions with Dscho about whether it is a bette=
r
> >> idea to use GitHub for development instead of email [0]. His argument
> >> was that GitHub makes it easier for newcomers to contribute, since mor=
e
> >> people are familiar with GitHub compared to mailing lists. Also, it is
> >> somewhat difficult to set up an email-based workflow.
> [...]
> > GitHub is great for ease of creating new repos, learning about other
> > developers, finding similar projects, creation of webhooks, etc.  But
> > it's *awful* for code review.  Gerrit is a lot better at code reviews
> > (though still has problems); so maybe dealing with both GitHub and
> > Gerrit would be reasonable.
> [...]
> > Email is a horrible medium for sending/receiving
> > changes, but at least it gets the overall code review model right
> > (commit-messages-are-first-order-objects-that-can-be-reviewed,
> > review-individual-commits, merge-per-topic, cover-letter included,
> > range-diff for high-level comparison of different iterations,
> > reversing-commit-order-display-based-on-author-timestamps-is-NOT-forgiv=
able,
> > Change-IDs-are-ugly, magic-refs-are-disgusting, etc.), something no
> > GUI tool (yet) does to my knowledge.
>
> I agree with that.  You need then to decide whether it is better to have
> it easier for beginners to contribute, or is it better to have it easier
> to review code.  What are the pain points?

I don't think that's the right comparison to make.  The problems with
GitHub code review aren't solely ease-of-use issues, they are more a
quality-of-code issues.

Projects which switch to GitHub tend to have overall commit quality go
down IMO, because the system (a) makes it nearly impossible to review
commit messages, so people eventually degrade to writing really bad
ones, (b) makes it nearly impossible to review a rebased set of
changes except redoing the entire review from square one, so people
don't rebase, (c) punishes both users and reviewers who want to work
with a rebased patch series by displaying the series out of order --
even for a completely linear history (it resorts based on author
timestamp, not even committer timestamp), and (d) punishes
reviewers/users when they attempt to review individual commits by
making it harder to see and follow these comments (though it has
gotten much better on this front).  There are combination effects too.
People to write really bad commit messages for all the additional
"fixups" they have.  People notice that commits don't bisect nicely,
and instead of understanding that the broken code review system they
wrote was the problem, they instead offer a new "squash merge" option,
thus destroying all the carefully separated commits that help people
understand the individual steps toward the new feature and making it
impossible for anyone in the future to review it incrementally.  You
may say it's a workflow choice for some people to just squash all
their stuff together at their option, which would be fine, but the
problem is most developers don't take the time to think, and someone
in charge of the project notices that they keep getting un-bisectable
meaningless commits unless they force *everyone* in the project to use
squash merging.  Now they are punishing me for creating clean separate
commits and forcing them all to be squashed -- all as an ugly
workaround to the basic tool being *broken*.  You can work around this
by making a long sequence of PRs, one per what you intend to be a
commit, and try to track the hierarchy -- something that GitHub
certainly doesn't make easy.  And then each PR becomes a trivial small
change, and you are back to merging individual commits, and writing
your own tools to manage a hierarchy of PRs...and reviewers hate you
if you do that because it's extremely onerous on them.

GitHub PRs aren't just hard to use, they literally degrade the quality
of the code for people who have to use it.  I've seen it happen with
many projects.

(At $DAYJOB, they have hundreds of repos and have at times used SVN
then gitolite then gerrit then (Atlassian) stash then github (with
other review tools like sourcegraph and reviewable tried and a few
others read up on), with most of those existing simultaneously --
though we eventually pruned it down to just Gerrit and GitHub, with
some projects in one and some in the other system.  I've seen
migrations between various combinations of these tools (though SVN and
gitolite were nearly phased out by the time I joined), and seen
results of how the tools caused differences in behavior.  And yes, I
know that GitHub's popularity means many have copied GitHub's PR
model, from sourcegraph who were basically identical, to Stash which
is similar but handled rebases better, and I think GitLab looks
similar though I haven't used it that much (yet).  Reviewable handled
rebases a lot better, but still used the utterly broken model of not
allowing commit messages to be reviewed -- and glitterbombed the
interface with butterflies.)

> Another source worth looking into is "Patches carved into stone tablets,
> why the Linux kernel developers rely on plain text email instead of
> using =E2=80=9Cmodern=E2=80=9D development tools." presentation by Greg K=
H from
> 2016[1][2].  But remember that git-gui is not Linux kernel; what works
> for one might not work for the other.
>
> It is unfortunate that we have no tools described in "Patches carved
> into developer sigchains"[3] wishfull blog post by Konstantin Ryabitsev..=
.

Interesting links; thanks for providing them.  And yes, I agree that
git-gui won't necessarily have the same tradeoffs as the Linux kernel.
But I do tend to be noisy here hoping I can spark someone with a
modicum of talent for front-end development (I have neither the talent
nor the inclination for web development) to write a sane webby code
review system.  Much of GitHub is awesome.  And it has some apparently
really nice thing for web devs, which seems to be part of why so many
people use it.  It's just so terribly awful at code reviews.  But
systems like Reviewable and GerritHub build on top of GitHub, so maybe
there is hope someone can build just the review part and make it
awesome.

> [1]: https://kernel-recipes.org/en/2016/talks/patches-carved-into-stone-t=
ablets/
> [2]: https://www.slideshare.net/ennael/kernel-recipes-2016-patches-carved=
-into-stone-tablets
> [3]: https://people.kernel.org/monsieuricon/patches-carved-into-developer=
-sigchains
>
> Regards,
> --
> Jakub Nar=C4=99bski
