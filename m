Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC6120248
	for <e@80x24.org>; Thu, 28 Feb 2019 10:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfB1Kos (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 05:44:48 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:35929 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfB1Kos (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 05:44:48 -0500
Received: by mail-lj1-f178.google.com with SMTP id v10so16705856lji.3
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 02:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vCsCyU2fZUQGlm7G++8yOyAIFvMsJ5EXWFxzow010Aw=;
        b=SE2mPsER4sv3+NfZ2HNi7WOECDalwFYZM952KWajPbrGjUfR3ykO+yFxZopaC9SAZE
         d/HpmUkgXuAwpY23sNPpDSBw4QR13ety/9S0/xPU7z3ZDQT3Pl5A3Cn9cyHQ8Ad9HsUd
         8NjI+YByd6zlKyCdHj1urQD/r7liPrZBnP76kp7UQSYiFI02h/vE34NEmtdJNgT98kdE
         2THiRghZJaPUUM41JL0vA3vK0pKj1seh7+jDRaU1RF3a9OcTti2t+uslChZo3gx2COu7
         8QBOnQma/PNtyl9oEKocNGRPh7NBfrz0URbA9DYLqGQNXDlTQ/xCU2ovAaulDfuC7CcT
         HrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vCsCyU2fZUQGlm7G++8yOyAIFvMsJ5EXWFxzow010Aw=;
        b=ENsOADcLotKkZOwWaz1QPnAVec4z2zKa8B9W38JwEkG0sYHKTaW5SH4HH7ORZctaUx
         nXKCD43kMwIq9E37JGlmjvDnaCCm3lGxs1BFVbdL230SIAeAukmwy+GVkBe2TtiaF8Qi
         53Bg3LyWwyws+LdYitQboywvSjX3+rbWhQcNSybUm23nJJTxwH2ISrcujcQbebZ9l9/9
         FrxXKL6DpKMPSFfJV2P+eSFlZ+fkgk6NVDJMS9HNhH828w+S4SJTcZJODPwkdunPmmMT
         C5qE4BFax0HsqX99u5xVXFcvk2RC0v7f1Mmg2WthSDoZuof/9De5WbjeYtfXnGf+1/n5
         oskQ==
X-Gm-Message-State: APjAAAX1e06gTJe5BKmKWQU+22JT7jQgms7uhkLKKLQfOmLmXKYFvOPd
        uyCNQ6+qOygxzzs8WIPdH+qVoJUoNA81RcazD4s=
X-Google-Smtp-Source: APXvYqyj91cTydjHMah06g8Vo/06FxOMmrA8ytTNrhP3hcFwLeg9hFq9eQQn/wuDvRcqW6etpw+h3tfkbXHwmjPG3mM=
X-Received: by 2002:a2e:9b99:: with SMTP id z25mr4174657lji.106.1551350686296;
 Thu, 28 Feb 2019 02:44:46 -0800 (PST)
MIME-Version: 1.0
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Date:   Thu, 28 Feb 2019 16:13:46 +0530
Message-ID: <CAL7ArXp0xJx4DLZ7jM78SRFPGE0Ph9itrZpV0LtQYhbART1s5g@mail.gmail.com>
Subject: 
To:     CACsJy8DjYUn+45E04gPjXhN0xqqjeyf8XoQsR8PyLefFrO4RGQ@mail.gmail.com
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Duy
Sorry for late reply.

>
> On the Git mailing list, Duy Nguyen wrote (reply to this):
>
> I was a bit worried that the "test ! something" could be incorrectly
> converted because for example, "test ! -d foo" is not always the same
> as "test_path_is_missing". If "foo" is intended to be a file, then the
> conversion is wrong.
>
> But I don't think you made any wrong conversion here. All these
> negative "test" are preceded by "git rm" so the expectation is always
> "test ! -e".
>

Yes, I thought about it earlier and made
changes thinking this only. Also when I was going through the code
again, I replaced other conditionals `[ -f ]` with test_path_is_file
etc.

Ciao
Rohit
