Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D96E120D09
	for <e@80x24.org>; Tue,  6 Jun 2017 10:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbdFFKON (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 06:14:13 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33235 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbdFFKOM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 06:14:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id a70so4402447pge.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bDwiKHNWZ5Pa8QduHqgIS84OGcZXwWV37PmRa4KjqVQ=;
        b=dejt8Dyebj/6xrHE0H1S4BKvDRIa14TqFaaPbNxLpS5wCqWuSKl59xPATQkhWMvJz+
         aEQs1KVEtMWve8UhFoOW3Gg5DQQw0X1JOZgmODWrWqHBdcR5GWC0aX5KxAglfFr0AvxV
         E6GbWXeqAitBJWv9rU1D4ohDR+RuPoJTUljdMcJZNP84GgpIvjqn/NNQimZsuDHESLSM
         0bRBwjMJcNB5LUFIUYGgvbsYYvWQ681jofVieXnohrHn6u9yJsXlmSsi4aWFq4ioMyvN
         8FQ8INApGooGNgLJGAvUJkVotJW/60loVoDUHlUF38jMZMHjeKZVaTuTh70u1fRsvwPw
         Gv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bDwiKHNWZ5Pa8QduHqgIS84OGcZXwWV37PmRa4KjqVQ=;
        b=mblF6T6Zb4ueRdpXJlic/U95z8ytKfhizlP9BmoDvwtaT4cqbWWoF6l8IrigPqpAie
         wHViXuahjkmlI9NealBCcHxZ6e8ywrUdBcXdByc192HLDFVOIqC84UElh/UJgC1QbtFC
         V7tPccCoVNJZSdjHcDMRcrKua9zr0rBjjW1BPD9aoBYus0pPf/l2Uj/7d3X4tBkMk2S9
         LOUUtCMYeXAMNZ50xGFHgv962qjatCboBeuMmBQ/ouJ4Lm9bcr0MrLn3NGaTFbiKlaqa
         t2ti6aX7V/A+jaXtbWH2AOJFVkLO5YLnuriJdweX/4uczJAmi4BB3iVb2SGTXfCrDPJk
         5DrQ==
X-Gm-Message-State: AODbwcCgbMn3gXPFWMsik7htqM+A5g9lER96chijxuaxQwB5emMymmfk
        cwSrUhUwaPnuKyLIk0mZnfwfLY5thg==
X-Received: by 10.84.218.136 with SMTP id r8mr20291213pli.265.1496744051814;
 Tue, 06 Jun 2017 03:14:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.151.14 with HTTP; Tue, 6 Jun 2017 03:13:51 -0700 (PDT)
In-Reply-To: <CACBZZX5OS_cz_mo4rpd+=DGtyN4SfipGrOXwVHJisv3CywoFaw@mail.gmail.com>
References: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
 <0102015c79fcbe99-7e18cee7-d82d-4ab2-9d6a-ad7376a5ac27-000000@eu-west-1.amazonses.com>
 <CALiud+=qoSSSg_p2MXZEaVTGMhFW_FtirDJ2-FnmNh+U0yf0Gw@mail.gmail.com>
 <xmqqlgp69ds9.fsf@gitster.mtv.corp.google.com> <CACBZZX5OS_cz_mo4rpd+=DGtyN4SfipGrOXwVHJisv3CywoFaw@mail.gmail.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Tue, 6 Jun 2017 12:13:51 +0200
Message-ID: <CALiud+mLAF4CK+-p7Ey0VvBp74XecxC8demcZSow94EfrRaUgA@mail.gmail.com>
Subject: Re: [PATCH/RFC v4 3/3] branch: add copy branch feature implementation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 9:39 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jun 6, 2017 at 2:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Sahil Dua <sahildua2305@gmail.com> writes:
>>
>>> I want suggestions about one logical point raised by Evar.
>>>
>>> Let's consider a case that I'm on branch maint and then I do 'git
>>> checkout master' followed by 'git branch -m feature', it will rename
>>> master branch to feature. Now if I do 'git checkout -' to go to the
>>> last branch, it will take me to maint since master branch doesn't
>>> exist in this case.
>>>
>>> Now, for this copy operation - if I'm on branch maint and then I do
>>> 'git checkout master' followed by 'git branch -c feature', it will
>>> copy master branch to feature. Now if I do 'git checkout -' to go to
>>> the last branch, it will again go to maint (according to the current
>>> implementation). What do you think it should do? Is this the desired
>>> behavior? Or should it go to master branch since that was the branch
>>> checked out before copying.
>>>
>>> Also, in case this needs to be changed, can someone please point me to
>>> how it's being handled so that I can change the behavior.
>>
>> When somebody says "I want to rename my current branch to X", it is
>> clear that the person wants to end up being on a branch called X.
>>
>> To me, "I want to copy my current branch to Y" sounds more like "I
>> want to create another Y that looks just like the current branch,
>> but I want stay on my current branch".
>
> This would be more useful to me if the semantics were copy & checkout
> instead of just copy, since when I'd like to copy branches it's almost
> always because I'm on some topic branch and want to create & work on a
> new copy of that topic branch.
>
> It would also be consistent with "git branch -m" and easier to
> explain, i.e. "git branch -c just like -m except it doesn't delete the
> branch name/config you moved away from".
>
> Like with -m, you can still move around random other branches, e.g.:
>
>     # While on master
>     $ git branch -m some-other new-some-other
>
> This will just move some-other to new-some-other without checkout out
> new-some-other, it's only when the source name is the same as your
> currently checked out branch that you checkout a new branch,
>
> Now, of course the difference is that when you -m your current branch
> it doesn't really have a choice of whether to move your checkout as
> well (although I suppose it could leave you in a detached HEAD..) so
> it *could* be done differently with -c, but the current behavior makes
> more sense to me and matches the common case I'd use it for.
>
>> If you think copy makes @{-1} problematic, perhaps your copy is
>> doing more than it should (e.g. switching the current branch at the
>> same time, or something).
>
> I think what Sahil is getting at is asking where the @{-N} info is
> stored and why this isn't equivalent to:
>
>     $ git checkout -b one master
>     $ git checkout -b two master
>     $ git checkout master
>     $ git checkout one
>     $ git checkout two
>     $ git checkout - # Goes to "one", not "master"
>
> Which is in analogous flow without this feature that switches to the
> last branch, but with "git branch -c" if you were on 'one' and copied
> & checked out 'two' doing 'git checkout -' would bring you back to
> 'master', not 'one'.

Yes, indeed. I am not sure how @{-N} info is stored and why it's not
doing the expected thing. Expected thing here will be to go to the
original branch from where you copied the new branch if you run 'git
checkout -'.
