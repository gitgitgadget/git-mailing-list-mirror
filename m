Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D03A520986
	for <e@80x24.org>; Sat, 22 Oct 2016 13:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964838AbcJVNH3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 09:07:29 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:33343 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964770AbcJVNH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 09:07:28 -0400
Received: by mail-lf0-f51.google.com with SMTP id x79so172724699lff.0
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aak+xX0nw9ghnw0l8fECTeb9xXeKpf+xnPw1mz/FWEs=;
        b=rxi7bN1KFdK2hS43mB/SgRCzqjMaB57KAsTQnxutKtuVcIHIJXXKHoNv+PbtguzWj7
         gVgMCeAEK4C/p7Tpuv+9Tjl63IpiA5Sc4tGARvTwhT78kwjnBnsha0TnFmM4NBzfRAax
         BHJYgcyO7H29kmaGAMZ3O/kC+kArWNC7OWDEjztlmQqozWQKty993yhhDLNKv04N4HUq
         i5tJUq1nxh0Nxlry/wGZkFtdNXFDz3ETTNGA/M3Y28w5N4uDMwFrSomXByyn++9xihUE
         QEHBaQejo/HJ10ZRxbIqoNjDNLdaY4WDstl7lQqPOdy1LYd+oisACM/U59ALPOkvOfoU
         dixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aak+xX0nw9ghnw0l8fECTeb9xXeKpf+xnPw1mz/FWEs=;
        b=Sh6GXAXURsBdZf4K+klOyRkehMrQsxkezPDylJ0K0VCwcDsPwLw2n3+M5lqeP0Dbxe
         ryQINd6b9EPvYyPcW5E5rOul1+sMZAyubkbyXmefuN0msA/+GZFj3OhlClKJB2ImvKs4
         y22KNNtXDCDR8EPgumFht5S4033yyX1MoDxhKsvk+Yl+vqz5wn97fQiQaYydrbaqY4II
         isz/WVJRIToEckwraMn0nEWq00B2unGNtNjukDWSu5WXGl3gnjakFGtbKvFqX9ridkNA
         og4pGtzyhoequl/kJXkvwAJHrrfPCInqFy2HWAUTQsHgRaqm7GsM9NvPdq9ALEJRj6SP
         vetw==
X-Gm-Message-State: ABUngvd+OE+E9KnkQMS5eUrWUo4QJDzvNYX0fsfwCVdQi8BfB4XaeSeuEMjZMUsCI7QstF4HApSY4CMo2rY1gA==
X-Received: by 10.25.159.141 with SMTP id i135mr2839012lfe.123.1477141646300;
 Sat, 22 Oct 2016 06:07:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.163.84 with HTTP; Sat, 22 Oct 2016 06:07:25 -0700 (PDT)
In-Reply-To: <xmqqeg3aeeqe.fsf@gitster.mtv.corp.google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476998988.git.jonathantanmy@google.com> <8aa456a551bf5cf44cea5ea7e33f32e190c45658.1476998988.git.jonathantanmy@google.com>
 <CAGZ79kYi=+JUqmFyR+Xapwy2bLHtmCX7ZFxd9bGkNHS5tjEdOw@mail.gmail.com>
 <xmqqvawmekhk.fsf@gitster.mtv.corp.google.com> <22e4b88b-5273-99c9-bcb3-0748c17a7229@google.com>
 <xmqqr37aej26.fsf@gitster.mtv.corp.google.com> <5656444f-14ba-b58c-4ad6-e72cc15a13cb@google.com>
 <xmqqeg3aeeqe.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 22 Oct 2016 15:07:25 +0200
Message-ID: <CAP8UFD0XvNx6Brio9muDhOj5+dr=HRbhK_Lmr+k4LUPKrAVC9Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] trailer: clarify failure modes in parse_trailer
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 2:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> That is true - I think we can take the allowed separators as an
>> argument (meaning that we can have different behavior for file parsing
>> and command line parsing), and since we already have that string, we
>> can use strcspn. I'll try this out in the next reroll.
>
> Sounds good.  Thanks.
>
>
> The following is a tangent that I think this topic should ignore,
> but we may want to revisit it sometime later.
>
> I think the design of the "separator" mechanism is one of the things
> we botched in the current system.  If I recall correctly, this was
> introduced to allow people write "Bug# 538" in the trailer section
> and get it recognised as a valid trailer.
>
> When I say that this was a botched design, I do not mean to say that
> we should have instead forced projects to adopt "Bug: 538" format.
> The design is botched because the users' wish to allow "Bug# 538" or
> "Bug #538" by setting separators to ":#" from the built-in ":" does
> not mean that they would want "Signed-off-by# me <my@addre.ss>" to
> be accepted.
>
> If I were guiding a topic that introduce this feature from scratch
> today, I would probably suggest a pattern based approach, e.g.  a
> built-in "[-A-Za-z0-9]+:" [*1*] may be the default prefix that is
> used to recognize the beginning of a trailer, and a user or a
> project that wants "Bug #538" would be allowed to add an additional
> pattern, e.g. "Bug *#", that recognises a custom trailer line that
> is used by the project.

When we designed the separator mechanism, we had the following discussions:

https://public-inbox.org/git/xmqqa9a1d6xn.fsf@gitster.dls.corp.google.com/
https://public-inbox.org/git/xmqqmwcuzyqx.fsf@gitster.dls.corp.google.com/

They made me think that you were against too much flexibility, so I
removed functionality that allowed to put separators into the ".key"
config options, and now you are saying that we botched the thing and
that you would like more flexibility of this kind back.

Anyway I think it is still possible to add back such kind of
functionality in a backward compatible way for example by adding
".extendedKey" config options.
