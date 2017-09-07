Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F01C20281
	for <e@80x24.org>; Thu,  7 Sep 2017 05:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbdIGFcP (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 01:32:15 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33146 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdIGFcP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 01:32:15 -0400
Received: by mail-qk0-f172.google.com with SMTP id o129so24592184qkd.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 22:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5QmoK8CZy+tqfhwWKcxBPjEKTswpR79om0UmUuoMHjs=;
        b=qYkRtriYvIfjZHNQdhKIdPcUy2FKaO136Pbq4TNMGG15NatDrmimRqMK1Tg/sFX+WN
         1CG3mWqV4552dO6Asj+NSNtYBguxeg/B5n4INWWdFohbduCZtzPYaa6nZFG8NMJlm1tt
         NdNGiFfbK3FFUD24apyELdE+eX30mQKnywS5AAtM0SEOb/sj49XReKUhZzquAkOGJmlb
         tYDsirOLyH3H1L/puc2fHjVLWijCO6rjDcDLCzENuboK//kCjtj5TKtoF8PgfhT3fBGu
         Jaew7/OIc3GDVRfb8SAalDTmuAXOf++KWYjIN64bt5iFWTKAlcSjqb/prVYm4KuZwZEr
         3LpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5QmoK8CZy+tqfhwWKcxBPjEKTswpR79om0UmUuoMHjs=;
        b=fe88J2Fr8vsUdoLyw29FbVTlUThjc62zz3WT6ksVVoVAI6kIcF0KWVbdSCECEKtxVy
         PpnBU+ipCBkkhxNT5nBgKZNr/n2fIu8BGTAhqOqjqQQgqOQ7Hs5UTMcLp/iLrBxSnSjU
         /C5FR9d8s0sg9LZ+wWdl5VGwp0uqT+Riy7gQMAGveCX0BUuvXO1Gx/wu7VnN4+SvLazK
         IhCA6fgpBzH3PfLVsRqA5TmoaLvmGg/XR5xPMGo0oy74Bsn2jH5Y+qykTsxfSh/RzTPb
         kxnJ1OKla1kBwdKVWWKDBnoOFlGKwbJo7Q9rYj7S+IMo6S+BZI5DWZNCnDQwVQ6xQ7AD
         JRlw==
X-Gm-Message-State: AHPjjUjb7wIUBFtp2sH+5gbf4QMhVdYKJjf2neBPpxpj71pifeewX3QH
        unkEez+Fz0OysxX0R5fvJ7MHNrb4bw==
X-Google-Smtp-Source: AOwi7QBBTMXR5QEyGMDQELUCWF4t25SKIOuBShFKXCQhqpZPnoVX4+oA3kWEDiJLgnAh2RkLk/wLo97Xw3jCBPXcJWo=
X-Received: by 10.55.181.134 with SMTP id e128mr2208572qkf.62.1504762334527;
 Wed, 06 Sep 2017 22:32:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.39.151 with HTTP; Wed, 6 Sep 2017 22:31:33 -0700 (PDT)
In-Reply-To: <CA+zMtjmhrE54=ke6vVDGOcrbHkdPuE-Gf5cwQEp8LL2h+xen0g@mail.gmail.com>
References: <CA+zMtjmhrE54=ke6vVDGOcrbHkdPuE-Gf5cwQEp8LL2h+xen0g@mail.gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Thu, 7 Sep 2017 15:31:33 +1000
Message-ID: <CAH5451m9asxzaOEzQ2Jjk9Ly97GVnb7DV0uZS=96B=yHCYLWCw@mail.gmail.com>
Subject: Re: Branch name support & character
To:     =?UTF-8?B?5aSP5aSn6Zuo?= <xia.jason23@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 7 September 2017 at 13:27, =E5=A4=8F=E5=A4=A7=E9=9B=A8 <xia.jason23@gmai=
l.com> wrote:
> I want to merge branch a to branch b so I rename branch b to a&b, but
> when I push a&b to remote repo, '&' is took as & operator for shell,
> and git push fails. So it would be better that branch name support &
> character for me.

Have you tried quoting the branch name?

Using git checkout -b 'my&branch' works for me (single quotes around
the branch name).

Pushing to a local remote also works: git push --set-upstream
../git-test-2 'my&branch'

That being said, I would advise not using & in branch names,
specifically because it is a special character in shells.

Regards,

Andrew Ardill
