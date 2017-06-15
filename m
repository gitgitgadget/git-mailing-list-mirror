Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0851FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 08:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdFOIJe (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 04:09:34 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35021 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbdFOIJd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 04:09:33 -0400
Received: by mail-io0-f171.google.com with SMTP id k93so7217599ioi.2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=weWYvw3YxnvwhjsmMocTTjehgCnzW7hHIrjuStrKISw=;
        b=J96ZajppFyUECUinbGsAGXYkqsr3tJOjb9wItUvXeZvoejbDFjR1MKnUI20Vuy6hS4
         l8jDTg6Lvwttn368zXQuCD8r/4gTqczcK1Le+Xovg/mQRxUn9idTOx+EQ2zvMTBzNgR+
         6D2jKLD4lYWII5Zk9zyogkaunVVg32aBZtN+Zh/7wdiko94HylUlXd8fQegaoz2cEU/J
         p7AD1oa4qVuPS7iCBDP3dcxDrG9Va3O8JnurZX9ICckd+HRQskVdw4DPMO3lQFuwMiBO
         h8TPl7TWh4S9Q5lwiuNQqkgw5xOnL7AGObXOPuyJbKHys/lnF/Wxsi0LhOkdvAS+sM4t
         u9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=weWYvw3YxnvwhjsmMocTTjehgCnzW7hHIrjuStrKISw=;
        b=EUvaQUAJJy3XwGPTK7hqUGS3z/M77kKIniGCnrUeWEtiSioVJ20TbuXpQ551tc/9om
         fiyy3qZIN8Qcrk8sp4KEKe2SrWlZHtrTTb+GDknQvpHodMiYciBzyMotMrb/6MMP1Wcc
         j4vlbRMah16prRK6kYFpt5Glt7LkaHAKTE1ZRU8F5roCdt0ZVkLvQ9MARM6qdlVHm56Z
         Is5uDDE7g6pSclCjQGcIMzxRNiO8pQ6+N1KNkfQpaVjeuBtIXV2lQb/Cy7yUzlp2zORd
         d2QseC2B4WYXAjuKIunSWhBHyG1zROgpvpczmiCqS0e3wz+mMCCaG+QVSInjkER/CBwR
         UIzQ==
X-Gm-Message-State: AKS2vOz/CvVA91JyiQW1L9W4MMOXcsxanLaNQYeRsbiAWAYRnFl58/TF
        +G6XfxBwEWAw6JuuEPWgzCM1yb/NhQ==
X-Received: by 10.107.178.130 with SMTP id b124mr3806824iof.50.1497514172703;
 Thu, 15 Jun 2017 01:09:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Thu, 15 Jun 2017 01:09:11 -0700 (PDT)
In-Reply-To: <xmqqlgoxp5ig.fsf@gitster.mtv.corp.google.com>
References: <20170609142151.94811-1-larsxschneider@gmail.com>
 <31A456B20D984421AA958A39B2FCD29D@PhilipOakley> <xmqqlgoxp5ig.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 15 Jun 2017 10:09:11 +0200
Message-ID: <CACBZZX42JcqFAsWgi0bSuRv5CC8hiUF1Ahnx3nJL=LyHkk03Cg@mail.gmail.com>
Subject: Re: [PATCH v1] Configure Git contribution guidelines for github.com
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Lars Schneider" <larsxschneider@gmail.com>
>>> Many open source projects use github.com for their contribution process.
>>> Although we mirror the Git core repository to github.com [1] we do not
>>> use any other github.com service. This is unknown/unexpected to a
>>> number of (potential) contributors and consequently they create Pull
>>> Requests against our mirror with their contributions. These Pull
>>> Requests become stall [2]. This is frustrating to them as they think we
>>> ignore them and it is also unsatisfactory for us as we miss potential
>>> code improvements and/or new contributors.
>>>
>>> GitHub offers a way to notify Pull Request contributors about the
>>> contribution guidelines for a project [3]. Let's make use of this!
>>>
>>> [1] https://github.com/git/git
>>> [2] https://github.com/git/git/pulls
>>> [3]
>>> https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/
>>>
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> ---

[The latest patch in this thread looks good to me to, thanks Lars]

>> I see there are currently 84 open PRs (13 in the last 14 days), so it
>> is real.
>
> Not so insignificant fraction of these are done purely for the
> purpose of using submitgit, though.  In other words, if submitgit
> were improved not to require a pull request against [1] (instead, it
> could be pointed at a branch in a contributor's repository and do
> the fromatting), these numbers will go down.

There are things we get out of this that would regress if
submitGit were changed this way:

 * Now when you submit a pull request you get a Travis build for
git/git, I don't get this if I push to any random branch in my
avar/git, and although I could probably set it up, it's extra work
etc.

 * I like being able to "git fetch" patches I'm reviewing. Now I can
just set "+refs/pull/*:refs/remotes/origin/pull/*" in the refspec for
git/git, if it were pulling from target repos I'd need to "git remote
add" for each one, not a big deal, but less convenient.

 * There would be no single place to list submitGit requests, which
you can do now through the pull page, although I think this is largely
stale now because nothing auto-closes them if they're merged (by which
point they'll have different sha1s), but that could be improved with
some bot...

There's probably ways to do this without git/git pull requests, but I
don't see what problem would be solved by moving this off git/git,
even if there's open requests submitGit is the only thing using these,
and any confusion about that pull UI would remain if it wasn't (AFAIK
there's no way to completely disable pull requests on github, but I
may be wrong).
