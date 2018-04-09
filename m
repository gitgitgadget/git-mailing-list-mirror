Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C42F41F404
	for <e@80x24.org>; Mon,  9 Apr 2018 00:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeDIAJ5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 20:09:57 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:40015 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751587AbeDIAJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 20:09:56 -0400
Received: by mail-oi0-f52.google.com with SMTP id x9-v6so5996816oig.7
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 17:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Odlthl61TbY26TQmCyTXgTyIXnvIOw5OILvlMnYIaW8=;
        b=kWIsB8qKL+jtSVc/nyX0fO15gkpnirl48bubClVmFlOOE+VB65kATB+VVloQ4+9l8d
         sa7YU9Rdel3LAijfhJaAlrFCmK3ji7J7Cc4DsSS+SY1aHgIBfrLeFrxgKWxWcN5InQwY
         /wyM89VJLtvppnpNsEfZQdlwU8TSyu6f2sDlon64i3G4hg8eRqwIboAAZO3J35wCQz2U
         zCRuYfBLn5TXo+5/q8AHjRY2wtv72LIOAV0qQWlijdMQD2VYG8IEfQvZE7uyNudKltyg
         lgk4TdJ2wg/r/eoy7++UmdRPUe03F3KiXucwvFGUbjPdEmgu7TooIsjrELlPY9EN39IW
         kd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Odlthl61TbY26TQmCyTXgTyIXnvIOw5OILvlMnYIaW8=;
        b=KT3/UOyHO2k4K39BzAef+q8bePimpoNHuBGYzUr24eYUpJT8B+8X99dNPlj26DfNqX
         eY0+kCxgNUsMaY+4qHS3C4h+aiUMi7ng1MEn21jNgNw1NEDxjtDr4F4B+PgM4E/lVHVh
         quKLPJanX2XKezBqKIouq4zVQpjMdMrvg0lJKMvg8TyFLNMTu0Bca4ZdVqoa6RawQvLf
         +NzguYUaWjrAzThH6TVVLftDj0zgSKWgF+Dpru7qxDPsV/FftfVG3PJc6Cl2uU/3dgHC
         sHoqqwOit78eBmE93NWXXK1Oa3lFQyb8JHdUsr63SY7xdNSm1Oik7ayayzwii5XZuoSV
         Gbnw==
X-Gm-Message-State: ALQs6tC5tBTrRDBKoFv5b6ZChvM9oRmA4//nN3WHcQNYt6oSX0we/84S
        RHozfVCLCh45A0oRlfDvlsErDXHdhkJacQCDBnw=
X-Google-Smtp-Source: AIpwx4+HnG23zJ+zhNnf+RDC79zHtSVEaQuy/SRCv+sG68UV2I1tnEAnW2F6Kp7Zjh7v0JT4vG/zdzaSYDfqMwOYWqc=
X-Received: by 2002:aca:f13:: with SMTP id 19-v6mr21209280oip.298.1523232595976;
 Sun, 08 Apr 2018 17:09:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Sun, 8 Apr 2018 17:09:15 -0700 (PDT)
In-Reply-To: <xmqq7eph9wds.fsf@gitster-ct.c.googlers.com>
References: <20180408122832.65414-1-haraldnordgren@gmail.com>
 <20180402005248.52418-1-haraldnordgren@gmail.com> <20180408122832.65414-4-haraldnordgren@gmail.com>
 <xmqq7eph9wds.fsf@gitster-ct.c.googlers.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Mon, 9 Apr 2018 02:09:15 +0200
Message-ID: <CAHwyqnWe=KmmdGJJ_DnCK+D_FoC0sAQG_8=_p+4+Yxmr8s8sPA@mail.gmail.com>
Subject: Re: [PATCH v12 4/4] ls-remote: create '--sort' option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 12:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I can connect "because it deals only with remotes" and "access to
> the object may fail", but I wonder if we can clarify the former a
> bit better to make it easier to understand for those who are not yet
> familiar with Git.
>
>     Keys like `committerdate` that require access to the object will
>     not work [***HOW??? Do we get a segfault or something???***] for
>     refs whose objects have not yet been fetched from the remote.
>
> I added "for refs whose objects have not yet been fetched", whose
> explicit-ness made "will not work" to be an OK expression, but
> without it I would have suggested to rephrase it to "may not work".
>
> This is a tangent but I suspect that the description of --sort in
> git-for-each-ref documentation is wrong on the use of multiple
> options, or I am misreading parse_opt_ref_sorting(), which I think
> appends later keys to the end of the list, and compare_refs() which
> I think yields results when an earlier key in the last decides two
> are not equal and ignores the later keys.  The commit that added the
> description was c0f6dc9b ("git-for-each-ref.txt: minor
> improvements", 2008-06-05), and I think even back then the code in
> builtin-for-each-ref.c appended later keys at the end, and it seems
> nobody complained, so it is possible I am not reading the code right
> before fully adjusting to timezone change ;-)

Updated the docs.

>
> It is not too big a deal, but I find that liberal sprinkling of
> UNLEAK() is somewhat unsightly.  From the code we leave with this
> change, it is clear what we'd need to do when we make the code fully
> leak-proof (i.e. we'd have a several lines to free resources held by
> these two variables here, and then UNLEAK() that appear earlier in
> the function will become a "goto cleanup;" after setting appropriate
> value to "status"), so let's not worry about it.

Removed the "extra" unleak annotations within the if-return blocks,
but kept them at the end.

> Please do *NOT* step outside the pair of single quotes that protects
> the body of the test scriptlet and execute commands like "git
> rev-parse".  These execute in order to prepare the command line
> argument strings BEFORE test_expect_success can run (or the test
> framework decides if the test will be skipped via GIT_TEST_SKIP).
>
> Instead do it like so:
>
>         cat >expect <<-EOF &&
>         $(git rev-parse mark)   refs/tags/mark
>         $(git rev-parse mark1.1)        refs/tags/mark1.1
>         $(git rev-parse mark1.2)        refs/tags/mark1.2
>         $(git rev-parse mark1.10)       refs/tags/mark1.10
>         EOF
>
> I.e. the end token for << that is not quoted allows $var and $(cmd)
> to be substituted.
>
> Same comment applies throughout the remainder of this file.

Ah, thanks! I was looking for some way to allow the values to expand
within the proper test context.

So turns out '<<-\EOF' vs '<<-EOF' makes all the difference :)

> Other than that, this patch was a very pleasant read.  Thanks.

Thank you!
