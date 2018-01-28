Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9ECB1F576
	for <e@80x24.org>; Sun, 28 Jan 2018 07:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbeA1HZm (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 02:25:42 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:39163 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeA1HZl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 02:25:41 -0500
Received: by mail-qk0-f180.google.com with SMTP id c69so1981022qkg.6
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 23:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ACNm2SSfnROVLINSuqkB3TSSw1DITb349hNiljcPQ5Q=;
        b=bQxy3X29juMBS41vEIhQOy9wbSk/qJEljMXWZSIj6UMNNF3/C4OiCH7YIf2SjIE05b
         kiOKpHEsnVRiCeRQrfjYUrmWmDkOkn8O+oQ9vQahHGRa6SRq5/xRHWhZ0FsuGbO4AK5c
         +91zsNXh4Idx8cC7PJfTfBOwYSn+syvAT4BVhTmoMrtcuyvP1Gn1wwjjZENC04BQtJP8
         BcBQmgJDqlH9V3SEdZxLwqLX2s22sa8KLNJ8cbMFOEYfB9SP0hbN0F/W2om0Zh07tDKZ
         6CGgfS0gEAAVDZuKe9Ku3oB4m1LrarlUzvTeTsTJrHa5LMMi2wgV+A7nYqkYcwPunBeR
         mxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ACNm2SSfnROVLINSuqkB3TSSw1DITb349hNiljcPQ5Q=;
        b=U7kyScTlZaELECNpxfH2ymRoWf6IX5iJokWoT4qzaHzW8F5hjoLu3DZbjyRLqbp0X/
         WTwnpM0Qh6iSQGhyVuHJZx9J5MnkgWlJW0KfNK8MB71yOp1kbiIz/sHEUHq7r3Trf8YC
         88QQ/qajuxkEEbr1cFLwDvqE5DC5Qib9JaGR7nwQ6HhDNbHyzXHahNALviePokaDhcGE
         irQiZF8IpxemZ9s8u98R7QgQjPZ7kYg2yDIqi7/jTn5KVLA1oPRT9wmO3cVWsiQ/2dML
         qZ7ts/zo9yTH4I/5yuaqXub48GqjQ9geX+GRVZWGjguKRFPpzoVtkKL12ZfOrTkuKlLC
         YHLQ==
X-Gm-Message-State: AKwxytf3xxgJpfip4bBAyRreWCzcw3PVj+FjPIYVTc+Iv2193Ct7K+V8
        rcLrexUyIq5UfcayPlusjxqBFf2NpQKMBj68OzzI3g==
X-Google-Smtp-Source: AH8x2279JmbvhbU4hmkMb6iKKwn4+4UhKR5td8GMgDFTai9AG6L8TXVu7QuCB9VolpOswLuVJHirI+0zJgIpnEMgq0I=
X-Received: by 10.55.177.135 with SMTP id a129mr30430129qkf.112.1517124340636;
 Sat, 27 Jan 2018 23:25:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Sat, 27 Jan 2018 23:25:40 -0800 (PST)
In-Reply-To: <54fd6a226955dc427bb25d5be37b4b0a.squirrel@mail.jessiehernandez.com>
References: <54fd6a226955dc427bb25d5be37b4b0a.squirrel@mail.jessiehernandez.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 28 Jan 2018 02:25:40 -0500
X-Google-Sender-Auth: Vi9wr2nd5-YYur3Pyu2kD0XBgSo
Message-ID: <CAPig+cSP0UiEBXSCi7Ua099eOdpMk8R=JtAjPuUavRF4z0R0Vg@mail.gmail.com>
Subject: Re: Creating sparse checkout in a new linked git worktree
To:     git@jessiehernandez.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 11:11 AM, Jessie Hernandez
<git@jessiehernandez.com> wrote:
> I am trying to get a sparse checkout in a linked worktree but cannot get
> it working. I have tried the following
>
> * git worktree add /some/new/path/new-branch --no-checkout
> * git config core.sparseCheckout true
> * <add the directory I would like to checkout out to
> $GIT_DIR/info/sparse-checkout>
> * cd  /some/new/path/new-branch
> * git read-tree -mu sparse-checkout
>
> But I still end up with a fully populated worktree.
> Is there something I am missing or doing wrong?

The sparse-checkout file is specific to each worktree, which allows
you to control "sparsity" on a worktree by worktree basis. Therefore,
you should create $GIT_DIR/worktrees/<id>/info/sparse-checkout instead
(where <id> is "new-branch" in your example).
