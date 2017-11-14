Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5C3201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 01:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbdKNBTF (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 20:19:05 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:43236 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbdKNBTE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 20:19:04 -0500
Received: by mail-ua0-f178.google.com with SMTP id q18so11755481uaa.0
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 17:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rShas7hrNICuDeo2v1PgC/Iu3uxakxERbMh7IH1c0ME=;
        b=n14cO8lOWmmbH+xr3NL5NXQkR3NiZ43LPfltab7vCyaKB3g9kwyp5NkfI2+c7sNHX/
         hhgb1uZzXB8GBxYRnNp+9z/P41r5Wejx6SkiQZBzeeN7sXZqVlRyAKXSVr+LipHhGAsq
         er1njh+ZNidJ5Ba81qB3gdYzNktBxlx0bI0xGGhHJUEAl8X5zFalkA+WgUqqZEM5NrRp
         crNInugJHa2Qy3EcjkVxEk85w7nn11lp2yQBQc5qnr/Sec9Tvzc1uuOwlzyEe908LQiN
         SOOEaVp3XPSoOe5W5tJbyU2iVkE60TgXedP+IS2+XWEBTvd2WtpbkXMjF5gb1/4IyQ0X
         YT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rShas7hrNICuDeo2v1PgC/Iu3uxakxERbMh7IH1c0ME=;
        b=b8M2bc321LMzxW8dxnxiV9JHWTWpteXn6cg4qMON0R5yrfh93IwGxHEREGLtxhIKQy
         Tzkgr84yDuVg4/1kbz6MRkWu/aQqs2Oq73wTvoTXLT7ap1Krv4MNgKlS1D2rmqU7hFly
         8fXE2VdcbcKiXDSXf8LNXI2MsO2llu1ITIMUvKCen3F6mf2h29zC2l9K52Xcs4zQacgj
         +gfwtjJKKYUxBR10g4BrLPe8MwWbMQ1taGPpyWRCRCkwInOmzak7GogikSFWAs5hMvzd
         VziYoBFplwOhaK2D2VzdHxdEG8wJ9YGwpDHGk7powtNrfcT4MydH5Tp6vjWOzy6B1n83
         0Vbg==
X-Gm-Message-State: AJaThX50hxXUQOkIktda7tLu72HRrSTkc0yqC5JrWCCWurQdgYXfVq/L
        gBl8LU0nnWIezFctATeKfLkGng9n+LPFJ3pbpUE=
X-Google-Smtp-Source: AGs4zMY3Uf9QCHIoJSVjg90SVDwiZSrkRMDP69sT2O0hVLQsBpBTvlcXlUy03HX/4a2AXNccK2ka/0ZPPnB+owj4V4s=
X-Received: by 10.159.62.1 with SMTP id o1mr9709331uai.123.1510622343293; Mon,
 13 Nov 2017 17:19:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Mon, 13 Nov 2017 17:19:02 -0800 (PST)
In-Reply-To: <CAGZ79kana0_9N+gG+m2BT5Tnu_q4MC=WSTuvtwkdeD_Wn70ydA@mail.gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-9-newren@gmail.com>
 <CAGZ79kana0_9N+gG+m2BT5Tnu_q4MC=WSTuvtwkdeD_Wn70ydA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Nov 2017 17:19:02 -0800
Message-ID: <CABPp-BEVJ3c-Y+9buqh-XE8K5ETCH_iGpVxCDXdrdHN5iuAebQ@mail.gmail.com>
Subject: Re: [PATCH 08/30] directory rename detection: files/directories in
 the way of some renames
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 4:15 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
>> +# Testcase 5c, Transitive rename would cause rename/rename/rename/add/add/add
>> +#   (Directory rename detection would result in transitive rename vs.
>> +#    rename/rename(1to2) and turn it into a rename/rename(1to3).  Further,
>> +#    rename paths conflict with separate adds on the other side)
>> +#   (Related to testcases 3b and 7c)
>> +#   Commit A: z/{b,c}, x/d_1
>> +#   Commit B: y/{b,c,d_2}, w/d_1
>> +#   Commit C: z/{b,c,d_1,e}, w/d_3, y/d_4
>> +#   Expected: A mess, but only a rename/rename(1to2)/add/add mess.  Use the
>> +#             presence of y/d_4 in C to avoid doing transitive rename of
>> +#             x/d_1 -> z/d_1 -> y/d_1, so that the only paths we have at
>> +#             y/d are y/d_2 and y/d_4.  We still do the move from z/e to y/e,
>> +#             though, because it doesn't have anything in the way.
>
> Missing the expected state, only the explanation is given.

Yeah...it seemed so ugly to try to write down.  As a possible
sidenote, this testcase was actually guided by the final test of
t6042, which is messy enough, but directory rename detection provides
a little extra freedom to get a higher order conflict and make things
a bit messier.  It felt like it was a case where just leaving the
expectation in code in the 5c-check was just easier and maybe even
clearer.  Should I add a comment to that effect, or would you really
just prefer to see it spelled out?

>>  falling
>> +#   back to old handling.  But, sadly, see testcases 8a and 8b.
>
> You seem to be hinting at these all the time.

I think there were just multiple angles at which to approach those
testcases.  *shrug*
