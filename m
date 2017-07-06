Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA16202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 17:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdGFRBJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 13:01:09 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37718 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdGFRBI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 13:01:08 -0400
Received: by mail-it0-f44.google.com with SMTP id m84so9659793ita.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 10:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aLxloZ6QhfHqZhBZ2nKkuikVZfkW/uNtv/uq/hK68JU=;
        b=YkTMrNgKNGpQSSJZ/iK+52YUd8p9+7hfsc7PHA/YTAlJij3FwUVbaGDVw57aR82xud
         kFWyw9mcm5trBP9spQSufz42mrXq/cZgL3dughx7R4Y0oyGsgGKrwVleSyADWo3bCNas
         RPTiVPz0l+HUgYteXZz/w4CWx6fmY6+dcET6Wg8hkAz7ruB/9iv01c+Hx6AzTXiad2Xk
         gEdZNFFh5FJPO9te7wSuiHYF5F1AwjfxegYL10MGT3LyN/UvETTqBbhr3XMHdBdFn9/j
         3f5XYb4bsNyoxq5e8E+0aPmJnn2LOGIxFc32NmMPew3APozci0d6w8NyXyqFERmf18md
         6bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aLxloZ6QhfHqZhBZ2nKkuikVZfkW/uNtv/uq/hK68JU=;
        b=S0y5Vif8HjlrXemE0778CbA/tIEkz/MMH4s9GAD6jxcFc3PREWTJdd7zMT38lmg31i
         gvI9A3LHm9iM7uE2ySwzRAbpFiyoa0B/5nudMXoJj4GMzqile0WuueG1P4tMb4nIP3BI
         9AYEQES3JHIf8eBy2aAwDcee26U6J1z2VadoLzO3O21zaUXJ7yUw+KKPMvPhd9666/1/
         rbC3fxBc/gNfILD9lGbbjRYtTGvF88zj7qj8tjLfoQoyTNGeRQJKB7Se0TL+3BMvOZvg
         EE4tifykXdC9kx/pZuHfpKIKnVotWp7ILk7Nti+wXARTbiQV2BxBbtrOW1qBF9ixrttx
         fvjQ==
X-Gm-Message-State: AIVw111DVzFOzGdLa9m4BwhRsCClvs66tfqFDGyaBVMghcFwRFhNGI0R
        dSbMUWfEExux6TkNm3y8KFus3AgU686XYDqxNg==
X-Received: by 10.36.203.3 with SMTP id u3mr378523itg.101.1499360466751; Thu,
 06 Jul 2017 10:01:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.196.153 with HTTP; Thu, 6 Jul 2017 10:01:05 -0700 (PDT)
In-Reply-To: <20170706133124.GB1216@inner.h.apk.li>
References: <20170704075758.GA22249@inner.h.apk.li> <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
 <20170706133124.GB1216@inner.h.apk.li>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 6 Jul 2017 10:01:05 -0700
Message-ID: <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
Subject: Re: Flurries of 'git reflog expire'
To:     Andreas Krey <a.krey@gmx.de>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm one of the Bitbucket Server developers. My apologies; I just
noticed this thread or I would have jumped in sooner!

On Thu, Jul 6, 2017 at 6:31 AM, Andreas Krey <a.krey@gmx.de> wrote:
> On Wed, 05 Jul 2017 04:20:27 +0000, Jeff King wrote:
>> On Tue, Jul 04, 2017 at 09:57:58AM +0200, Andreas Krey wrote:
> ...
>> And what does the process tree look like?
>
> Lots (~ 10) of
>
>           \_ /usr/bin/git receive-pack /opt/apps/atlassian/bitbucket-data/shared/data/repositories/68
>           |   \_ git gc --auto --quiet
>           |       \_ git reflog expire --all
>
> plus another dozen gc/expire pairs where the parent is already gone.
> All with the same arguments - auto GC.

Do you know what version of Bitbucket Server is in use? Based on the
fact that it's "git gc --auto" triggered from a "git receive-pack",
that implies two things:
- You're on a 4.x version of Bitbucket Server
- The repository (68) has never been forked

Depending on your Bitbucket Server version (this being the reason I
asked), there are a couple different fixes available:

- Fork the repository. You don't need to _use_ the fork, but having a
fork existing will trigger Bitbucket Server to disable auto GC and
fully manage that itself. That includes managing both _concurrency_
and _frequency_ of GC. This works on all versions of Bitbucket Server.

- Run "git config gc.auto 0" in
/opt/apps/atlassian/bitbucket-data/shared/data/repositories/68 to
disable auto GC yourself. This may be preferable to forking the
repository, which, in addition to disabling auto GC, also disables
object pruning. However, you must be running at least Bitbucket Server
4.6.0 for this approach to work. Otherwise auto GC will simply be
reenabled the first time Bitbucket Server goes to trigger GC, when it
detects that the repository has no forks.

Assuming you're on 4.6.0 or newer, either approach should fix the
issue. If you're on 4.5 or older, forking is the only viable approach
unless you upgrade Bitbucket Server first.

I also want to add that Bitbucket Server 5.x includes totally
rewritten GC handling. 5.0.x automatically disables auto GC in all
repositories and manages it explicitly, and 5.1.x fully removes use of
"git gc" in favor of running relevant plumbing commands directly. We
moved away from "git gc" specifically to avoid the "git reflog expire
--all", because there's no config setting that _fully disables_
forking that process. By default our bare clones only have reflogs for
pull request refs, and we've explicitly configured those to never
expire, so all "git reflog expire --all" can do is use up I/O and,
quite frequently, fail because refs are updated. Since we stopped
running "git gc", we've not yet seen any GC failures on our internal
Bitbucket Server clusters.

Bitbucket Server 5.1.x also includes a new "gc.log" (not to be
confused with the one Git itself writes) which retains a record of
every GC-related process we run in each repository, and how long that
process took to complete. That can be useful for getting clearer
insight into both how often GC work is being done, and how long it's
taking.

Upgrading to 5.x can be a bit of an undertaking, since the major
version brings API changes, so it's totally understandable that many
organizations haven't upgraded yet. I'm just noting that these
improvements are there for when such an upgrade becomes viable.

Hope this helps!
Bryan

>
> I'd wager that each push sees that a GC is in order,
> and doesn't notice that there is one already running.
>
> - Andreas
>
> --
> "Totally trivial. Famous last words."
> From: Linus Torvalds <torvalds@*.org>
> Date: Fri, 22 Jan 2010 07:29:21 -0800
