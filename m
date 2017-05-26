Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A862E209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762627AbdEZDsl (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:48:41 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33196 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760440AbdEZDsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:48:40 -0400
Received: by mail-pf0-f182.google.com with SMTP id e193so185348809pfh.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XaaLZeccNvZecXIgeUbCbs7RyG8mtcj2gDOkK16o7hE=;
        b=ciAcVjwGVBaCWKntY6xMVTF+NuhM8BmNLw0vmkGq5yLLVd3SEcZmnMVO7V547azVlt
         pNW9lSsbzhGfZ/rvFbtTyBmINMw9AiI6SVASHFBHEQ/3ufAUMkDuJeaSEygbiS+mh1kk
         ROe4fu9BbSIpik466CqANzbPH6/QxpUeHRRm5vb4Fes57zKcdwF7swSSzW7g5v+bDHkZ
         FfJfL1gKyHDHJW6GDfYMmjBi+8iHn5ile+1KCW/WjFAwqmt17haFWwbj0dJ4aWF9UKyI
         vfYZ1X8qe2TzzfkG163pAHQhlmkUPw3D0qU02ic/3JI/tMV+x/D2JQGetRWQlNO+r71c
         Bh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XaaLZeccNvZecXIgeUbCbs7RyG8mtcj2gDOkK16o7hE=;
        b=PNnJhYh8a5z2IOQBnKPsyZ0E4HJ31mCtQjCWBQFm1Re+s+H2sY64/3NgYUOZQKWr2h
         xpH9GVMzipaIaTUtYnsgSCmMa7JHdSD6p7DKsKL+2dkd9uKNBHsV9nDdvsM1Nm3H9lTv
         HfvapkT8ZzPVnJsj6m4Nh/mmYWwNP7Mr05jkAso2yz8JhCbdb65aAmEMyJJp04eR/Iex
         TpwzgOokA7RjZB8i911v0cd7NIttwIt3bMV7LrpcdwWVFTiu0w0Is3Jy1ipDlEP/vMFv
         7tvW/qWvrgIWYnHaH74reOsrkhA7gKdDyvmc8YPLoW3IyLyvVAzvvtuCi++Y5dbgi4Xz
         w4kQ==
X-Gm-Message-State: AODbwcB3uxA2lZdKO85Vnvcq8WtV2B1UovQBxdrWKUqKhNb1XsRGIN9r
        GswjHaFCpnPqKQ==
X-Received: by 10.99.42.68 with SMTP id q65mr806593pgq.78.1495770519300;
        Thu, 25 May 2017 20:48:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id b24sm18745930pfm.17.2017.05.25.20.48.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:48:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs/config.txt: fix indefinite article in core.fileMode description
References: <20170525232046.3421-1-szeder.dev@gmail.com>
Date:   Fri, 26 May 2017 12:48:37 +0900
In-Reply-To: <20170525232046.3421-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Fri, 26 May 2017 01:20:46 +0200")
Message-ID: <xmqqvaoob7my.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Obviously correct.  Thanks.
