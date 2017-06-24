Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA14207D2
	for <e@80x24.org>; Sat, 24 Jun 2017 00:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754144AbdFXAQI (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 20:16:08 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35153 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754075AbdFXAQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 20:16:08 -0400
Received: by mail-pf0-f181.google.com with SMTP id c73so30036071pfk.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=m5zkuK68t5rY6syLNHxqam0kYJkFUfbhzFnZ3YHIgxc=;
        b=nKKQh9swHcdJ14FMtvTrstdmFvX/pVAddHKzgVXNIrf44kDjWaDCSsZjpxBS2DgmPp
         BpSfyPV6WskCviWCkGm0rBV+zvRmY5I/fVI+WhXY1nTYSukC69UKEl06yKdPMsQPvbyR
         x1Hu+jPGnEnKIYfIjix3fWc6BW3eOG/wZhBcxXpeQ8chXLzZBgWwiwOpZdcV4raXoS6X
         jKCYcLa2Z/MWgmZH5KH3chD6j9WByxyStKqCnG1ngo9FSzkSyUbH1zYY4oiKAXxfMRYX
         0LpJG0a7UPk+JyJwBXa+1h5XVclR9CgGf4g/n1wP+FeUr8gqybbHTgYoc0nR+bk9JH16
         /g2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=m5zkuK68t5rY6syLNHxqam0kYJkFUfbhzFnZ3YHIgxc=;
        b=KahkLRhylEmQ9f9H/aysugUrjCIsWsey0q32k0GHI6BB4fbao6iNgqPeKNovNeK3T6
         dNENnH0rJmTbEPiw0+dopW+Oxu7R/8QaHnmosCRflDeEcQQe4g2FYipzyTFnIpeg3ClQ
         OVZsYQlkNMAOm2D0pLZR0wcAvLN80aFkaGLTd2qgGTWOkUHf8QWorsEs8ssh1yCX9hxr
         W7GW1BJFJh2T+d6qwchAR78GwmFOocng4REbubHAgC/7XipyKsQS4R8uVDcLFVudNaB6
         Q13By6tw80qmw2v6Hn5Y7VrVNlNUgpup0kQpxqJPftKVdGz+BGLxS1jyd2hEKTt4JL67
         2uow==
X-Gm-Message-State: AKS2vOzAek+DHdJU/m/7lmQ/weTjUbNEpf31Ulc3o3I2pqydnEOmvMja
        154eHHq4NTUxJ/usKEV8Rbua/MdhFiDG
X-Received: by 10.99.141.76 with SMTP id z73mr10688650pgd.40.1498263367415;
 Fri, 23 Jun 2017 17:16:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Fri, 23 Jun 2017 17:16:06 -0700 (PDT)
In-Reply-To: <871sqajrgi.fsf@gmail.com>
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com> <871sqajrgi.fsf@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Jun 2017 17:16:06 -0700
Message-ID: <CAGZ79kaoXf0=Zk6KQPrYMLsdqmqz+v2KitJwsPTiKJsiJ3fTLg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This is good:
>
>     $ ./git --exec-path=$PWD show --color-moved=crap
>     fatal: bad --color-moved argument: crap
>
> This is bad:
>
>     $ ./git --exec-path=$PWD -c diff.colorMoved=crap show
>     fatal: unable to parse 'diff.colormoved' from command-line config
>
> Fixed with:
>
>     diff --git a/diff.c b/diff.c
>     index 7cae4f1ddb..036dbc1c3c 100644
>     --- a/diff.c
>     +++ b/diff.c
>     @@ -278,7 +278,7 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>             if (!strcmp(var, "diff.colormoved")) {
>                     int cm = parse_color_moved(value);
>                     if (cm < 0)
>     -                       return -1;
>     +                       die("bad --color-moved argument: %s", value);
>                     diff_color_moved_default = cm;
>                     return 0;
>             }
>
> But I'm not familiar enough with the code to say if just dying here, as
> opposed to returning -1 is OK or not.

I think this one is 'not good', as it (a) does not help the user a lot
and (b) is not consistent with the rest around in that function, for example

  $ git -c diff.interhunkcontext=-2 diff
  fatal: unable to parse 'diff.interhunkcontext' from command-line config

So instead of return -1, we could issue an additional warning, but this could
be a generic warning?
