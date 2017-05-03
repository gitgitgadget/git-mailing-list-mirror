Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E6C8207F8
	for <e@80x24.org>; Wed,  3 May 2017 20:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbdECUAl (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 16:00:41 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:32862 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757872AbdECUAd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 16:00:33 -0400
Received: by mail-pg0-f46.google.com with SMTP id y4so81572pge.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 13:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pr+koyV+plg3+eQj1DJGfH8Tq+EwKhrX4nvhMmZZCWU=;
        b=WpSNVi1PeLObBw5bFewNzh5itNkJr1L+WKWc6tuiq1xxMACxKcs3qXXUCP2uhpxsa5
         krR1P3uQbDjD0HwFYcsX0UDTf1P6C6o3nkMZMhwNgfT55IY0UPRYKy0Cg6J6la9ukW1M
         XEbH0VQMt3zxf8vVD7Hx+QEgo5j4rM2tmGlvNKXwYspqs2HAsPVmcj4auXZLWi5vAhp6
         ZF+JnKlKyLlZv/AixvPhE+ORR71jdvkcZ9ABmvFVaWCQG1Gv7XK1aoEIj8O/OzIy/e0r
         Q4b1cPyn1b7DX+MKA89hHBxDYPiUPX+YVJKW98pPotrPUXIHaAcClo9+Id0o1/TpB3ZQ
         b6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pr+koyV+plg3+eQj1DJGfH8Tq+EwKhrX4nvhMmZZCWU=;
        b=ClohI1nPGCIsLdlhzq6ZnFf//VKf/yN7E+hs6LbIvdwW0lNUxa18RbWSa0dUcnXqH5
         dpEC6bkLPSe564ZSkseaks53JGvTbS0OXlYzI1TMg3cPGBnsEoK3plTyzmsmuhkmoAUb
         pOOT8XEOy0++TC1oK7UZ2WQhK4yCHvbWXZ612+ul0s/UQR1fYCdIzISrukwovyJ80HxL
         3MR9Q/jUmLKTVXdU6vkgSEznh5Q+Ammt6wyptprn9aWWyEVgAptJaGRUzGlDGU0lnO1d
         oFVTSc2m7yx5IAV2t/XkuXptppFFCXU8jMZGsKNzSmHZM4KH6y6zF85iGRk2o/rTzRR1
         d3rQ==
X-Gm-Message-State: AN3rC/6e81zM0tXlgJlVrilmVKjeegVNAdQ2fDTzJ0qNqzdprAYp4cKk
        zjV5PGJwWfO+UbC3mweDu4OvdWgFEM+F
X-Received: by 10.98.90.6 with SMTP id o6mr6757462pfb.101.1493841632355; Wed,
 03 May 2017 13:00:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 3 May 2017 13:00:31 -0700 (PDT)
In-Reply-To: <20170503194708.GE28740@aiede.svl.corp.google.com>
References: <20170503135430.7785-1-avarab@gmail.com> <20170503194708.GE28740@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 May 2017 13:00:31 -0700
Message-ID: <CAGZ79kZHhAsoWKhGHfccspikANjK7z=Zdh1us8r1+hw+4kHUHg@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: set NO_REGEX=NeedsStartEnd on AIX
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 12:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Is there e.g. a build farm where we can check for this kind of thing
> more systematically on supported platforms?

There is the OpenSuse build farm that provides builds for all kinds of
linux distributions, though we'd rather be looking for *all*
operating systems, not just various flavors of linux.

After some research, I found
https://gcc.gnu.org/wiki/CompileFarm
https://launchpad.net/builders
https://buildd.debian.org/

The gcc build farm would include AIX, maybe we could talk to
them to have more CI support on more platforms?

Also you're a DD, maybe we could hook up git testing on debian
to test for different hardware platforms?

Thanks,
Stefan
