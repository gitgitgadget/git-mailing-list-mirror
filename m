Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B2061F404
	for <e@80x24.org>; Sun, 11 Mar 2018 00:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeCKAY0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Mar 2018 19:24:26 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:55002 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeCKAYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Mar 2018 19:24:25 -0500
Received: by mail-it0-f54.google.com with SMTP id c11so6961499ith.4
        for <git@vger.kernel.org>; Sat, 10 Mar 2018 16:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5b2nFnRanGbukFsfR/wHgyu1n+di7g7pVq0zf3Jzhfw=;
        b=Zrex1CJ3rjPp3MZRbIzEkfuqdFoSTPE9E87u2lu4rQHS8yqw/nJoWNfi5V0JKkk0w7
         K5eI6K5KjuLoAECBCsduPEQR0H45pw5p0EJDaCrRvrqjDTtYlWKDmkSNQhFIELyLLmXt
         Qd7kNKoO2gAsEbXVSnMKV3be0tZxilnqSYDp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5b2nFnRanGbukFsfR/wHgyu1n+di7g7pVq0zf3Jzhfw=;
        b=JRGffqxBCfDfzwhv4Ruxf/vAlACo8Pez0xiufVTyWYUupk+XWBvzyf3c9HFAroK4GE
         S/cPR8XQT7lb2g/v4Q3xabUOM2v46eG8dyHMlZ5Uc2IKrU+P6OT8KfL45BNywUJJyKMb
         o9QEk29oF2CxdCuqPaPr0vZEhvfVsEF+sZUYMLBJVZ8cyxhujx/wGRYiyWTyEDjKCY2W
         EY7pK6A6mxi9XE65wpIhedCR5UUwwxYvfKSraZsEL1ei0hTmeL6OyurqxPNUPAtIVtE7
         CQGsJQaOjSwsx3EIlhWBpg0qdeHLgs2MCEADayGbPci/zAOqaZjeP1GiV5nwj2Ymz54E
         Dduw==
X-Gm-Message-State: AElRT7GGNX0F8SYq1PoIEZnT1wn9dP5q/ZoP+ORB8widXspW1OyrMkHO
        Hfq+ynBX/LtdDhgoup0NqKKaElHi4tAwoYmc/uvo22JD
X-Google-Smtp-Source: AG47ELt22w5VEnMTyVRMDhyC8sLslJNytzkN4AvYZCTo1ya/lA09gOl79k537bddb2brWvHVPi4pLQxsd1p9zPC6zYc=
X-Received: by 10.36.192.130 with SMTP id u124mr3426036itf.84.1520727864951;
 Sat, 10 Mar 2018 16:24:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.146.65 with HTTP; Sat, 10 Mar 2018 16:24:24 -0800 (PST)
In-Reply-To: <20180216011501.889-1-rv@rasmusvillemoes.dk>
References: <20180216011501.889-1-rv@rasmusvillemoes.dk>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Date:   Sun, 11 Mar 2018 01:24:24 +0100
Message-ID: <CAKwiHFgA2coikLM1OuJ8wpPGrw7QHRhK+a5Bx3XxA+ruEJCThw@mail.gmail.com>
Subject: Re: [RFC PATCH] cherry: teach git cherry to respect pathspec
To:     git@vger.kernel.org
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16 February 2018 at 02:15, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> This is a very naive attempt at teaching git cherry to restrict
> attention to a given pathspec. Very much RFC, hence no documentation
> update or test cases for now.
>

Ping, any comments on this?
