Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60488203BD
	for <e@80x24.org>; Thu, 27 Oct 2016 22:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942428AbcJ0WFp (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:05:45 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:36443 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933375AbcJ0WFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:05:44 -0400
Received: by mail-ua0-f171.google.com with SMTP id 64so34470993uap.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o2JAiFTneg7MhhNi/N0UB1FEMQ2mZ2muQ9eXriDSyI8=;
        b=YygulYILoJIFY7sTUmJS8GKezKFUiKVNrQIv/WyKGawbFpbxqcPzbJi/WKRb9OzXU8
         RNCD6odzdJQQGQ1ImkaJH8/jQELc6ncZCQrdzFodm3T/8q7u1h5gWwQENZyIXs63Qt/N
         muXwWBAmoH1uXOYa9MFwMdY7VD+Z/GpjD7PR7qNiYzrHMut3qeDMPoK3GPfZyA3G1frD
         uGBuglonQgC9VtuaOW6cCkB72LOZD1jp6DTwL/d7Ca2sWfjDochByTxJLp6Kb/WZeVqF
         dV9j1o48xlsL1XP6BGGKJ6AFNGLjtxySCCVvgcLOXYug8GDBqAWjGflTb3qwcmHtCc3O
         4uuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o2JAiFTneg7MhhNi/N0UB1FEMQ2mZ2muQ9eXriDSyI8=;
        b=H65S9ZIDrdcnd1iHrsXK0/iqmTgU+fa4sg0WeiPc0Ymly6rpNo6rdOglTAH0FBfxVg
         EAVrlz9sIA9jmgrugRWobI0coJABxCZKVfvNYnXjhQGIUu0mR8gBTa5C0HZFhN+hsNvs
         Al9rM6nCWsbtWHDhfSLZ+y1n74grfWM4v/Xc2ajwqBd2yiDwnt2N7e2oyFTqGpiHfO25
         aKYKjVYxHwxwTQ22ZgEjxEmkwuZwWBc0fe6vLc+SR6sRVrW+cg4/kTFGEl2FHHnJJ69U
         fQtLeK1KspuPmAFmfq5Ci49rdx2W6Bl19nADqmTPuT9h1H0YUx9slWbKwppf7vRnrxEb
         TmcQ==
X-Gm-Message-State: ABUngvdMQ68NWBCtGDlNaZvYvDmjkLDuoQC/3ntUpwULqcJcCvmmzognWZo/gt9CDRQ2/+/dIUbNtQAHVQVOJw==
X-Received: by 10.176.69.99 with SMTP id r90mr9351990uar.161.1477605943782;
 Thu, 27 Oct 2016 15:05:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.205.131 with HTTP; Thu, 27 Oct 2016 15:05:43 -0700 (PDT)
In-Reply-To: <CAGZ79kZAfqxB699MOs6A6RL==Ku-qF7ABiW=eA+TSrqK+8e_sA@mail.gmail.com>
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
 <CAGZ79kZAfqxB699MOs6A6RL==Ku-qF7ABiW=eA+TSrqK+8e_sA@mail.gmail.com>
From:   John Rood <mr.john.rood@gmail.com>
Date:   Thu, 27 Oct 2016 17:05:43 -0500
Message-ID: <CALj-rGeMHyN6Xhc0_KCChmWL4BDyF-ZJYdipbe1_yNvznrYPVA@mail.gmail.com>
Subject: Re: feature request
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unfortunately, in my case I'm on windows (my company's choice, not mine).

On Thu, Oct 27, 2016 at 5:01 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Oct 27, 2016 at 2:55 PM, John Rood <mr.john.rood@gmail.com> wrote:
>> Users should be able to configure Git to not send them into a Vim editor.
>
> See https://git-scm.com/docs/git-var
>
> GIT_EDITOR
>
> Text editor for use by Git commands. The value is meant to be interpreted
> by the shell when it is used. Examples: ~/bin/vi, $SOME_ENVIRONMENT_VARIABLE,
> "C:\Program Files\Vim\gvim.exe" --nofork. The order of preference is the
> $GIT_EDITOR environment variable, then core.editor configuration, then
> $VISUAL, then $EDITOR, and then the default chosen at compile time,
> which is usually vi.
>
>
> So maybe
>
>     git config --global core.editor "nano"
>
> helps in your case?
