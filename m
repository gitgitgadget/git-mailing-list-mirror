Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4262F1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 14:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbeHPR4F (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 13:56:05 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:41523 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeHPR4F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 13:56:05 -0400
Received: by mail-yw1-f48.google.com with SMTP id q129-v6so3204910ywg.8
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Tlb21jSWE0QgLWiNzbsQ/8ZCe3iPkbzcqSTENkRhWGQ=;
        b=sulAytmDnMMW+lzujEKbs2DxXhPU7kmOSsCu38I2eQxun1laXgvvzEjjA7dDWuob6z
         Tpm9cdQxfJEScCiRCYbLYXyjAitmKGsh6Ga+2a++5NF+//Pa4nFNI6OeQbtgdTZWqvOh
         fDHgQEdkmdxdB3DI2rges6bi+NlODZbtgmY0UC909AoDXiV/SP7d37FE8DHCSz84JE7/
         Hq8LIUgfcQTNTgrezMu6oGjOrRpwob1MCakO3mrLyD2K0Ts1AYb6MBL9In6zJ35s4kFJ
         sMO5bqbaoyIEhzjLyBaD7sD9/DkNrNTl/+Y8LpCDNDwkRpLBd7DcdYhToXPIZa5WpH+T
         yZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tlb21jSWE0QgLWiNzbsQ/8ZCe3iPkbzcqSTENkRhWGQ=;
        b=c0LVWjTVtiDvpbSKAUVjPt28gQp7Lkti3YX3GGjKFMVWiqr14lVWnyeyaS/zLa38m5
         flCQppgqkU13pIXW3vWRzBibW/ZbXtODy+Dx4eLYCTOwAOc3I2oVENF0c7qW+HDmPwm+
         C5nc1AXGx81JuCBo/JPYnIWLhL/jDsm64fH4G3JyY5JrrjDqgF9/mLPuoJR5+Nwd2vXJ
         e6FxAERRwAfFOLT+elD7HPlw2p69gciGniZuoLVGihaH/m7r7uG+zia7nNt1Qhx5SpLw
         KUiGdYsaRDj6Tg41b3zk5XHuWET7/X6R1ZJ0YHb2poE5dPALq2DUGI+cecIhnOqy6ZlQ
         2Wmw==
X-Gm-Message-State: AOUpUlFAICAKn0vIFD1VD4R1djM/DH99RnYVPAFJM3ILlxjHVxKOkGyl
        TkJ00hELSbr8VeBbSb4C0S0nJeWSaqzueC2NpUeVDu/m
X-Google-Smtp-Source: AA+uWPzNoENs74B/KrH/W5yzRlbH/YU+7Kgm7QnR6LUPIoby46btVXne2a4/cl9xR4aCYNMrKWMUIrYAhwS2/7PTyNY=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr16302985ywh.238.1534431423427;
 Thu, 16 Aug 2018 07:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <bc9762aaf57e441e95f9eed4e64799b7@EX13.visionmap.co.il>
In-Reply-To: <bc9762aaf57e441e95f9eed4e64799b7@EX13.visionmap.co.il>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Aug 2018 07:56:52 -0700
Message-ID: <CAGZ79kbqb1b3hPhEzRRvjH65iUXkisfaFyX9EOet6ypWQEFm4A@mail.gmail.com>
Subject: Re: submodules : switching to an older commit/Tag in project with submodules
To:     Shani.Fridman@visionmap.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 4:55 AM Shani Fridman
<Shani.Fridman@visionmap.com> wrote:
>
>
> Hi everybody,
>
> I've got a question regarding submodules -
>
> I'm working on a git project with submodules connected to it, and pulling=
 changes from them every month (more or less).
> Sometimes I need to checkout older versions of the project (tags or speci=
fic commits), that needs the older versions of the submodules as they were =
when I defined the tag. The problem is, that the checkout only changes the =
superProject directories, and not the submodules... I have to checkout the =
relevant submodules commit manually.
>
> Have you came across the same problem? Any idea what can I do?

git checkout learned about the --recurse-submodules flag some time
ago. If that is what you need, just set 'git config submodule.recurse
true' so you don't have to pass that flag every time.

Hope that helps,
Stefan
