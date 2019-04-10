Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C95120248
	for <e@80x24.org>; Wed, 10 Apr 2019 16:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfDJQgG (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 12:36:06 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48]:43913 "EHLO
        mail-vs1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbfDJQgG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 12:36:06 -0400
Received: by mail-vs1-f48.google.com with SMTP id i207so1736223vsd.10
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 09:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zct/ejxB/O9IAqY5Lr4UB2grZ48aDYCRJG6iYrFl0o=;
        b=Rsu92wxjNHCZ1rf7HkaBuHs918RQk8RpqXfK6Qj3GS5tGkOXV8XbNrHqQgveRipZ7M
         u+TbjfS4KcJYnXxO9o+8GeSAsN3splWdLHLRRMM3FATJ/EtFiW5TBS2pjkTcOwGmGli1
         icrrTDPL0MpxAK3xG8lKgCKhOyc+JXtToRiWsZzsTcmysFAzYQYDJrb6JSakrc2ZcxVb
         beGBGOkfPLBsi9v/osggEJ7G1Od6B/LS52jlCgAA569rfvTR3XQJibGDLctAp6uLVJKz
         ZC630VGCdY855iFruAxhCO+8MTqYK3JpTi1F9FXWc2j42HckvDrJI+eIH/eyX8V8Fzeu
         JlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zct/ejxB/O9IAqY5Lr4UB2grZ48aDYCRJG6iYrFl0o=;
        b=AIM7Zyb2JBY2zWZxrx/mkt8dNEeWYKebaqqqwwF6r7/LSZPJGIPsg34L1iEMriOpha
         RyIvF4Mvp+8Jb6DNA0lbK3EYQ/1YfDnNnI9/v4xCTGEmCjZWA3QyUnUp9QcarRWToe8x
         3i9uEvlckTY1UYhhg+J0sIwhmHSbENskgFHc+tDHEN6KssAPo2WmVNs7KR5bmeoJLvcn
         NH7G9ocuuSqvUxEzV6aA1Rfy+NeZVXP2x4AuphRTT2qwjIuNSMxua2RO3mt895nX8gpx
         o82wycq7/HBBoRoL+5YXg2/1w2zzl2xgEFuALCCTv5PnAvkf2eVDTVYg31jMvpAT/gkp
         vmPg==
X-Gm-Message-State: APjAAAWdXhklh+gP0TB7S4g5ZD8gp3yMWZIMqwlsEvWlR5CUAv00E0+k
        Iz6ueSnSqVaChoosgX5Xb25/IdBZeiIWrDwYCTouDqLq
X-Google-Smtp-Source: APXvYqxvr2pWRvc7q2FmHhrljqt+g4m0ywyN3pybERnTRKkJKh6L2O3pRY4qIhr/hQgRry5CXDjiPY11pX+J8/Dy4BY=
X-Received: by 2002:a67:ef89:: with SMTP id r9mr24093392vsp.75.1554914164871;
 Wed, 10 Apr 2019 09:36:04 -0700 (PDT)
MIME-Version: 1.0
References: <32db4d5189264ab791704cce91d6efaf@bs-ag.com>
In-Reply-To: <32db4d5189264ab791704cce91d6efaf@bs-ag.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 Apr 2019 09:35:53 -0700
Message-ID: <CABPp-BEvsBqqQMvb8zAPZ8r+=Wd-2VA0eVuM9FJSoogUP=AZOA@mail.gmail.com>
Subject: Re: repeated empty section in config of repository
To:     Kurt Ablinger <kurt.ablinger@bs-ag.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 10, 2019 at 9:08 AM Kurt Ablinger <kurt.ablinger@bs-ag.com> wrote:
>
> Hello,
>
> I am not sure if this can be problem - at least it is proably not correct:
>
> when adding a key to an empty section and deleting the key so that the section is empty again,
> every add adds the section-name again - example:
>
> git config gc.autoDetach false ; git config --unset gc.autoDetach ; cat config
> [gc]
>
> git config gc.autoDetach false ; git config --unset gc.autoDetach ; cat config
> [gc]
> [gc]
>
> git config gc.autoDetach false ; git config --unset gc.autoDetach ; cat config
> [gc]
> [gc]
> [gc]
>
> Git-version is 2.17.0
> Linux - Cent/OS: 2.6.32-754.10.1.el6.x86_64 - GNU/Linux
>
> Greetings
> Kurt

I believe this was fixed by 4f4d0b42bae8 ("Merge branch
'js/empty-config-section-fix'", 2018-05-08) in git-2.18.0.
