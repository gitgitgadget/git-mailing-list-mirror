Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7FB1F42D
	for <e@80x24.org>; Fri, 25 May 2018 21:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030273AbeEYVTR (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 17:19:17 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35835 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936301AbeEYVTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 17:19:16 -0400
Received: by mail-qt0-f181.google.com with SMTP id j1-v6so8269050qtp.2
        for <git@vger.kernel.org>; Fri, 25 May 2018 14:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=AEBu7TEmyUPILrGSyPcY8WlzdxUC3eA2zX5iFgSX+pA=;
        b=BVrIRX/dkO8nNJIFNJrVNW1jHhGI+b2CEUObtDCcw8+rV9D7Yv/fCUmwPIRlxyzK74
         f4l0UQpwzgBzibkIK4PJ6Zxz66wuSj8FQnvtPNALk3mjabQU1rGJXEit+WtNTqy78FRN
         KZLr9V/p6kiZMz9zuVKe6wlpoedNh5JBKrY8cJgVT2Zq+m3Q833KbjXQW0ExDSGWKopD
         /smxxSkcCZYJFeDKsqFewbFoD0yJ2pDtU5uGsiALn02c9aMErDINKydb8ABqwNMUIPmQ
         HUn8jGYVPDfQEu6lrhFopvBLnYHthIfWxlMQx7qFk+NpzlKsiAdR8cnY0uSIsnFZ3SPI
         a4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=AEBu7TEmyUPILrGSyPcY8WlzdxUC3eA2zX5iFgSX+pA=;
        b=p1RAirypuAlHt7lHdPxlseq+J9cSKEFTn7irSGKV5yl9OLFvomZB3xzwhfGXTVxbfy
         LRq/xjFoFKyMR9aqK7XENq1W7S/3avS912FhnuHU3VRC2Qb+rcQBjojYvJW8LKKp+nYB
         iVHcyirxImQhW0QDVXZiC6V+pSjPpK1yHI/51moP5MZ3A22+28ugvA8TEG89urTppciP
         WFSIxQ/KQKbvYwQQoUMom1UUqPWT10Qe9IkKjA3KB9X76N9Y4NnUAPKeZLV302eYl4XF
         9f4814JuC8NeSMKzx7nzH0E4kNaJXMaO+JTVZBebVuxuwk2KsesiuMAytq8swOxPXLXl
         VUXQ==
X-Gm-Message-State: ALKqPwcYwzcEL3TthYaHhtXuFzYJZRbqRyIqCiYwYjuSrWQw6eSFCNE4
        MCEflZT7MWTiUVygRLejutZEnYcikPoLqiLTsHY=
X-Google-Smtp-Source: ADUXVKJth/0o14OAO+mPPsbryWg/7bHaDWcXhZ71Qwo+juhC001FVxfDAU2+rQJx26G87GCtPIkdMuJOOe43LeqnSr4=
X-Received: by 2002:a0c:b7af:: with SMTP id l47-v6mr3944458qve.110.1527283155572;
 Fri, 25 May 2018 14:19:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Fri, 25 May 2018 14:19:15
 -0700 (PDT)
In-Reply-To: <20180525192811.25680-4-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com> <20180525192811.25680-1-avarab@gmail.com>
 <20180525192811.25680-4-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 May 2018 17:19:15 -0400
X-Google-Sender-Auth: fQXu26eamL1NPxo8nA1vIqBFEGs
Message-ID: <CAPig+cRzFwKrSC22Th4hJtQAcyqT96mcXBpBdRv38_LK4nSVSg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] config doc: elaborate on what transfer.fsckObjects does
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 3:28 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> The existing documentation led the user to believe that all we were
> doing were basic reachability sanity checks, but that hasn't been true
> for a very long time. Update the description to match reality, and
> note the caveat that there's a quarantine for accepting pushes, but
> not for fetching.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -3341,8 +3341,16 @@ transfer.fsckObjects::
>  When set, the fetch or receive will abort in the case of a malformed
> +object or a link to a nonexistent object. In addition, various other
> +issues are checked for, including legacy issues (see `fsck.<msg-id>`),
> +and potential security issues like the existence of a `.GIT` directory
> +(see the release notes for v2.2.1 for details). Other sanity and
> +security checks may be added in future releases.
> ++
> +On the receiving side, failing fsckObjects will make those objects
> +unreachable, see "QUARANTINE ENVIRONMENT" in
> +linkgit:git-receive-pack[1]. On the fetch side, malformed objects will
> +instead be left unreferenced in the repository.

This version looks better. Thanks.
