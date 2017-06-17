Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DB9920282
	for <e@80x24.org>; Sat, 17 Jun 2017 22:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbdFQWAe (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Jun 2017 18:00:34 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34579 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750973AbdFQWAd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Jun 2017 18:00:33 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so10992941pge.1
        for <git@vger.kernel.org>; Sat, 17 Jun 2017 15:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oX9tO4cqZXZ3Yi6x3wb/iEo3L8xq9nuxO7wRBY1ozsA=;
        b=Xl4NeTc+cQUc8kdEPKOKe0YL1c+i+NxXh5o3vcbe6mZbsUPCPp7EWBF/GUpyL0cNnD
         GvcCziUc4KqH7csM9CP9cvilt5J0daYjuLAQZd0SrbNFQB/58VCQIEUr7mqCyTzftQNE
         xR8p9E/xH3h0CsG7sBh1x7Zw0jPslZa/MzEdCzlTPr5EYpsjVtnTmH+bkYiWvH4njpCK
         Am2rDfkKDv9qP4JxQOKyu2C2rssqtXxrHZO1OIuk1dayvAQxympge4CccaQqq8YXlaXq
         NHF7ZUq539pZ1mHI5fpB/AJn+h7UVauOwl2pKKPWorN16wu8R1dDcEe3VX0Ucmk6zCDP
         +H+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oX9tO4cqZXZ3Yi6x3wb/iEo3L8xq9nuxO7wRBY1ozsA=;
        b=j4VFpy+oWlVJSPaDZiIXhg/iqqTKBJ4/ZymMuKG9YPxz9ecVEPtMdJMdf0tDlY2AI9
         nXXMJqEwi6eUTV0fs4Z7R1oFXuIwamlkw7xXYq2dV4LZq2ExhHtLDqqckiNSxq9Rip8e
         qzax4MsHfQa3JIbR0kyBn8Xo/l+s0ImKjK/cVtqqYamiZVs93LNR79BVjtgj3YbLq4I0
         xiGNcx09rmD+BRueJIY0EihOKFx3JomfDShMO26wKy0C/S3v7Dn5DylgeSa4JWzSD2HS
         r2Xn+lPp/n0lyJE2ZGKK2TvpwGuMCoNlSLXknQmaCEeDIIiNkIU2gUX1oroxgeF7Nm8I
         Lj5A==
X-Gm-Message-State: AKS2vOypwhJBswiImHo48w6iUE0iNM3TTNtR/Pu89oxfbW187y5uZXTU
        KvS3Gdg9SPCo9NFmHGo9DDq0ihkk6g==
X-Received: by 10.99.113.78 with SMTP id b14mr18530955pgn.229.1497736832944;
 Sat, 17 Jun 2017 15:00:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.182.236 with HTTP; Sat, 17 Jun 2017 15:00:12 -0700 (PDT)
In-Reply-To: <CALiud+nZj4f1=puzXC6grfStg-tQLMGpr-dAdtNwphyvts5KmA@mail.gmail.com>
References: <7d11fa4e-232b-8741-504f-ab4e3e788130@ramsayjones.plus.com> <CALiud+nZj4f1=puzXC6grfStg-tQLMGpr-dAdtNwphyvts5KmA@mail.gmail.com>
From:   Sahil Dua <sahildua2305@gmail.com>
Date:   Sun, 18 Jun 2017 00:00:12 +0200
Message-ID: <CALiud+moeCUV5HibQDK9+cgMUWBQfrAGZ6i0Jcs1SNMjzXkkiQ@mail.gmail.com>
Subject: Re: Subject: [PATCH] config: mark a file-local symbol as static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2017 at 11:40 PM, Sahil Dua <sahildua2305@gmail.com> wrote:
> Hi Ramsay,
>
> Thanks for noticing. I will squash this into the relevant patch.
>
> Also, git_config_copy_section_in_file() and refs_copy_existing_ref()
> don't need to be available in public API.
I noticed that git_config_copy_section_in_file() is declared in
cache.h already. I made it this way to keep it consistent with
existing git_config_rename_section_in_file().

Similarly with refs_copy_existing_ref(), it's similar to
refs_rename_ref() (both of these are declared in refs.h).
>
>
> On Thu, Jun 15, 2017 at 3:20 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Sahil,
>>
>> If you need to re-roll your 'sd/branch-copy' branch, could you please
>> squash this into the relevant patch (commit 37af9c71b6, "config: create
>> a function to format section headers", 13-06-2017).
>>
>> Also, I note that another patch in that branch (commit fd44da469c,
>> "branch: add a --copy (-c) option to go with --move (-m)", 13-06-2017),
>> adds a couple of external symbols which, currently, don't need to be
>> externally visible. Is it intended that git_config_copy_section_in_file()
>> and refs_copy_existing_ref() be part of the public API?
>>
>> Thanks!
>>
>> ATB,
>> Ramsay Jones
>>
>>  config.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/config.c b/config.c
>> index 2996e6d56..fbba17483 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -2173,7 +2173,7 @@ static int write_error(const char *filename)
>>         return 4;
>>  }
>>
>> -struct strbuf store_create_section(const char *key)
>> +static struct strbuf store_create_section(const char *key)
>>  {
>>         const char *dot;
>>         int i;
>> --
>> 2.13.0
