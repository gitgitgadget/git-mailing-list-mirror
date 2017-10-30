Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31239202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932426AbdJ3Ril (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:38:41 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:55149 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbdJ3Rik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:38:40 -0400
Received: by mail-qt0-f182.google.com with SMTP id z19so17399077qtg.11
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/97vL0nGkGNGEoGez9rU6hfrq5uTmkWEgOTVybOqAg0=;
        b=hS5yDgEpwyDNyt1JOl4gQ+WGflkcre7wsZKbetJ6/uD4RqIYRLmvxP6qjKWSCRtYB7
         yA8hpp3YNEotb9y0q3x4xrSa+k/Y8eE0FtCTs+Ke2t+sH1lGAcCitgXAPS85mR4Zlxzy
         MwdXJLBTXqP5vTW4ZtFHAdE+HLKRVi+FZ5pCQuPzhULSEZpqtOqSQrPl8V3F/uCQLdun
         uVOGiYHQOms5nuGihOa47ESwmkDsg++cRkSWgJU2vZg1qdzhD7Uapv1vFnngTUnI7tg+
         H/KvTBmoICW4iB/EUpyOqtp7lzNfUOE0nVIecR6IxojyJKcC3q5y8ct1u0aK/3kJxKef
         3KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/97vL0nGkGNGEoGez9rU6hfrq5uTmkWEgOTVybOqAg0=;
        b=SntozvyUuPBIlXL4Pu/caRWmkpLjYDSEWhWqKlNShR76i12Xx3akwVEqbsLAgZM0Us
         c6MSDjcKkzgTA6JjWos8d97UkRowPxzCabBmX3zb/uT8oya+uWyvnObNEf0NEfEGhZo/
         XIyHD5Ohhs9bOIOMTYi3xlQKzBmXGQV3/Upg29ZYs82fTaGN9ZrtoD20ItVb44wDoXal
         bqq5LyOCNHdiEaZMk6Ok2dy8kj2GyF86GfB8wABp1ejoqJkLFnK0I3MMmrS1wvY8GP4K
         BmCEsJ+EPQ6E6UrXopAoJtLH1o/etRiJ6RbmK3oBumUPM73KptWpZ3i8Gakkw6eD9AOE
         I64w==
X-Gm-Message-State: AMCzsaW3J43iITL8z4FW/TpyLMS8meyoSpvdZ1QNYoK8eyDtafqi9rKl
        YbNdUujrCkMo2L3ythIPjpx7kH4WEeuwbX4Y/c4=
X-Google-Smtp-Source: ABhQp+R1KPMJUc3dI5xERkNWwZDahm5gX2hBzSACMCRf10nIgVcSHg62Flr5mBTwr7CEVJ6ryja9/JzV1vw0RiWKilY=
X-Received: by 10.200.4.130 with SMTP id s2mr15233059qtg.338.1509385119537;
 Mon, 30 Oct 2017 10:38:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.28.246 with HTTP; Mon, 30 Oct 2017 10:38:39 -0700 (PDT)
In-Reply-To: <xmqqo9osbghy.fsf@gitster.mtv.corp.google.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee22c-ea9c3a38-5d42-4dce-a54b-45c59768a70b-000000@eu-west-1.amazonses.com>
 <xmqqo9osbghy.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 30 Oct 2017 23:08:39 +0530
Message-ID: <CAFZEwPOThFTLzfiPWs_2NVQ3BbQ26asTOyvGp72L-_OEuTfujQ@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 2/8] bisect--helper: `bisect_write` shell
 function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Fri, Oct 27, 2017 at 11:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> -             bisect_write "$state" "$rev"
>> +             git bisect--helper --bisect-write "$state" "$rev" "$TERM_GOOD" "$TERM_BAD" || exit
>
> I can see why two extra "terms" parameters need to be passed to this
> helper at this step; looking at patches around 4/8 and 6/8 where C
> code can directly find out what words are used for GOOD and BAD, we
> should be able to lose these two extra parameters from this helper
> by internally making a call to get_terms() from bisect_write() ;-)

Yes quite true, but then after converting bisect_skip() we can
completely get rid of this line and then it won't be needed in the
ported C code.

PS: I have already ported that function but those patches are local as of now.

Regards,
Pranit Bauva
