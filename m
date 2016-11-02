Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D7520229
	for <e@80x24.org>; Wed,  2 Nov 2016 01:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbcKBBWI (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 21:22:08 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34345 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbcKBBWI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 21:22:08 -0400
Received: by mail-yw0-f176.google.com with SMTP id t125so713571ywc.1
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 18:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TVNYR4E40cGYZ9L0xLaH7BYZ7EmZAQu09ynzEd4cpyA=;
        b=x7JJuVE+ZZtKdnVmdfp/rXkeP1bFFWojNriaGnt0vosP456SSR+X5aWHhzJnL6FNMh
         +WInISU9b9B60R4RsDc+pZ2zF3QM1A/KeHErxAW3FqdCxS/DosCt3O9EQRPF5lI8TlTW
         1YX9RwopdBMWUkRnu5KMmlBFLofnvdwB7xOacvjOCc6RX+Hzzbz1jnTeaqKvlKdXn58R
         za6B+qeDkcdrcknnw0eiEsgXnkRokOtVggF01UxKwvZmYTdrR02wKA6Sel7XXiunL8bf
         cniVL3M/n9NVNoNiJX6GVzZUSQW6G70o+xznsP7gnEA+thLWVLlTLGyk7RzWLWLPAb03
         efLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TVNYR4E40cGYZ9L0xLaH7BYZ7EmZAQu09ynzEd4cpyA=;
        b=Um0nLoHhRJ/7MN9W41eVoJaGWJKTfT/HaKeBkfK7Nh0t6ECfIbgtH3YJjt9RDevoqD
         BTU2fvPryp1GCUOMdNFLwpTQLh8W8KZg0GTfISWaoNedl3/9G+/KxUQvAsn9Wos1E8xC
         me0bSf1L082i5b4VfsUt3hsFY13QCqUt5YNpIpoNy7vS9W0f6bEqaHYdmvxEN/NV8Aw1
         tQGqaLnYOdfwJZQ8Q/8qSAayrkRuElm/6+UrYCVsQyKHxR2zwSZTVSXznDwx0vMv4aJt
         1MD7Tuk9f0e0jRn6rqAAfKouT9iiQJIwR1OYLvbqbSJqPmYynIyuPGuiqlqrt4otIRUR
         6+RQ==
X-Gm-Message-State: ABUngvdCAKYKHGyaLgGMoDAbtrfeB+5nz6xUd2EjIcWG7CgBza79BAWQ7UnmOcA6PU58o/p4bLl6vxk+DvmCzw==
X-Received: by 10.129.102.132 with SMTP id a126mr748621ywc.160.1478049727241;
 Tue, 01 Nov 2016 18:22:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 1 Nov 2016 18:21:46 -0700 (PDT)
In-Reply-To: <CAGZ79ka6un7nHaNk3F8yp3vFSnB-iGapqLcZ-ZC3EvcKE4DMNQ@mail.gmail.com>
References: <xmqq1sywrxxl.fsf@gitster.mtv.corp.google.com> <20161101203637.3jr73wwpfal4brho@sigill.intra.peff.net>
 <xmqqlgx2or5p.fsf@gitster.mtv.corp.google.com> <20161101205916.d74n6lhgp2hexpzr@sigill.intra.peff.net>
 <CAGZ79ka6un7nHaNk3F8yp3vFSnB-iGapqLcZ-ZC3EvcKE4DMNQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 1 Nov 2016 18:21:46 -0700
Message-ID: <CA+P7+xq0YG5RTg8MSofd4h3AYMxe1OqtSeZeyXUvP_fZEypiSQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.11.0-rc0
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 1, 2016 at 2:10 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Nov 1, 2016 at 1:59 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Nov 01, 2016 at 01:56:34PM -0700, Junio C Hamano wrote:
>>
>>> > As of -rc0, we have both --indent-heuristic and --compaction-heuristic
>>> > (along with matching config), and they are mutually exclusive.
>>> >
>>> > In [1], Stefan suggested just replacing the compaction heuristic
>>> > entirely with the new one (and you seemed to agree). If we're going to
>>> > do that, it makes sense to do so before the release, so that we don't
>>> > get stuck supporting --indent-heuristic forever.
>>>
>>> You meant "compaction" in the last part?  I think it is probably a
>>> good idea.
>>
>> I thought the plan mentioned in the mail I linked was to keep the indent
>> heuristic, but simply _call_ it the compaction heuristic. IOW, to swap
>> out the implementation under the hood for something we know is better.
>
> AFAICT Michaels design is better in every aspect than what I did initially,
> so it supersedes the work I did there.  I would support the swap in names.
>

Agreed, it's much better than the original idea, and results in better
diffs in every single case we could find.

>>
>> We've already released a version with --compaction-heuristic, so we are
>> stuck keeping it forever either way.
>
> IIRC the release notes specifically noted this flag to be experimental and
> may be removed in future versions.

I agree, I think that we specifically spelled out that this might go
away, and so I don't think we're stuck supporting it forever. We don't
even really need a deprecation time frame either.

>
> When not doing the swap of the implementation, but rather remove the
> experimental feature of compaction-heuristic and introducing a *new*
> experimental --indent-heuristic, this may drive the point across that
> these names are actually experimental.

I think we should swap names as "compaction heuristic" is more generic.

Thanks,
Jake
