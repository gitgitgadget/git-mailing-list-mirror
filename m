Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF951F406
	for <e@80x24.org>; Wed, 16 May 2018 19:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbeEPT3n (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 15:29:43 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42054 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeEPT3m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 15:29:42 -0400
Received: by mail-pl0-f66.google.com with SMTP id u6-v6so999652pls.9
        for <git@vger.kernel.org>; Wed, 16 May 2018 12:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XMk8kXv5FVeyhRfpjEi1MGztHBpzQ/SoHstbRN9BxUA=;
        b=D2VqVRrnGXMHpD5/eBIyjZ3b5IskjgOAjzcQ624qkLhyocMIOl74ohz6sl5Q1EFggx
         nEUYDc7w3LHmH6eviweRwyr9NdlX9nfxnS2H0acHL8JkO7vqpcuagZFzLhOZrOwAxsr9
         7OItEtP3USD4Sn76kNtrMn3YLXei8W2fq3MjTSdR+C0KVDOeleQSS+c4KjQnkeXUCVZO
         8UjZZk0+dwsr3k0K6eKdCIsMqdWmZdxKXrXmtDcLE+DJ0KzoBN2yW67lg1tjUCMlI09n
         TVo5BeCfMbYcoyO2U3iSGJeqml18Syw5Q2d9hrUF31qAOHQL8PjsJVRnvjhbPjavojbd
         lFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XMk8kXv5FVeyhRfpjEi1MGztHBpzQ/SoHstbRN9BxUA=;
        b=tVIwmJzutVIWQQzTjtOALKvow1dpgirs32uh52kSW6Eq+Bo3n9ziG5IWcYUSnV/Usy
         Z+vJ/Awcx6jLglRT4n8BYw0q4sDK1fxcSZOf0UQYYwSmm6SgQ3GOi0rQ0+PfLdz+ll87
         oOSuFQJxy6NdfzgqVfb6LJ8NMnSuzyVTnl2AMq/Ae3QL3LFkqFfqw3rq1YuUyBZL2WkK
         8f1drCg5/x1R+3DUb+EJzqJJ8/PISGg6CKUvxTy1Hz+VegVcwMAD1jDMfMfDR7uG4K0Z
         GJrKG5hTsPmO6maVGmX5HqrL/2HuK1PfuiayNzj1QgEgdwe2hNWx67Dz12abS3qSaXjt
         jmkg==
X-Gm-Message-State: ALKqPwf27ZQJTSXFIX30x80l5qJHA/6dY19TjGjg1wYN222kX5vOZ8jM
        32BsJ0wMNTIb8Eq50Ui8wDf3M+NyOF37/1LZv4M=
X-Google-Smtp-Source: AB8JxZp8Oc5nGNia0SskelkMqiE4jHZGMOTRM31kVDs5CNSXxn7OOH39KizHMevabMcJRaVSi2cbwA/uvIpDbXauIWk=
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr2183818plb.298.1526498982174;
 Wed, 16 May 2018 12:29:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Wed, 16 May 2018 12:29:41 -0700 (PDT)
In-Reply-To: <CAGZ79kYBykcbzKxc_FHiL6dt=jkmK2Khe-e5aSxFephe=RsBFA@mail.gmail.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
 <cover.1526488122.git.martin.agren@gmail.com> <0b7440f21e9ff7a066802fe1e7cb3078cf4ed2b8.1526488122.git.martin.agren@gmail.com>
 <CAGZ79kYBykcbzKxc_FHiL6dt=jkmK2Khe-e5aSxFephe=RsBFA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 16 May 2018 21:29:41 +0200
Message-ID: <CAN0heSqdVB3SmQnBeJB06f4uXzUBM6OC2ySZNZnhJdisbR28Kg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] merge: setup `opts` later in `checkout_fast_forward()`
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 May 2018 at 18:41, Stefan Beller <sbeller@google.com> wrote:
> On Wed, May 16, 2018 at 9:30 AM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>>
>> This patch is best viewed using something like this (note the tab!):
>> --color-moved --anchored=3D"      trees[nr_trees] =3D parse_tree_indirec=
t"
>
> Heh! Having a "is best viewed" paragraph is the new shiny thing in
> commit messages as 'git log origin/pu --grep "is best viewed"' tells me.

:-)

> Regarding the anchoring, I wonder if we can improve it by ignoring
> whitespaces or just looking for substrings, or by allowing regexes or ...

FWIW, because my first naive attempt failed (for some reason I did not
consider the leading tab part of the "line" so I did not provide it), I
had the same thought. Ignoring leading whitespace seemed easy enough in
the implementation.

Then I started thinking about all the ways in which whitespace can be
ignored. My reaction in the end was to not try and open that can right
there and then. I did not think about regexes.

I guess this boils down to the usage. Copying the line to anchor on from
an editor could run into these kind of whitespace-issues, and shell
escaping. Typing an anchor could become easier with regexes since one
could skip typing common substrings and just anchor on /unique-part/.

Martin
