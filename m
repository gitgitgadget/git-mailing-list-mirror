Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B72207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 08:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1170776AbdDYI5J (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 04:57:09 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:34569 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943039AbdDYI5E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 04:57:04 -0400
Received: by mail-it0-f44.google.com with SMTP id b134so12483689iti.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 01:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KIq9lNixYeh0FHRuBvwPEVQoeKDZkB3yZw8Z+IODC3w=;
        b=T+R7QY6rZWcayrUm1BcGwItI9rShoSpVapEw/+s5bAMRZRzs+BZYJO+0WHEnosZl5u
         XVies4VrYf+YeSRArme3qnvSnW29bd+74MTBCnchYEv1wYs1QBufa/h5GWAjdAFhCDBC
         cUZuJ5hr3ixgc884oEEVpNz9mpQ2bQjvLuqx4GxLK4OqKiaJkK+uuWi/j5Dhn/s1ETcC
         F8fPJRuJvy/meX2OoHn48Yp+0Jc6++1pKucdgMZeqMGXr6wpwxpfhH/LPOLvyOz3vkjl
         howvC5Kaaa3y9VQLFerDaHaRYurCEk4nVz+qqULHe7e2+W8JAUH3ADS2D5e3yFQeXWdD
         npxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KIq9lNixYeh0FHRuBvwPEVQoeKDZkB3yZw8Z+IODC3w=;
        b=o1FGYKdZJGcMfy62ZRxnjNR/i4LnF+w7uOHBmJTuFQQpBeU2tZvneQoCqhwcALRmc6
         zptT4cD4pU2juA9vDjuit1RJUxVy0mqZawaPP8faSuXBzQiO5vwVcLU9N/dnPo0ecmgk
         AsTbuvFFNy/pjPODO1cRaDzZgKvBgJizUsB1/qd5MBraImxXTOx/wWRE/5Vmp4MSfbiN
         rWMWnS9lZPzL/GOqkQY8LXoSnMUL47hi6UZWfcC7jm/ZfUUjW3ReKGP/1QAkOeMYvdPu
         oPMQBxgT6SX5S0/Uq8TQP+aRbOz22ivwP2N8raIbJGLXyxIuKBZSbOeN+VaPs1xQp0ya
         BozA==
X-Gm-Message-State: AN3rC/5OUT9i4wWgcyxp75qEdpfuHfjDs5urGFinvF4GjIf+37IVkJ9S
        1VfaajI6zOXF3NOcxibjDx9RiU0mzw==
X-Received: by 10.36.103.86 with SMTP id u83mr2784591itc.91.1493110623906;
 Tue, 25 Apr 2017 01:57:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 25 Apr 2017 01:56:43 -0700 (PDT)
In-Reply-To: <xmqqmvb5w2hj.fsf@gitster.mtv.corp.google.com>
References: <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
 <20170421185757.28978-1-avarab@gmail.com> <xmqq1ssi4nci.fsf@gitster.mtv.corp.google.com>
 <CACBZZX63VQK4fLSB2T8onXJ_hQE8dkOCAyFFM-C_yOfoMwxLMA@mail.gmail.com> <xmqqmvb5w2hj.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 25 Apr 2017 10:56:43 +0200
Message-ID: <CACBZZX494g8CKoN0V1N4xRuDsErPtJcMjaZcLFAqJgDQ+Mz+yA@mail.gmail.com>
Subject: Re: [PATCH] tests: fix tests broken under GETTEXT_POISON=YesPlease
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 6:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> My general approach when writing & maintaining this poison has been
>> that it's fine if we skip some tests, even though we could be bending
>> over backwards to run them, or even if we don't know the root cause
>> beyond "the rebase machinery is always broken with poison".
>>
>> This is because once I'm satisfied that the breaking test isn't
>> because of some new plumbing message that got i18n'd I don't see the
>> point of keeping digging, it's fine to just skip the test, because we
>> run it when we're not under poison, and we're satisfied that it's not
>> breaking because of a new plumbing message being i18n'd we've
>> fulfilled the entire reason for why this poison facility exists in the
>> first place.
>
> As to skipping tests, I am worried mostly because it is very easy to
> mark one test as skipped under poison build, even where the side
> effect from that test left behind in the trash repository is a
> prerequisite for a later test to succeed.  For example, a test that
> creates a tag may be marked as skipped-under-poison.  Then a new
> test that is added to such a test may want to do something using
> that tag, and it will succeed in the usual test.  As most people do
> not test poison build, when somebody notices that the new test fails
> under poison build, it is unclear if the breakage is due to new i18n
> issues or something else, like a missing prerequisite tag due to
> skipping an earlier test.

Indeed, I've tried to be careful not to introduce bugs like that, but
in this skipped case the tests look completely stand-alone to me.

In any case, I like my other patch to just remove this whole thing better.
