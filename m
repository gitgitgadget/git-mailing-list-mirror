Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A506F202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753094AbdGMTrj (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:47:39 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37753 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752880AbdGMTri (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:47:38 -0400
Received: by mail-it0-f53.google.com with SMTP id m84so3458439ita.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y1Q+mXqw5635rqrA/TSxyuhzVYh5mMBQYoQKnLscQrE=;
        b=gmJrRUI+xtlRNdF/j0k9TgxZ+g2h8mSn3966NCQ41SW/ERuYBA5Mdpv2mUO2SorzPl
         1rQ9HrISqSA1/2nGhZ7yCCZviso8hqwSBNlN0FQEwZWm8MU/AO7l9huPDIGWxYaS1Nc9
         mWecXMVN+FT/nM0c4FJ3QYbQK9C8yN8aDyoz01C/AKQoEQEnKTkTV8LbsDtgLUdDHNvA
         /RgpDFpmlT7Uo0Qk9gPmPBjj1EqgLSfq9CIDBAKQzHJu1s9qaCyEMB1B5LmDtdnsmoZm
         h2sBmZREJUJTx1QFc6JAug3+5dUBrPyDZ6I3NY14R4+H0VCkG4hKbDPzhImmJciZ2G4a
         6cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y1Q+mXqw5635rqrA/TSxyuhzVYh5mMBQYoQKnLscQrE=;
        b=MkOCJkvv9RAuqClw+0UsExAYw6Uh0nXGF9bv5IFBZU7TgGBpGafA+eSwJMLQRw0PUk
         ins471Jsh5IwEYfUg7H0DGzdgW4F1whxJR1XydCpxkI0tZsaL4XMpaYn8Gcw/YGD6XNh
         8WkkKYh4Zlvg1QLHbvPVccRtlIs5AjDOQF7B1JVhUmg2c8CZwsR8SMS1T2v9W5ciTRHR
         gNoX3d9iLIqABraU3y+eIwDeMhlTcOdqaCE2qggf3F5aR3i7hcct8/+TcUB6GRpC5Du8
         QCtF1/D/0S8TZhrp3NAOtcAfFVAwFjSjceKdaWELoEuVzkAWm3IbYN9ZKh+jjq+shj+I
         1/vg==
X-Gm-Message-State: AIVw113SeOUaS3yzI/tinY1GrdBXHAaUgN36MgnjZa4CpMdzKckWIKDL
        N9MwDkn6bYRIiNoM7ca3M+awcq3eWhux
X-Received: by 10.107.12.13 with SMTP id w13mr4758687ioi.207.1499975257671;
 Thu, 13 Jul 2017 12:47:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.138 with HTTP; Thu, 13 Jul 2017 12:47:36 -0700 (PDT)
In-Reply-To: <xmqqiniwxkmj.fsf@gitster.mtv.corp.google.com>
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
 <CAGZ79kZaf7=uwCPJoPoDiAO9QS21bchaKZvDzWJi=ewPZw9PXQ@mail.gmail.com> <xmqqiniwxkmj.fsf@gitster.mtv.corp.google.com>
From:   Nikolay Shustov <nikolay.shustov@gmail.com>
Date:   Thu, 13 Jul 2017 15:47:36 -0400
Message-ID: <CAEcERAxJRnB55Ardhs7LDW8M8EG-y+YE-He8hiiQv3wDqtVD3g@mail.gmail.com>
Subject: Re: "groups of files" in Git?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For me the roadblock for multiple iterations through merging of the
different parts (S, C, then C+S) is the time that will be spent on
rebuilding the mainline.
That's why I would like to have C+S in the same source tree then run
tests for S, tests for C (if they can be run standalone) and C+S
tests, then tests for whatever other pieces may be affected. (As I
mentioned, there are more layers than client + server in my situation,
e.g. client  + transport + server).

I am not really try to ignite the holy war between Perforce and Git
(and why would one???), but if you are interested in the answer on how
you'd do your scenario in Perforce, it would be: "use shelved
changelists".
In Perforce, you could "shelve" the changelist, similar to "stash" in
Git, but the difference is that the Perforce shelved changes are
accessible across clients. I.e. the other developer can "unshelve"
these pending changes to its sandbox (to the same or the different
branch) so that sandbox would get the pending changes as well. That
would be like the developer made these changes himself. Whatever
automated/manual process is involved, it is typical to run "a trial
build/tests" on shelved changelist (i.e. uncommitted yet files) to
verify the quality of changes.
Git achieves the same through the ease of manipulation with branches
and I like the way it does it much more.

My question was about how to robustly handle "multiple pending
commits" which in Perforce are represented by concept of pending
changelists.

On Thu, Jul 13, 2017 at 2:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Jul 11, 2017 at 8:45 AM, Nikolay Shustov
>>
>>> With Git I cannot seem to finding the possibility to figure out how to
>>> achieve the same result. And the problem is that putting change sets
>>> on different Git branches (or workdirs, or whatever Git offers that
>>> makes the changes to be NOT in the same source tree) is not a viable
>>> option from me as I would have to re-build code as I re-integrate the
>>> changes between the branches (or whatever changes separation Git
>>> feature is used).
>>
>> you would merge the branches and then run the tests/integration. Yes that
>> seems cumbersome.
>
> Sometimes the need to make trial merge for testing cannot be avoided
> and having branches for separate topics is the only sensible
> approach, at least in the Git world.
>
> Imagine your project has two components that are interrelated, say,
> the server and the client, that have to work well with each other.
> In addition, you want to make sure your updated server works well
> with existing clients, and vice versa.
>
> One way that naturally maps this scenario to the development
> workflow is to have a server-update topic and a client-update topic
> branches, and separate changes to update each side with their own
> commits:
>
>              s---s---S    server-update topic
>             /
>     ---o---o----o----M    mainline
>             \
>              c---c---C    client-update topic
>
> And during the development of these *-update topics, you try three
> merges:
>
>  (1) Merge S to the mainline M and test the whole thing, to make sure
>      that existing client will still be able to talk with the
>      updated server.
>
>  (2) Merge C to the mainline M and test the whole thing, to make
>      sure that updated clients will still be able to talk with the
>      existing server.
>
>  (3) Merge both S and C to the mainline M and test the whole thing,
>      to make sure the updated ones talk to each other.
>
> If there is no significant development going on on the mainline in
> the meantime, (1) and (2) can be done by trying out S and C alone
> without making a trial merge with M.  The same for (3)---it can be
> just a trial merge between S and C without updates that happened on
> the mainline.
>
> I'd love to hear from folks in Perforce or other world how they
> address this scenario with their system.
