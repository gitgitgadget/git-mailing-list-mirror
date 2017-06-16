Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87D31FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 22:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750921AbdFPWPg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 18:15:36 -0400
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33467 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdFPWPf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 18:15:35 -0400
Received: by mail-vk0-f46.google.com with SMTP id p62so29028627vkp.0
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nUuO2LtUr+9Ad0qPzfxnJQ2GmP8WgXz+DOl3UsnMO7E=;
        b=SAkpVPmScPiA2dz3aygB3rVidJ9mMbAn+zYhBQTN93379+y8ZzVSWuP02DzC6cP4hM
         q8NAOELEhanFxh5f7IcCiXyEX6+95ChrGu1KlwhtJtWWrieR0aOoB4vAwoDV7LusFU4z
         iTTLU/tofHLBHJPOwNYjzUXFOfR9RvQuxJ2p8leGdrl4sdp5+G3US41qfo//DiyvI+95
         aURRyxz+w/0ccph+zHBKfzz9VsBWk9x4R7tc00WHxTMXer5fJobwKD2gG1K2Ek3t3zr3
         m3EmMYAhACF+Hh/K2KEjLuOq45lv0nZQPk6M8CsDV3eZ2zJzH3KurJ/g7P7zjLZdcsZF
         fASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nUuO2LtUr+9Ad0qPzfxnJQ2GmP8WgXz+DOl3UsnMO7E=;
        b=U4oTnSp91cBIwrWWpeGwAjhk4FQV7+g19xdnq7C3SpP7t4tLHooIktjr3JuB2/3gWc
         1aaH3JsMq+fKzToI2b28PmkzBp3DhR55ZY+COOYjNYxpmkN8Wf4+Gz/wvoIYbt5uXUsY
         u4KXqRRJiJNbLfZt60XEpqBNVvnPX8Q+lMKsMZYjPP4N6KUPCxWB2XPeWpkoS3+h4k3w
         lfR0fvcoM2mL8myWQfmA3ZhPsbPcOkyzEE5qEoz2Z87QLjttDk2uvaQJgn67brOC0aNb
         uWxFM+GpIBYIX04wKCmB2vdj4DoHvA/DjsuUsVH7UpFhh97/N2RGMp6Gbk3WPMrxbaaz
         359w==
X-Gm-Message-State: AKS2vOyd7hVmPHGEm4yJwIl6pF+cMExmWiWXBeRm0/Pc5Elvft82Mo4p
        9Xcxrhjm1utKeLywjKBg039GV63jsVJW
X-Received: by 10.31.158.77 with SMTP id h74mr7248981vke.75.1497651334624;
 Fri, 16 Jun 2017 15:15:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.80.214 with HTTP; Fri, 16 Jun 2017 15:15:34 -0700 (PDT)
In-Reply-To: <87vanv8wq4.fsf@gmail.com>
References: <CAM0VKjmxtqB2zrWOW8T9O1ReWNPTZA7V3-Dei7GecB3nxVh2Dg@mail.gmail.com>
 <20170616173849.8071-1-szeder.dev@gmail.com> <20170616173849.8071-3-szeder.dev@gmail.com>
 <87wp8b94gb.fsf@gmail.com> <20170616204109.GB133952@aiede.mtv.corp.google.com>
 <87vanv8wq4.fsf@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 17 Jun 2017 00:15:34 +0200
Message-ID: <CAM0VKjm0MY-DrOX+LuPqvk1L5od3g+SFA_k6dh0QT7ZT7HSh-A@mail.gmail.com>
Subject: Re: [PATCHv5 2/2] Documentation/clone: document ignored configuration variables
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 11:10 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

>     diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.tx=
t
>     index 35cc34b2fb..2169e5c97f 100644
>     --- a/Documentation/git-clone.txt
>     +++ b/Documentation/git-clone.txt
>     @@ -189,6 +189,14 @@ objects from the source repository into a pack i=
n the cloned repository.
>             values are given for the same key, each value will be written=
 to
>             the config file. This makes it safe, for example, to add
>             additional fetch refspecs to the origin remote.
>     ++
>     +The underlying implementation of `git clone` isn't equivalent to `gi=
t
>     +init` followed by a `git fetch`, but the two share some of the
>     +underlying fetch machinery.

I think this is unnecessarily technical and detailed to be included
under the docs of the '--config' option.

> Because of this, setting configuration
>     +variables which would impact `git fetch` doesn't have any effect on
>     +`git clone` at all.

This is not true, several such configuration variables work even
during cloning, see:

  http://public-inbox.org/git/CAM0VKjkSMnemwPbFihXiQui3wm_wYmQeQmgYrFs5bfsH=
1jMg1A@mail.gmail.com/
