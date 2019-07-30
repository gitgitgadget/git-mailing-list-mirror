Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B66381F462
	for <e@80x24.org>; Tue, 30 Jul 2019 07:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfG3HNj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 03:13:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37312 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfG3HNj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 03:13:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id i70so18822696pgd.4
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 00:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3CifTvu7hhMDyipYJGtoWTg4Ao+dbCq+EbU7x3nQxRg=;
        b=dXnRppEoEAaYJnxHs4qxUPp+NOKp0btY19BjCtHJYSTWpoYWXY/wpOszsjZdhklaiW
         wCuH41abGx/LOfiLUrq7K8Po13eUHRMJLHkd/nteHRaH4pQ11Ty01HygX2/aqssMUE0w
         u+xt0IX16QXEZpTAViOCDmv1rD/t3pQkXhlevVO9wDtpAcYv8bICqDph5OyGgZVAXY6n
         TiRnbr5ifhvPbgun6+EeuAncuXLy05K3y/YDSdIZeRacpolQgTh0yvQ3EdvXm9rQE+km
         d3mDYZPhgNOhl6VCeMU1+6Fr0Q42TcHHHbapjhJ1nZnxEYCOk/OK+udceA0wBYBQHLrC
         gGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=3CifTvu7hhMDyipYJGtoWTg4Ao+dbCq+EbU7x3nQxRg=;
        b=Z+8k9TWj/SCzjkROcAHA0yYR1mm2uyS+HCK26+VQlbth/0XUfTNhFAnPgWR9OVLh+l
         Txxxe2RXAlVRiKB9sLzz+ziAxcCsyUa+26iKNHrdB9MgOdtM1Rjv03QFpNBNX/Fh8b8V
         scYOJsa7J+71fu4teLLSiVlGswnbOQjoHGntFC3u157+Evm6akTrsx00SmaIE0qzylCm
         lXLu834AjCtxo2WNEq+IfwzaHYA+4CplksswxNpU7ZK+7ZRMI2nNu6ZB+urO0VzwxfXb
         AJEupBYxRtpoNRY6IG4+JM25M3Dn/xuRcJkyK2A/hZP8RAkjsevcRms8pURuI7gPwtFt
         q/mA==
X-Gm-Message-State: APjAAAUOtT5ccuapnPWHqSdWa9+gewInd8CIMA3ubItfMz2dI+AQ0+go
        bGusPbW3iB6xrFxqucLsLCC3eiTA4xm5/Uans/c=
X-Google-Smtp-Source: APXvYqwqdKGHak37z36ipjF8vhGJNasHC4JQqXUJb1Wyek9gl7FoJq1vO3k4kak90m9BQ65bk7Wu46/HxPYpdSyCwgY=
X-Received: by 2002:aa7:8dd2:: with SMTP id j18mr39945680pfr.88.1564470818968;
 Tue, 30 Jul 2019 00:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com> <cover.1563490164.git.steadmon@google.com>
 <69dc3696e715f9be9e545e0142244e16bdd489cc.1563490164.git.steadmon@google.com>
 <CAN0heSoU7XUN8GOFzzBrLG0RbY65hhYUn_-_Ax1DfFsNZ64hpA@mail.gmail.com> <20190729234319.GJ43313@google.com>
In-Reply-To: <20190729234319.GJ43313@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 30 Jul 2019 09:13:26 +0200
Message-ID: <CAN0heSodNUQ4eoipj7dVi7kr-NhHNyppcMm_SYpGTr_xZbgZHA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] t7503: add tests for pre-merge-hook
To:     Josh Steadmon <steadmon@google.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, stefanbeller@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 30 Jul 2019 at 01:43, Josh Steadmon <steadmon@google.com> wrote:
>
> On 2019.07.29 22:04, Martin =C3=85gren wrote:
> > This script seems to me like if it passes 100%, we can be fairly sure
> > we're ok, but [...]

> Will squash these as you said in V3. Will also think about whether
> another test approach would make more sense here.

Thinking a bit more about this, this test uses two identical hooks, runs
some commands and verifies that "the" hook was run (or not, with
--no-verify). If the implementation started calling the wrong hook
(pre-commit / pre-merge) or both hooks, we wouldn't notice.

Please forgive my braindump below, I'm on the run so I'm just throwing
this out there:

Perhaps (first do some modernizing of this script, to protect various
setup steps, use "write_script", etc, then) make the existing hook a
tiny bit pre-commit-specific, e.g., by doing something like "echo
pre-commit >>executed-hooks", then at select places check "test_cmp
executed-hooks pre-commit" (against "echo pre-commit >pre-commit"),
"test_path_is_missing executed-hooks", and so on, coupled with some
"test_when_finished 'rm -f executed_hooks'". Then the tests added for
this series would use a very similar hook, appending and checking for
"pre-merge[-commit]", That should make us fairly certain that we're
running precisely the wanted hook, I think.

Martin
