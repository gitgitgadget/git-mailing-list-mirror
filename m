Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3466201C2
	for <e@80x24.org>; Mon, 13 Mar 2017 08:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbdCMIz3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 04:55:29 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35001 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752773AbdCMIzY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 04:55:24 -0400
Received: by mail-lf0-f43.google.com with SMTP id j90so60718519lfk.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fNfKIim/nDkNee51iF8DhS1S4exea0pAYevOYR6Waww=;
        b=HkpXn9txvPZjqt8vVpQvItcbV+26/qw7ZPV6gbVt2vG1HwH6Zb2Q6jjHwV1rPBKaJK
         U8KZkN5rsWydjW8cAshbIwOGHFfq14qGb9e2jOEmMFFH6DxBjD6RIJ8InoLV36l3kYJD
         zo/N1a3DH61n3QjvBcM3M1ZhKnFMttW0CWFRT0j/S0z66b6yZSoZaopPMVChhg31HQ+U
         /K08TORJC6qwQE+O8V4JUb9b6YMag1w9JQKOkLsQ2iTDIdyHJ0U2KODBtaiVj3/V/laR
         QLQbprBrWBUMTc3jUlQX+wSyhiDR0gvBMTi/nliL10aWI+KyL7KqItQ3wkVFNfA+3axo
         q+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fNfKIim/nDkNee51iF8DhS1S4exea0pAYevOYR6Waww=;
        b=Erj8JoSEzZV8f4YcNjek0zP7h5CO6bCBUE7rnWZoGfwcVihDQJ/OruX2MNrnUExBEA
         DgXjFGYyZOJp5F65If6cDIHzXVMviLHAa2dKu9PFmVJglP91g+pxWSs31BfCTzBBEQXI
         bbdWeK/nte0Z1qRPmlDtWFc1M0kW7s7r4CHkeCfbKSj6tQkxN2czILLNvGQBW20tNcct
         kR1KRDDk+9KJ+2O3HiInRrnz2dpYgigzt2pah7wCGfryfLQ0DM/RNNt6I9KlHTUyYJOF
         dnzOAb1MTzg//gNgv6d19UNsKcrYPP8zQGCACm/UTswQsTpokeDdc9huhSnZq7FljwEl
         89KQ==
X-Gm-Message-State: AFeK/H27AwPaE/WqRZK4BZG4ag60TIF5iU6qaYdBdHxkaXhjiZTm6Hfmoctx31K3pRDGWXhVPm8CfUh6oWRp5Q==
X-Received: by 10.46.22.79 with SMTP id 15mr3225860ljw.119.1489395316510; Mon,
 13 Mar 2017 01:55:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Mon, 13 Mar 2017 01:54:55 -0700 (PDT)
In-Reply-To: <xmqqzigswzk9.fsf@gitster.mtv.corp.google.com>
References: <CABURp0pf=4BE=E7qeOmYAcqJb=qDeGJ1EFyfCf+hDtKjjMD=ng@mail.gmail.com>
 <xmqqzigswzk9.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 13 Mar 2017 01:54:55 -0700
Message-ID: <CA+P7+xp1T0-02=NznW0=Xd_K5_bdtg=nVgtTqT74+EJuncYxSw@mail.gmail.com>
Subject: Re: git-push branch confusion caused by user mistake
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> I think git should be smarter about deducing the dest ref from the
>> source ref if the source ref is in refs/remotes, but I'm not sure how
>> far to take it.
>
> My knee-jerk reaction is "Don't take it anywhere".
>
> Giving a refspec from the command line is an established way to
> defeat the default behaviour when you do not give any and only the
> remote, and making it do things behind user's back, you would be
> robbing the escape hatch from people.
>
> It often is useful in real-life workflow when "git push $dest
> origin/master" does exactly the way it works now, which I actually
> use myself.  Imagine that you have two repositories, use one of them
> primarily to interact with the outside world and do your work, but
> you then occasionally push from that primary repository to the other
> one, instead of logging into the host that has the other one and
> running a fetch on that host from the outside world.  Your "trying
> to be clever when given a colon-less refspec" will force people to
> type "git push $dest origin/master:origin/master" in such a case.
>
>

It might be worth having some warning or something happen here? I've
had several  co-workers at $DAYJOB get confused by this sort of thing.

Thanks,
Jake
