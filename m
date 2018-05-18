Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B161F51C
	for <e@80x24.org>; Fri, 18 May 2018 05:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeERFI7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 01:08:59 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:45497 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbeERFI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 01:08:59 -0400
Received: by mail-pl0-f42.google.com with SMTP id bi12-v6so3857312plb.12
        for <git@vger.kernel.org>; Thu, 17 May 2018 22:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FrXDzKKA+DTOWdmJywgVBfSf72UFJUAggoK1UQ+dkyo=;
        b=NLftxj4AWxZ/sMBviwOo+g9vt31kAPHq4uxoxMKifTyQSnEfxusXOHND8XbXu5Nm7q
         hpYEJGJJMeTYAn0NLE7WARRmC7yhahs5jHJ4JC9oEVPFY7a4iQ/QTLxmhMVHcWN1MqNr
         5tOVaBhash8A7bW5oquxcFFhRivq12Gq5eg3x+cPTjmV2zku1JrzBqfFAfAsNsO5rK68
         2FVQM56OeW2tWDaFgQjYLxf58QwgNIuma8556DCHl7FAl4UeUleg/kysfVeq0Y1VAAmA
         BiBcvezGpnfTszTlXJ797d99bn94QYJ7uWx58U7KK7v4i730FX6vaVDLDkm79+i5lQIk
         oJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FrXDzKKA+DTOWdmJywgVBfSf72UFJUAggoK1UQ+dkyo=;
        b=F8evw/J0PGSgQYeiH+2f/boujYju0SqeHhdgMUjtQIW3ubS9+NAA6wU4KcdeZJ8YT+
         EoCAqfcSY547IP+H8IF/L73ijyduJ0pECqHodxa/oVM3xicREmlxbBDJkBn16kt9+tmD
         xdSW22Ez4iSyvEvxmu+2rJb2tD0PmxnWZcxI2ZYBErvDXu3/MgWFseNhH5H4s2SRu+Py
         oCCWm5ounApabncIMD7xVKIJTBpWwa+OMjGzfP9x0k85vS5G2Hnnjney9cs7JpkO8y5B
         HyVVSF8uG89Vyx8+XVcfmFUUv3e82lAJRIRYB2d39fNgXimxTpcdjgGj0/y+sUvkLTNP
         ufbA==
X-Gm-Message-State: ALKqPwcqNc9KzkjkP6V05U9cp/CUcl0Ec3i3/phiU7cYtUd7fL0HGPU4
        EAuBqCThDfrRVTDLb3edOXdwl57jMxqstKP++yU=
X-Google-Smtp-Source: AB8JxZr6Bldb24NDcJPBFcaWnKxaAVb2DSWtt+2SPVyIDG53CEEn+gXwUKNsneFCaIrOSFAoOqk246knmp9Tk+Fm2MI=
X-Received: by 2002:a17:902:74c6:: with SMTP id f6-v6mr8090109plt.7.1526620138765;
 Thu, 17 May 2018 22:08:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 17 May 2018 22:08:58 -0700 (PDT)
In-Reply-To: <xmqqin7m53x0.fsf@gitster-ct.c.googlers.com>
References: <CABPp-BHm4B5vXZGHn_i6Aycvc_PDNWSFxLFo9s-ijb511VY9RA@mail.gmail.com>
 <cover.1526488122.git.martin.agren@gmail.com> <abc39c9991d6df627b40fd8b4fe9812e7ef78d77.1526488122.git.martin.agren@gmail.com>
 <xmqqin7m53x0.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 18 May 2018 07:08:58 +0200
Message-ID: <CAN0heSo80SjjGtC2x9s-TmNY0=W=YWTYxyjeuAQ3utEAEynXeA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] unpack_trees_options: free messages when done
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18 May 2018 at 00:10, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> The `opts` string array contains multiple copies of the same pointers.
>> Be careful to only free each pointer once, then zeroize the whole array
>> so that we do not leave any dangling pointers.

> I wonder if an approach that is longer-term a bit more maintainable
> is to add a new string-list instance to opts, save these xstrfmt()'ed
> messages to it when setup_unpack_trees_porcelain() create them, and
> then make clear_unpack_trees_porcelain() pay *no* attention to msg[]
> array and the positions of these allocated messages and duplicates
> but just reclaim the resources held in that string-list, or
> something like that.

Thank you for thoughts and this suggestion. I will try this out,
hopefully later today.

Martin
