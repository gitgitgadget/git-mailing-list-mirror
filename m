Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2F091F859
	for <e@80x24.org>; Sun,  7 Aug 2016 00:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbcHGANd (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 20:13:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34384 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcHGANc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2016 20:13:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so9275923wma.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 17:13:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OEJGbJ/4FtKIdN2hYs1QJeNWc29KOeNzrTCiV4ZFtUg=;
        b=BURVCOGdHDMmkHpHNsHOGZfuDDTEShtCFfEdV7vrcEsNtFtpNTf6PrCTfSZRuYLGW0
         mjxa+h2Yi8ii7T6lZ/EvmqOipJukNLF3NsF0U1d2hAsFP0+LtaldD17M+eocuB6aW++b
         Y+h8Y5VzH/T4qrfXVpUMyDQzPy9isIeHL3zF3Ho1gtvM/ELO1sWc3w0uUdnolt1GRew4
         SL2EyipLrKjP3oL2TDMqVBc5UaGuwdi4IH42gTd+bPzJPWPuEr9yfGVioharj2DSs399
         lT8fuqNNeb25XFYPNGSCVBrWsM3grAp27k/06BkSiG6kfIXfUhQibS1+efSgV8NTWCD4
         n0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OEJGbJ/4FtKIdN2hYs1QJeNWc29KOeNzrTCiV4ZFtUg=;
        b=VpLPYssFqZVcILNElIrRVRxDWFMarGK1i3/Q5OamH5Ft7Jmjsa80bBapnJEmRmmG+U
         Y4qiq5Ip1hyKS9HSx0kpbxu41FX9MOAquaQqJ3SZzp3H44O8tFBiTSXThfzyH8FJRsyh
         00ZBdfc7IAgV+yXdPu2HaffFhoynWkoIYd3RF+HtQaODDO4V47Uajw+K/3B9H5oVw7F3
         t0IOquJtpWZGl50wo3f4a7kDjUZqa4MlVFlvUFPCM4G0QeR3IJYFMTNtTUk5zyEdfS3s
         jTX0nERuL7pjm9O08gVpo39x55amr+0hQLj4G7nP89wZ8jWqbYdSkxc7IrLeuYKV5iUx
         K4pw==
X-Gm-Message-State: AEkooutQmdNICBkm35cXx8TvA71Y68iiR1NcG3FFlZedLhk0X4Zy1JgeRKU/iUbtrJ7xWQ==
X-Received: by 10.28.15.194 with SMTP id 185mr5711243wmp.58.1470439596852;
        Fri, 05 Aug 2016 16:26:36 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB641A.dip0.t-ipconnect.de. [93.219.100.26])
        by smtp.gmail.com with ESMTPSA id x203sm10759958wmg.0.2016.08.05.16.26.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 16:26:36 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 5/5] convert: add filter.<driver>.process option
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160805185559.GB463@starla>
Date:	Sat, 6 Aug 2016 01:26:34 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	jnareb@gmail.com, tboegi@web.de, mlbright@gmail.com,
	remi.galan-alfonso@ensimag.grenoble-inp.fr, pclouds@gmail.com,
	ramsay@ramsayjones.plus.com, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <4499EF4B-974C-4D59-B95F-541EA4CF4078@gmail.com>
References: <20160722154900.19477-1-larsxschneider@gmail.com> <20160727000605.49982-1-larsxschneider@gmail.com> <20160727000605.49982-6-larsxschneider@gmail.com> <20160727094102.GA31374@starla> <64C7D52F-9030-460C-8F61-4076F5C1DDF6@gmail.com> <20160805185559.GB463@starla>
To:	Eric Wong <e@80x24.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 05 Aug 2016, at 20:55, Eric Wong <e@80x24.org> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> wrote:
>>> On 27 Jul 2016, at 11:41, Eric Wong <e@80x24.org> wrote:
>>> larsxschneider@gmail.com wrote:
>>>> +static int apply_protocol_filter(const char *path, const char *src, size_t len,
>>>> +						int fd, struct strbuf *dst, const char *cmd,
>>>> +						const char *filter_type)
>>>> +{
>>> 
>>> <snip>
>>> 
>>>> +	if (fd >= 0 && !src) {
>>>> +		ret &= fstat(fd, &file_stat) != -1;
>>>> +		len = file_stat.st_size;
>>> 
>>> Same truncation bug I noticed earlier; what I originally meant
>>> is the `len' arg probably ought to be off_t, here, not size_t.
>>> 32-bit x86 Linux systems have 32-bit size_t (unsigned), but
>>> large file support means off_t is 64-bits (signed).
>> 
>> OK. Would it be OK to keep size_t for this patch series?
> 
> I think there should at least be a truncation warning (or die)
> for larger-than-4GB files on 32-bit.  I don't know how common
> they are for git-lfs users.
> 
> Perhaps using xsize_t in git-compat-util.h works for now:
> 
> 	len = xsize_t(file_stat.st_size);

Thanks for the hint! Should I add the same check to sha1_file's use
of fstat in line 1002 or is it not needed there?

https://github.com/git/git/blob/c6b0597e9ac7277e148e2fd4d7615ac6e0bfb661/sha1_file.c#L1002

Thanks,
Lars