Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B417E1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbeKTGB3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 01:01:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39902 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbeKTGB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 01:01:29 -0500
Received: by mail-io1-f67.google.com with SMTP id j18-v6so11031194iog.6
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fdhjJhcKp3IWT20Vr11ZvXEA7ctp+mS0yTcK8Qg22aE=;
        b=rODWMeZ1gygBVcmAJtvAek5wEUBfcosPlOwKZPIgUzOZpcPiT9cAUZOGQM8YDt70kG
         2HThi/HQv2+gRxIT/Xtu0PHykAaUNVwNTqvLSiofaLaaBuMeb7fhxHsklQfMapFPgAAW
         U1vlsKNFKzlRIz8KMNlWTM7fDeqsvE/Yy/pV2dEiB+M99QNwdt9OevFIDsoaFt11w2uM
         6g26UZQA6nWV2FoKCeDp4hTnCjnbh/ukr/cGzWXlErjHc3yflwiTH0CFE1W+eG2mJxIn
         gVFGhqwpCLgV+DX+mctc/B3w4hbJyTduI7jpEqyvCh8b2q3HC9SpU9pJTJQOtYtORNdG
         8CZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fdhjJhcKp3IWT20Vr11ZvXEA7ctp+mS0yTcK8Qg22aE=;
        b=NsTioE1/OM6MyBm3OIAfMhKDXdhMUe1R4LBdzCnIMuHd0MFv+PV8NbkIzm6H9EO78/
         THuR/lrOYYIwVNgtlOk4Hr9rSJ5oTDUkLR666nw2knHb3OAh7eav21RC+ina2y5J+Mx1
         IpVd9qsxXGO8J9AqKqqot4cQxbYCrK8ieIc7UStslGZcSdOoGIfSoaLK9r/3bfEw+Eje
         F+DJP7mry/KKZf4JeA1jCxHsD+aR6Cu2M75wZdxnN7Y3yfWFvl9lCnlp9GErdwZw0gf+
         pk9+pNP+tN7mq/hmGXT+NPJw956TJnxbT+vpbCORhHznFP2+ZxQgGABlFXvYzk34FrRn
         j3qg==
X-Gm-Message-State: AA+aEWYratSNlx6djtm4lnVLXruJiqHovmJMVBoNpy5ixS+70T5Ykb3u
        pzLbzF90oIyPzdYNKcP1tcujIF9U6e2zgGNICJ4PQH1W
X-Google-Smtp-Source: AFSGD/WlqAIWy813VAJvRrcXlv1gyeZ9/krpfRAuvvhOyShQ0fNLALPMzYFfTLJ0MS0M9DItIv4b6T/OmYYksCrlPXg=
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr4322530ior.169.1542656183849;
 Mon, 19 Nov 2018 11:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20181119101535.16538-1-carenas@gmail.com> <20181119184018.GA5348@jessie.local>
In-Reply-To: <20181119184018.GA5348@jessie.local>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 19 Nov 2018 11:36:08 -0800
Message-ID: <CAPUEsphLMBpxtJakAhQmdKf04H9X4m-8sBSHNFE_eAngn-44Ow@mail.gmail.com>
Subject: Re: [PATCH] t5562: skip if NO_CURL is enabled
To:     max@max630.net
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 10:40 AM Max Kirillov <max@max630.net> wrote:
>
> On Mon, Nov 19, 2018 at 02:15:35AM -0800, Carlo Marcelo Arenas Bel=C3=B3n=
 wrote:
> > 6c213e863a ("http-backend: respect CONTENT_LENGTH for receive-pack", 20=
18-07-27)
> > introduced all tests but without a check for CURL support from git.
>
> The tests should not be using curl, they just pipe data to
> http-backend's standard input.

NO_CURL reflects the build setting (for http support); CURL checks for
the curl binary, but as =C3=86var points out the requirements must be from
somewhere else since a NO_CURL=3D1 build (tested in macOS) still passes
the test, but not in NetBSD.

tests 3-8 seem to fail because perl is hardcoded to /urs/bin/perl in
t5562/invoke-with-content-length.pl, while I seem to be getting some
sporadic errors in 9 with the following output :

++ env CONTENT_TYPE=3Dapplication/x-git-receive-pack-request
QUERY_STRING=3D/repo.git/git-receive-pack
'PATH_TRANSLATED=3D/home/carenas/src/git/t/trash
directory.t5562-http-backend-content-length/.git/git-receive-pack'
GIT_HTTP_EXPORT_ALL=3DTRUE REQUEST_METHOD=3DPOST
/home/carenas/src/git/t/t5562/invoke-with-content-length.pl push_body
git http-backend
++ verify_http_result '200 OK'
++ grep fatal: act.err
Binary file act.err matches
++ return 1
error: last command exited with $?=3D1
not ok 9 - push plain

and the following output in act.err (with a 200 in act)

fatal: the remote end hung up unexpectedly

Carlo
