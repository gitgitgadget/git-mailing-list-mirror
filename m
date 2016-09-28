Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B24207EC
	for <e@80x24.org>; Wed, 28 Sep 2016 11:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753378AbcI1LwS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 07:52:18 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:36695 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbcI1LwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 07:52:16 -0400
Received: by mail-io0-f175.google.com with SMTP id m79so53834105ioo.3
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 04:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P7jGua5QNhLaJJzLzURZjNkgCHuDusEjWIModR1LqxQ=;
        b=AjqGhh9nsjHevZm1JvufLWsLjaODXaI2RaWURn+DK6VcC+KJtZ/DYdh+YRMBhyBYuL
         z4IQaASWOD8EC8HE/wP5UE9MJjgwAaHdGp2/Gh81PcXiByY6Mbu3djkIuE1FQTWB2LuQ
         CwaoM3u+ao696dcnqX+q9TQcJzHssIq5lQ+eij3FOfjfwBfKjTAsORqN4eRN5B7PUWbK
         be0J2rVJlRE6Rk+eITlbRZm73yXx3hF6W09c+ZA2+ytmv0+P8MnO8yMWFNp9SxfyDBdZ
         0w2r2XslZowtJr2TMB0PRbXA1AgWhfNDzjUHwo4mKFtHsLp45/V3VpL9RUEXmNWsym9M
         n5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P7jGua5QNhLaJJzLzURZjNkgCHuDusEjWIModR1LqxQ=;
        b=mWBxylbmM6nNV3hiWec5pK/8sawERtn466uCrzVGYVWYHYtsnCJqBr6nCIScuTy8VU
         ry8hjfgSXzF18P+/j4Y8790DwYUitCMNr1Kx70fQ8wLxBxaTndlQsZZ6B5SIIQS45E1u
         c20eYdM34QO+eEvkLTX1hzi2xMcJIXOZanT6VaSVNl6qv5ZQBb1mrF+7IUos44hwdpxt
         4GPgbhXJWea0CpG/b0kvladaXHQCa7g+keYec8U+PR/YC72mzYMjZbLz3HgPtu/pzVGM
         2Lh4GA9Wy3rv0bLV/6zhD1wPhe6/9y+eYjKOsVN5zm7K078PzBY7e293iDYvto0Rb0pa
         hEeg==
X-Gm-Message-State: AE9vXwPyg3+Rrw1Rjy9JSAACT+kPZw3E0U7JZVUMyLCTJKGuv89wjBn942+6w8Cdl31l+6LKCf5z2jqE6jejsQ==
X-Received: by 10.107.30.69 with SMTP id e66mr33745483ioe.107.1475063535389;
 Wed, 28 Sep 2016 04:52:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.21.6 with HTTP; Wed, 28 Sep 2016 04:51:44 -0700 (PDT)
In-Reply-To: <20160928114348.1470-1-pclouds@gmail.com>
References: <20160928114348.1470-1-pclouds@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 28 Sep 2016 18:51:44 +0700
Message-ID: <CACsJy8C_+MeS2LrCejNQFEoHsCPxsSvC_K3mZ6H=_+_ULO291w@mail.gmail.com>
Subject: Re: [PATCH 0/3] i-t-a entries in git-status, and git-commit
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 28, 2016 at 6:43 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> 1) and 2) are fixed by changing the position of ita entries in diff
> code. ita entries should be seen as a new file when compared between
> worktree and HEAD

Big typo. "between worktree and index".
--=20
Duy
