Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8D41F404
	for <e@80x24.org>; Wed, 31 Jan 2018 01:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbeAaBEy (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 20:04:54 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:37771 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbeAaBEx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 20:04:53 -0500
Received: by mail-yw0-f169.google.com with SMTP id v139so6280637ywg.4
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 17:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dgILHJYlMM+wjaFe76nyr229DnCKooU1pJIUlz1MQwE=;
        b=wQqDhAx44Cr37pCev80haWJfYDUU5qi1yMmfaz1sRUrsCwSzjvEclb6RRGysXfX/Zo
         obko75my/2XeaFbMHnKuZqso9NS3B82b8vLZLpXhjJOBD7xycLGwQKLFSDWk2zyicy+I
         kyrqhwDMOiSaFwJ+IsvwKAdX3R42xVkF0Oid9RRZg1yeEeYehntn2lYlL+xYQIg/IZ6e
         1u2HzgoRJPWOHIY2vDtCzLTBaPAKaix7v1uGxQyX+LzRjamY2tdPh0gs4HTMrd6a5axQ
         Nevd78Q4FF5eTMjBttcwbcIIWNnuaxbn3QF91HRgHx3i7FXJikYf4Rd1/SxTK77PJSMD
         /Mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dgILHJYlMM+wjaFe76nyr229DnCKooU1pJIUlz1MQwE=;
        b=BKD2bK3mp7yzQOPmw1/7KOy0/m0RaPiRkUtKFH9vOiNu5LN1vAeD5fpFSbMJLwDfgs
         oSr7/xOCTE89JJUjyBYbsR/9ya6rmhRW/Rq81YFRdBldeF9EdfXGb9ATgv9+hXAOU0PK
         Ygr5rb/JSnniLeTgFktDXgaoK76ePzcA/t2DAdhXgTzZ/ikvA2CjFB3mJYO4LlTcGrDb
         ijXAACs2g/WiJSC2pF3mtPeW/0B2Em4+Qxd7/wyVDJ7M9Y6TyVm4IYmXJO6ytj6o+74l
         nHZBxjrlG0N7LwtMnqVYUK6Xlu8rjRKnKTuTh25ndUc1BtDhiJjONrS1+nV5EBKpS0bH
         4yNQ==
X-Gm-Message-State: AKwxytdz8jyCNPs2ZBXQ5qT3X4N1+KEO+l2E+tJJUNIQ+8vsJ66kc430
        UiKtHZAF1L62zipq/ytUlc1TjZWCSosgZ6rpLpGLiw==
X-Google-Smtp-Source: AH8x225YFZbMP9sgyM4S0pdzZNdu3uVppXyfCpz1fCrYQJn/gQPdm4bj8iBtwlRY/MJs8td8tmZnNCLiZqjrs3OlKCI=
X-Received: by 10.129.108.196 with SMTP id h187mr21231444ywc.249.1517360692951;
 Tue, 30 Jan 2018 17:04:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 30 Jan 2018 17:04:52 -0800 (PST)
In-Reply-To: <20180128170639.216397-1-sandals@crustytoothpaste.net>
References: <20180128170639.216397-1-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Jan 2018 17:04:52 -0800
Message-ID: <CAGZ79kbvWPDKPbe2pzHgvfKS+kToVmFtijsmshzX30uuk3pqkA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] alternate hash test
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 9:06 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This series wires up an alternate hash implementation, namely
> BLAKE2b-160.  The goal is to allow us to identify tests which rely on
> the hash algorithm in use so that we can fix those tests.
>
> For this test, I picked BLAKE2b-160 for a couple reasons:
> * Debian ships a libb2-1 package which can be used easily (in other
>   words, I was lazy and didn't want to add a crypto implementation just
>   for test purposes);
> * The API of the libb2 package easily allows arbitrary hash lengths, so
>   I didn't have to manage truncation myself;
> * Our codebase isn't yet ready for a hash function larger than 20 bytes,
>   as there's still more work to do on the object_id conversions.
>
> This isn't an endorsement for or against any particular algorithm
> choice, just an artifact of the tools that were easily available to me.
> Provoking discussion of which hash to pick for NewHash is explicitly
> *not* a goal for this series.  I'm only interested in the ability to
> identify and fix tests.
>
> The first patch does no feature detection and just assumes you have
> libb2 installed.  For obvious reasons, this series is not meant for
> production use.

Thanks for writing this, I chose a slightly different approach at
https://public-inbox.org/git/20170728171817.21458-2-sbeller@google.com/
which might be quicker for local testing.

Thanks for bringing this discussion back on the list,
Stefan
