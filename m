Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD5E1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 14:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeKZBGA (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 20:06:00 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:37216 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeKZBF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 20:05:59 -0500
Received: by mail-ed1-f48.google.com with SMTP id h15so13668734edb.4
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 06:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=TJGeJnNgVJSl3PH8Mpeho7X4O+e8h5siXHK1UMKqxmk=;
        b=ZJI9XSJlSgtGJnPXJ59GZq/be2iD9JVxlRLUn2G34Ax82B2UJsm0kBC4NU+pJ+W0Sb
         XdYl3LlZQQe+kElf+UrIVlYXKjoiEuhPkJzd6ktC6DqOayqRsgbaMyPFmO6fIdNMfCb9
         m1jTAzcdaVogERI7v3uXzE6wBVG3gMI6siQ7cQe/BwNbj65wgHrLAeDa/BM92XemX/45
         rtuSmISk76IIcqqoIWQu9xglfWIP0yt0awe6GbYHW01wRIqpFAWamGqZ9tCgTxUzNt8Z
         zZGE9cl3poKlFgQu+c/BFItxHab5s3VjN7Km0iqzMdIM3xqb12N/1vZaWX4vvCtPXg8a
         rhqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=TJGeJnNgVJSl3PH8Mpeho7X4O+e8h5siXHK1UMKqxmk=;
        b=bT94hR8eqS+NpxhStir4u7usBqx9ytpXaPW1KhC5OcJXoxZiE9nQltsUbKBTlKL9BV
         AohySlbh7JyUp8Eo5xu33pRWssiJj9P8YdXyk70SvrVVZBjZPhGkQx+XkULTtTS50Dtn
         vO16weSYzRjLAJ9Vl5RuAkZtI1xE9r5IDdcIloNDHUysChBgNJ0V0t0a1S8X7R3V7uff
         AvFxlTccxwqjXNnR3pqSXs9vo711sVvaGSoi+vrra1q0PzuKLdsjz+XydS9AdfXyYU8w
         8Hargn87IOLCp6NapfW+SdAdF37GflXQRph5DXtIatfGFS4JQZ14ShHEcu0+HnhGOH5q
         m93A==
X-Gm-Message-State: AGRZ1gJyiXKyQ6tIYQLyIhwCYqPTG/ZAvRLhm2+kNGSUyo96bjRWyWYo
        z6v5JvFTUL4PaghhjCTZcg0mwp12
X-Google-Smtp-Source: AJdET5ctHzYqrI1N5tWxSz88h89DkvNRN2T26xv2PpXoRjMFgEwVucgG4htQWbrJ/fTL7NavbqzFvg==
X-Received: by 2002:a17:906:8242:: with SMTP id f2-v6mr17682995ejx.125.1543155287381;
        Sun, 25 Nov 2018 06:14:47 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id g3sm16725187edc.63.2018.11.25.06.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 06:14:46 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
References: <20180824152016.20286-5-avarab@gmail.com> <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com> <87bm9cs5y6.fsf@evledraar.gmail.com> <CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com> <877ek0rymz.fsf@evledraar.gmail.com> <878t1i1d9q.fsf@evledraar.gmail.com> <20181125042835.GA24530@tor.lan> <20181125082145.GA15747@tor.lan>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181125082145.GA15747@tor.lan>
Date:   Sun, 25 Nov 2018 15:14:45 +0100
Message-ID: <87zhtxz1ka.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 25 2018, Torsten Bögershausen wrote:

> On Sun, Nov 25, 2018 at 05:28:35AM +0100, Torsten Bögershausen wrote:
>> On Sat, Nov 24, 2018 at 08:33:37PM +0100, Ævar Arnfjörð Bjarmason wrote:
>> >
>> > On Wed, Sep 05 2018, Ævar Arnfjörð Bjarmason wrote:
>> >
>> > > On Wed, Sep 05 2018, Eric Sunshine wrote:
>>
>> []
>>
>> > > SunCC used to be ahead of GCC & Clang when it came to certain classes of
>> > > warnings, but e.g. now everything it complains about is because it
>> > > doesn't understand C as well, e.g. we have quite a few compile warnings
>> > > due to code like this, which it claims is unreachable (but isn't):
>> > > https://github.com/git/git/blob/v2.19.0-rc2/read-cache.c#L950-L955
>> >
>>
>> Wait a second - even if the compiler claims something (wrong)...
>> there a still 1+1/2 questions from my side:
>>
>>
>> int verify_path(const char *path, unsigned mode)
>> {
>> 	char c;
>> 	     ^
>> 	/* Q1: should  "c" be initialized like this: */
>> 	char c = *path;
>>
>> 	if (has_dos_drive_prefix(path))
>> 		return 0;
>>
>> 	goto inside;
>> 	^^^^^^^^^^^^ /* Q2: and why do we need the "goto" here ? */
>> 	for (;;) {
>> 		if (!c)
>> 			return 1;
>> 		if (is_dir_sep(c)) {
>> inside:
>
> After some re-reading,
> I think that the "goto inside" was just hard to read....
>
> Out of interest:
> would the following make the compiler happy ?
>
>
> diff --git a/read-cache.c b/read-cache.c
> index 49add63fe1..d574d58b9d 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -951,17 +951,15 @@ static int verify_dotfile(const char *rest, unsigned mode)
>
>  int verify_path(const char *path, unsigned mode)
>  {
> -	char c;
> +	char c = *path ? '/' : '\0';
>
>  	if (has_dos_drive_prefix(path))
>  		return 0;
>
> -	goto inside;
>  	for (;;) {
>  		if (!c)
>  			return 1;
>  		if (is_dir_sep(c)) {
> -inside:
>  			if (protect_hfs) {
>  				if (is_hfs_dotgit(path))
>  					return 0;

I haven't tested (it's tedious) but yes, I can tell you SunCC won't
whine about this. I've only seen its unreachability detector get
confused about goto inside a loop, not the the sort of code you've
replaced this with.

We should not be appeasing these old compiler warnings in cases where
they're wrong. You can check out the CI output I linked to to see 10-20
cases in the codebase where SunCC is wrong about unreliability.

Whether we should just fix this for its own sake is another question.
