Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2026D1F576
	for <e@80x24.org>; Wed,  7 Feb 2018 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbeBGLWC (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 06:22:02 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:39268 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeBGLWC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 06:22:02 -0500
Received: by mail-ot0-f182.google.com with SMTP id f18so460661otf.6
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 03:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QA7X7+HDYbBy/1iSWMa/uEAnAfU77dnba1vkd2EdZ58=;
        b=ba9Le0HtU+w8ket7SzvOaBuQwPleN/B/CvBoUKJLr0dKj6WnN4bbzBmsAACR7TJvxz
         UhC7aaAFZSzCAo0Z1AU7MdTk6rYl0Qb6UwnAg4EQ76vkEGrl0QNeyPc/ihrucZ/BEGEB
         b81ETJEckolE9RvR0snGBQcjKDo1hDmj+NXDosklGVyjNah/UsNZT/rJlD1ohCVGycRk
         0+xeOf2qB/KgHGvisPGjnjmxr5aELJy/VtvZHFzXjNBtCaST+YJYiQfxCvSRI8BRKhI1
         12rti978D9oL6/hyVnQxzepONZbjLBxW55tngq2dyz6HpC73JwfDGW7qxpdzVpWcEhIH
         D1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QA7X7+HDYbBy/1iSWMa/uEAnAfU77dnba1vkd2EdZ58=;
        b=RrcyyJvMvQB3yhRhbZvUSzc7hDwNZ9X3CRcmzbR92t5pZidLnbe4r+FISK8r1KI/z4
         A3DHFZOr5KKb+Qzyvu/G/yagO2K48J1WkljUyeRSDlcAigithdm1zbyZkF7QG3/R+fEy
         0rxUHbScipeNrTYExilLXXwcuc3gRdMY9OzB6yTOXJZgm2P0Qg1c/3mfPkEKqq5+NgNf
         f+B31OCvh0u1g1pDE/zUmEybs98gSyhBnVqWtA0O5+9jpzPuuLOOclWm7F+pmOUpPzuO
         +wuCfzTkcCCs4oA2YGXrbuEzKJIEQ4QrK9x3hreoPP+sqps5zeWYI5lHvR/o7baFITYg
         nntw==
X-Gm-Message-State: APf1xPDddQ0ANlqW0HGCV7py3Xq3T0aKnDbpKlFATqL4fEnVsIUzqST0
        DVf4aIZHigrKY0N6EcUZaUSLHfRq1e+8rHpaip15uw==
X-Google-Smtp-Source: AH8x226YWpygu8kqTjl19HNnZTXuLcfmUSiitbz4pNdVBPWOILi6XxbJVrFRnmLWPu5IUJKnOxNxgzpR94lv0sBlDyI=
X-Received: by 10.157.53.5 with SMTP id o5mr4036343otc.181.1518002521442; Wed,
 07 Feb 2018 03:22:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Wed, 7 Feb 2018 03:21:31 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
References: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Feb 2018 18:21:31 +0700
Message-ID: <CACsJy8Dt_TjfRk05oNW8DXrdn6s_QV8NQZKnnrgGkj3WTN_=3A@mail.gmail.com>
Subject: Re: is http://git-scm.com an *official* git-affiliated site?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 5:54 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   i ask WRT whether it should be up to date. i'm currently writing a
> number of git-related wiki pages, and i want to link to whatever are
> the canonical man pages for various git commands,

I think this one is updated often by Junio (Git maintainer)

https://www.kernel.org/pub/software/scm/git/docs/

> but that site seems a bit off.
-- 
Duy
