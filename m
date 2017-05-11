Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266C61FF34
	for <e@80x24.org>; Thu, 11 May 2017 09:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754900AbdEKJvS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 05:51:18 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34421 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754347AbdEKJvR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 05:51:17 -0400
Received: by mail-pf0-f174.google.com with SMTP id e64so11380767pfd.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 02:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=p/YWJYu69CEfUFKH1eIFgYgfeYtAYrZQMYMBl3FHTxA=;
        b=BwUbD+R1rbCimkBA1r45IE+qN8rAFtyK0gTxkZDGtr4lCV382vPUOzQtyx9j4mgWK5
         bFawqFvv4bw0lL1xzV8LwzUkvz0BkRXLMUDLx4N3Jts0DBVqLySgrcRmwYpeBCDUA691
         VsJD7tarmo12izpyb4zQnDvo/19Ej+5vunlMGoHueYovMKQgC4Ko71ckfC4eHA29NKd5
         3iEHcdMmY4qKz3AxK839E97x+lFQXBktkOzWRbs+vR/alnVWNWH+8N8M7vvem250r95B
         rz70GBPPWuDI7VXUd2qy5whriPOGQ+fcPGuD7JJX1brSpzNw8uGzKQHM39glxciq0U+p
         f7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=p/YWJYu69CEfUFKH1eIFgYgfeYtAYrZQMYMBl3FHTxA=;
        b=udHmosV1m59EBSvvPhNWPKEySJhKVxCRL5DiwAXwBcjTYdUaaW/fZ43qbNHTIZegmy
         B520h0heqPHwIhTHqjvLz1wJEaNQsXgIAuomMP2DJ8HzujTYntc/s9q8tnYoiYHxJH0e
         PPnUZIi/zgcJ9Y98NWPbHbwn6ePew4AnpZQzIx7J1aiXNZCVGdZNhNjN/n3ksuK49CGH
         OVutMgi1xoBrgb3V3wRLkiOTcpOyTSHAl+v/bmPuqpc0hfIpSSKEhPwlDMDBBz46oHF6
         h5eA3T8NSOZ/zrtktp+euouJ0LkqrZSJiXgY3QvhnwRa0G8kBiPeaFFYdyO5DWr3Qy7r
         HBRw==
X-Gm-Message-State: AODbwcBtHYerkem7Y0ieC/wZd9W6BVQ9EAJVuyBHokrFCQUyv1cjCGnO
        Le5tcMeeMMZRjA==
X-Received: by 10.84.211.36 with SMTP id b33mr15105561pli.88.1494496276714;
        Thu, 11 May 2017 02:51:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id k23sm3324196pgn.11.2017.05.11.02.51.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 02:51:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: https://travis-ci.org/git/git/builds/
References: <xmqqfugbbzto.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5tf9seb0mCR+UOUCk3jA-L47C9qowSnBzzNq9eZ4+H+g@mail.gmail.com>
Date:   Thu, 11 May 2017 18:51:14 +0900
In-Reply-To: <CACBZZX5tf9seb0mCR+UOUCk3jA-L47C9qowSnBzzNq9eZ4+H+g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 11 May
 2017 10:11:33
        +0200")
Message-ID: <xmqqd1bfafhp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, May 11, 2017 at 9:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I was hoping that by ejecting a few topics out of 'pu', we could
>> finally see all the build jobs pass their tests under Travis CI.
>> Unfortunately, no such luck.  It seems that we have some new issues
>> with Gettext-Poison build/test after updates to t0027.  Also the
>> updated compatibility regexp thing taken from gawk is not liked by
>> the Windows compiler.
>>
>> Not all of these may not be new issues, but nevertheless, it would
>> be nice if we can see all build jobs succeed every once in a while,
>> not just for the three stable integration branches but also for 'pu'
>> ;-)
>
> The gettext part is my bad, I never tested with EXPENSIVE which
> Torsten removed, so now the test runs & fails under poison.
>
> This trivial fixup makes it pass:
>
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index effc3db0d5..deb3ae7813 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -69,7 +69,7 @@ check_warning () {
>         *) echo >&2 "Illegal 1": "$1" ; return false ;;
>         esac
>         grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^
> ]*$/\1/" | uniq  >"$2".actual
> -       test_cmp "$2".expect "$2".actual
> +       test_i18ncmp "$2".expect "$2".actual
>  }
>
>  commit_check_warn () {
>
> Can you please squash that into my patch?

Sure.  Thanks for a quick response.
