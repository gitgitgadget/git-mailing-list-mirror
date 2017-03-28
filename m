Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E09F1FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 15:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbdC1PtP (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 11:49:15 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34676 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbdC1PtO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 11:49:14 -0400
Received: by mail-qt0-f172.google.com with SMTP id n21so67650306qta.1
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 08:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/UaxitJFvkJrHFP7ZaMcnPdHFnc6VNAntWLbvh4dM+Q=;
        b=inR1JTHql8izazXKF0FCayykv8jt37Kl4cQV5xmGwnazhw7k8wtfc5HTb+/PfsziGc
         lLcZUqIyCOwKRUvNCIQqUR3F1dA+RfpJaosAwZCmCIhtJSwIJ2kKSFkv1qXGhgQUdZ6h
         QXqF2tess6ml/h+injI2jrfWztgF42+ColsU1m3OC3jlQj5UMMJ17UA/Qy6IukHqISK9
         TdVj9Jd/04VH0o1mehGDHybqAk94UJrtjnTh7mM1LUOgcjGUwBSgZwbJ8QyDc2Epn9JU
         UFnChfVXPe8YGRa1BatXzcIZoloIN9vQkGV08vSeKTNrzO+r8RktW+tIMurbFRf+dM1C
         Rlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/UaxitJFvkJrHFP7ZaMcnPdHFnc6VNAntWLbvh4dM+Q=;
        b=HuODI0ChuEJVDD1szHqEEDj4VfRaoyL+YrHdrBkP82Hlu1w01di87eBR6+cbXAgdzF
         OKUbc9IbYZLskz9r4vwYXTyPk6TQME5/IqGtWgcFnF0xfXgtrHN/glmN990n3zXyzWlA
         pmalTV93MTIcnazO5bZ+gVQ393Rpkk+rTp5JpnqpoF9EcFPO1kpj/z4kfitElXPk6uyG
         GLlkKVsXb+B05lDr2mKqbaDjgcZfj6jev3Yqst7Tknms/NxzU7njHHw/5dJZ/Zt7pt1l
         yqih9YmZT/SeXkscpSzC3b2m6LN3SEDjv0mBiadOiOiaep9gLrYJ/l2pmc575rVneHSl
         1hsQ==
X-Gm-Message-State: AFeK/H34CRrOyXAhj+Qe+Zr20S18i24z4OIv2dCIY5b4zuWyN5TATefB2mKDVMtcwxg1+w==
X-Received: by 10.200.38.72 with SMTP id v8mr28959630qtv.27.1490716152370;
        Tue, 28 Mar 2017 08:49:12 -0700 (PDT)
Received: from mango1 (nat-128-84-124-0-1008.cit.cornell.edu. [128.84.127.240])
        by smtp.googlemail.com with ESMTPSA id n11sm2877751qke.28.2017.03.28.08.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Mar 2017 08:49:12 -0700 (PDT)
Date:   Tue, 28 Mar 2017 11:49:06 -0400
From:   Devin Lehmacher <lehmacdj@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC] Proposal Discussion
Message-ID: <20170328154905.GA19364@mango1>
References: <20170327221707.GA34039@mango1>
 <CAP8UFD19+-xB-tPnY8Njfyci=wztnoZsEgx0UTqrJBEeTj_X-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD19+-xB-tPnY8Njfyci=wztnoZsEgx0UTqrJBEeTj_X-w@mail.gmail.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 07:52:42AM +0200, Christian Couder wrote:
> Hi,
>
> On Tue, Mar 28, 2017 at 12:17 AM, Devin Lehmacher <lehmacdj@gmail.com> wrote:
> > Hello everyone,
> >
> > I am a student studying Computer Science at Cornell University. I
> > already completed a microproject, Move ~/.git-credential-cache/socket to
> > $XDG_CACHE_HOME/credential/socket a week and a half ago or so.
>
> Nice. It would be better though if you could provide a link to the
> thread where your microproject was discussed. If it has been merged to
> master, you could also provide the merge commit. Otherwise please tell
> what is its branch name and current status in the last "What's cooking
> in git.git" email from Junio.

Here is the merge commit into master: 78cf8efec34c419ecea86bc8d1fe47ec0b51ba37

> > I am interested in 2 different projects and would like some advice on
> > them, to help me decide which one to submit a proposal for.
> >
> > 1. `git rebase -i` conversion.
> >    I was initially the most interested in this project but realize that
> >    after having a very busy week last week that Ivan Tham started
> >    [discussion][1] about this project. Would it be appropriate to submit
> >    a proposal for a project that someone else also wants to work on?
>
> Yes, it is ok. Obviously only one student/proposal can be selected for
> a given project, but as anyway the main constraint for us is usually
> the number of available mentors, there is a low chance that this would
> prevent us from selecting one more student than we could otherwise
> select.
>
> You could also submit 2 proposals if you have time to work on more than one.

Ok! I think I will post rough drafts of both proposals sometime tomorrow
or maybe later today if I have time.

> > 2. formatting tool improvements.
> >    There are four different git commands mentioned [here][2] as possible
> >    tools to improve as can be seen in the email. Of those I think it
> >    would make the most sense to extend `git name-rev`. It seems best
> >    suited to the desired behavior. It would need to be extended to
> >    understand rev's that refer to objects rather than just a commit-ish
> >    and also add formatting support similar to the information that log
> >    and for-each-ref can output. Since this doesn't seem like much work,
> >    would it be feasible to generalize and somewhat standardize all of
> >    the formatting commands?
>
> Yeah, I think it would be good. It might involve a lot of discussion
> though and this could slow your project.
> So if you really want to do it, my advice is to try to start the
> discussion as soon as possible, that is now.
>
> To do that you could for example Cc people involved in the email
> discussions, and try to come up with concrete proposals about how to
> generalize and standardize the formatting commands.

I will try to send out an email later this afternoon with a preliminary
plan and to start discussion about how best to rework formatting
commands.

Thanks,
Devin
