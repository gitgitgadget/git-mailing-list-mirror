Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7160F1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 22:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754874AbeCRWvN (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 18:51:13 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:41455 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754837AbeCRWvM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 18:51:12 -0400
Received: by mail-qk0-f196.google.com with SMTP id s78so16490028qkl.8
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 15:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=5HO8vMkkE9GDP2B4B/b0W6UA08OEvBnjdMu3kFKceBA=;
        b=kV22b6gIJ4MhP/G3Wsg0OUHNmaTOB8NhsRA+Br+NVhiyAgv5JNyOY+ImRgKJYu0Gpu
         LITU35cGji0hcbAlWqe4OdHGRyC/rughq4gvd3gaSvGvtOz0MTAS5P19h9rqFkk7m3QZ
         VpXvJtJf7V7OVqR1EuZt4B2HoG84yrjJM6xX2dzX6pId4fXSXVpzUs6jJqalqMPc0DHn
         4xi7Cpv82EygEjs681g7ZY9Jf5nhmdAebpgubJnJRSMg0AGbeb39y3qvuvFfKLJHfWgN
         QLM9/cIVmoajx2GKlakb82Ht3W/nrxGnCpkleoGemcp6Djtor+9ul/bOUOcbjt1Kf4Jk
         dRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=5HO8vMkkE9GDP2B4B/b0W6UA08OEvBnjdMu3kFKceBA=;
        b=m4TyarQ2TyM4RXLw4lglnLdbArOSQMvVZe3J6c1flDV7N+jC/BPXcCuNQvgiYc7iDU
         7ltCl2ZkxuDj6dnG07UFfYVBqV+gKRvtFaAGDQrWI1BWlSNjLqPbj3oCBevOEJVz4Ian
         RPNm5++h/5Fv2qlbV59LxdhJWhqZsrkIaPn/cB3UIUroCGt0FXfRRpKEPWaMDQzRc1/9
         e0fGdvDhETt26enp6uaeCfH++cO93ydDAAHnbitYT6bJjo4AUCmAlxFiVqNUDEfif/mv
         9wjDT+fppYL4Z9G2+QgI21RBGBZOKPmrYqZoYHyD4FGzEn0ZzQyPXWj+ipZ1mvgPRdZd
         SCTw==
X-Gm-Message-State: AElRT7Fa3Au80MYDj2rCtIujxz7+r2d3TnFhb0NL4FKAAXPPlWyFiJDf
        CddDC7S0DhQNlF0shcI61DiR4t+H4dCs58WuAoo=
X-Google-Smtp-Source: AG47ELtLoDGC2dCTBXs17fuYaaIjDlkoA2gbguobGoE25X9l0zopbJG42TYxyu+gWD2Ivt20Zf7hxzVnEuwfy7k5rMc=
X-Received: by 10.55.3.140 with SMTP id 134mr14996199qkd.26.1521413471625;
 Sun, 18 Mar 2018 15:51:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sun, 18 Mar 2018 15:51:11 -0700 (PDT)
In-Reply-To: <20180315164412.14697-3-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com> <20180315164412.14697-1-pclouds@gmail.com>
 <20180315164412.14697-3-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 18 Mar 2018 18:51:11 -0400
X-Google-Sender-Auth: -TDgGZ7kylBs5mpTj3b_6BmpSd4
Message-ID: <CAPig+cSrsc4MhFf_h4b0Rc=hsxux4p=pkQkYVfs_zTR3u7sH-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] worktree: delete dead code
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 12:44 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> This "link" was a feature in early iterations of multiple worktree
> functionality for some reason it was dropped [1]. Since nobody creates
> this "link", there's no need to check it.
>
> This is mostly used to let the user moves a worktree manually [2]. If

s/moves/move/

(Not worth a re-roll; perhaps Junio can tweak this when queuing.)

> you move a worktree within the same file system, this hard link count
> lets us know the worktree is still there even if we don't know where it
> is.
>
> We support 'worktree move' now and don't need this anymore.
>
> [1] last appearance in v4 message-id:
>     1393675983-3232-25-git-send-email-pclouds@gmail.com
>     and the reason in v5 was "revisit later", message-id:
>     1394246900-31535-1-git-send-email-pclouds@gmail.com
> [2] 23af91d102 (prune: strategies for linked checkouts - 2014-11-30)
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
