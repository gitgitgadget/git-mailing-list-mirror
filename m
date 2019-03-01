Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2FD420248
	for <e@80x24.org>; Fri,  1 Mar 2019 13:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbfCANOc (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 08:14:32 -0500
Received: from mail-pg1-f181.google.com ([209.85.215.181]:39880 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfCANOc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 08:14:32 -0500
Received: by mail-pg1-f181.google.com with SMTP id h8so10930426pgp.6
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 05:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x2bj9ZfVbnu3yjyEOMSqy5S9E2qDZVGeodjIWvKKM18=;
        b=UvV+NIy+NAbGTkQ5qdy06fuFaP5lN8LgMaZXk1xG/mh1MwHtW42ontf2A8Z8TMW6zc
         mU+8dHe5puDkvlYww+QQjcwPAnFjrJuW/y7+KSBI1AM6pN3IHTP6s0Apqqhm5jmWIjrn
         n5tSbRO/y1ZfNsiN/rDVUbBqZCp7iL8lgRggQ+4VZxiGQgj0shhSz//W2a8kDYHeDstz
         IkHP7340ln0bl63ZOANFdlPqQ4/PvFDj74RG0nlctwbkkSJalJMyBHQfm9q7cMy2+Jr/
         DWJ4omlfFD7y9+P1JetkoTX2E+0AZ2gRSWE1jnXRk79KgCKOrR9qwyS/4fnlk/Z13+/j
         R/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x2bj9ZfVbnu3yjyEOMSqy5S9E2qDZVGeodjIWvKKM18=;
        b=KoPqZJ/auiaaMQYeFFPV7KAfzWlfUqXzETw8Nrr2Eu+s77S0fNpl9ieMaYGAnwhgQy
         jTIbNOp85PmCs1FSJGYt8qJqj2wBROCQVeZE/bw1lZr9+Mcz2aBtIOGWQQd2Zz6h5Uru
         G3mS6e60siW8LLYZnLVX/+cu1RcEgO6qTFFdmbw3A9ysxcnhQayOHMXuD1eJb9gGWNNM
         ZnjiLZJcDhn2/KloXZdY7TwbdqvndtEYH3GBsH32fJC5sgw2pZVZPwykFa92MZlJtcwk
         JfR90Jy/K9oHCtMTLaXMBz0K9EJwmhL2J2p2ofD/CtkAdXaGmKytlr2MugbufnoSPPQY
         cBNA==
X-Gm-Message-State: AHQUAuZCk1RgG1w1OmNAGgjaDJFe33YEcuEjm9dHe5wmCRJ6V1mkZvN4
        MwzDY7L84U5QMRvo34QZq174om9uBag=
X-Google-Smtp-Source: AHgI3IZGlNgEEi/gTUx3ulRf+SH97zCPRJVbKaZVIqk6wakgukrys+ifiYKBqeeN92kR2DEOwS5aXw==
X-Received: by 2002:a62:17d4:: with SMTP id 203mr5423196pfx.244.1551446071811;
        Fri, 01 Mar 2019 05:14:31 -0800 (PST)
Received: from ar135.iitr.local ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id c13sm19681201pfd.121.2019.03.01.05.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 05:14:31 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     gitster@pobox.com
Cc:     Johannes.Schindelin@gmx.de, git@matthieu-moy.fr,
        git@vger.kernel.org, martin.agren@gmail.com, pclouds@gmail.com,
        peff@peff.net, szeder.dev@gmail.com,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Feeling confused a little bit
Date:   Fri,  1 Mar 2019 18:43:26 +0530
Message-Id: <20190301131326.7898-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <xmqqef7r9uil.fsf@gitster-ct.c.googlers.com>
References: <xmqqef7r9uil.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey!

I'm a little confused as you never provide a clear indication to
where shall I proceed? :-

On Fri, 01 Mar 2019 11:51:46 +0900 Junio C Hamano <gitster@pobox.com> wrote:

>
> Simple things do not need that many letters to tell ;-)  The
> suggestion of 72 is about the maximum. 
>

Totally agree on this!

>
> I think you are talking about t3600, which uses an ancient style.
> If this were a real project, then the preferred order would be
>
>  - A preliminary patch (or a series of patches) that modernizes
>    existing tests in t3600.  Just style updates and adding or
>    removing nothing else.
>
>  - Update test that use "test -f" and friends to use the helpers in
>    t3600.
>

Yes, this is a microproject after all. But I think I can work on this as
if it were a real project, should I proceed according to this plan? (I have
a lot of free time over this weekend)

>
> If we often see if a path is an non-empty file in our tests (not
> limited to t3600), then it may make sense to add a new helper
> test_path_is_non_empty_file in t/test-lib-functions.sh next to where
> test_path_is_file and friends are defined.
>

Since my project does not deal with `test-lib-functions.sh`, I think I
should not edit it anyway, but I'd be more than happy to add a new
member to `test_path_is_*` family.

Thanks
Rohit
