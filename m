Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 801F81F597
	for <e@80x24.org>; Fri,  3 Aug 2018 12:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeHCOQo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 10:16:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44884 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbeHCOQo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 10:16:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so5213219wrt.11
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=QF1HjX9JxipbIY0QyUhkKTCBvPStRzBQdp4f3UJNGqQ=;
        b=b6x3z0u4xr/B4FQho7Pua8rI/0JEAgHhiMpjChhLtgxL1qwv6ejDjDNCNELOEEYg78
         ZovBdFUY+uMtDQKb1CkSWu3XL4xcy2Kd55g4/CICn3K4GvKrXHQxJYUbqOkhNhPkVTHi
         XIFBha7RC4+GsEwFJw1GMstAY0Dxr2w2bWZF66UA3AO2TzjmnSaM1+zxzArjr47w50Ho
         +m/g2ihC1TTvEdJQAJ13CibnmMQYvsPdV9FFz8UIIT4CaB+TJUJWAeujbg3nwWdGe9pN
         CEeXif9WVpWOfXMF6gjNN6wa3i5amWWapeHxZnLcbEfF+EdzFVGIw/D91L2FaZbKJ7tO
         OQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=QF1HjX9JxipbIY0QyUhkKTCBvPStRzBQdp4f3UJNGqQ=;
        b=puMh3HKKLwKJgiWjMAO1NM6+dsHlS7Qft7IejW4dPakWbcpWQrp3oLPazi2qV3OEZM
         QZl4r+ud772zdXBt4fVYXPn/hAXEWlZXlyhTi9Xk1+nx4G7YOSepPbxzox6Ho31QTro2
         iJEJNVltfnB/LT+ulhIQZsknxs449KKzBfQNyD/Gp2ndLH8Ue2zlzrRsNocnFtzVPhZc
         xysDlhV3TdMxDNm/KCYC7WZJohrKBAhucA16oVwNWvuuD7d4lyWg71fH077wtNinY8pw
         A/kzzBpEo2LFOss0QwlYdmTKocDvLeC3lg2XySoWyaBS84CWAEaQzIs7nFbiD/axW8wd
         IkUQ==
X-Gm-Message-State: AOUpUlFBalxN7lKZGXDMkiNOjf1TjJpv0TyETWgPVkyT5sV1pthc6b7l
        9Jv+B9+/MIwAi2LkSSO7bAM=
X-Google-Smtp-Source: AAOMgpcuPzZXiomWsSy9C9IABVfqvYdaI6ea1bcWqOo1461/B8hwHhiGHenRthDgn+UbBxWNpPc0zA==
X-Received: by 2002:adf:e190:: with SMTP id k16-v6mr2496930wri.36.1533298838354;
        Fri, 03 Aug 2018 05:20:38 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id c15-v6sm3063390wmb.2.2018.08.03.05.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 05:20:37 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin Mosegaard Amdisen <martinmosegaard@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: git-describe abbrev documentation mentions wrong default
References: <CAAVPhBmg1=dhGPougT2fXPdA+ogenrS8T3YhbpwzTfurxcn+HA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAAVPhBmg1=dhGPougT2fXPdA+ogenrS8T3YhbpwzTfurxcn+HA@mail.gmail.com>
Date:   Fri, 03 Aug 2018 14:20:36 +0200
Message-ID: <87a7q3tze3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 03 2018, Martin Mosegaard Amdisen wrote:

> The documentation for the "git describe --abbrev" flag says that the
> default value is 7 hexadecimal digits:
> https://github.com/git/git/blob/master/Documentation/git-describe.txt#L63
> and
> https://git-scm.com/docs/git-describe
>
> I have experienced that sometimes I see 7 digits, but other times more.
> The behavior seems to have changed in git 2.11.0 ("default abbreviation
> length"):
> https://github.com/git/git/blob/aeddbfdfa48443c034a9b28b10dfddf2f71b907f/Documentation/RelNotes/2.11.0.txt
>
> I was able to trigger different behavior using a bash script like the one
> below:
>
> ```sh
> #!/bin/bash
>
> DIR=test-git-describe
> rm -rf ${DIR}
> mkdir ${DIR}
> cd ${DIR}
> git init
>
> # One-time test results I have seen:
> # 10 tags, 10 * 10 commits: 7 hex digits
> # 100 tags, 100 * 100 commits: 8 hex digits
> FILE=foo
> touch ${FILE}
> for i in `seq 1 10`; do
>     echo ${i} >> ${FILE}
>     git add ${FILE}
>     git commit -m "Tag update number ${i} to ${FILE}"
>     git tag -m "Version 1.0.${i}" -a 1.0.${i}
>     for j in `seq 1 10`; do
>         echo ${i}-${j} >> ${FILE}
>         git add ${FILE}
>         git commit -m "Update number ${i}-${j} to ${FILE}"
>     done
> done
> ```

Yeah this is a documentation bug, and as you note it's describing old
behavior we no longer have. I was on the fence about whether I should
fix this in my WIP 20 patch monster over at
https://public-inbox.org/git/20180608224136.20220-1-avarab@gmail.com/
(which I need to re-roll), but I no longer am, I'll track down these
occurances in the docs and fix them, as I recall there's around 5-10 of
them in various places.
