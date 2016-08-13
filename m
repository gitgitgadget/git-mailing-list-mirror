Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3644120193
	for <e@80x24.org>; Sat, 13 Aug 2016 08:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbcHMI4K (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 04:56:10 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38326 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcHMI4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 04:56:09 -0400
Received: by mail-it0-f41.google.com with SMTP id i186so2525025itf.1
        for <git@vger.kernel.org>; Sat, 13 Aug 2016 01:56:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gc4ljEkw8MK7eQ+cTNpVsjZhfSqNFICIhFFUMsATuso=;
        b=l5+CJlNyuUwBLyg0uJe/D+D19AMP+/GIdpY0kz7t5BdNyPyzj34ZF+84MgvFKrciga
         ruwo6WCbVXGmdbLyFybB/T3VJGsAdh0z+2TMXONAwPCWHIY8qjUeS53E827anR4bpo39
         19ybbF0HUkX6P2CDTHPNOhiF7OKP8J+p+/qnHaAhHMVc3LXZtmXd4IYIKZlxAESMOrs5
         OP9AvENNebyCSgGVPCNJiBfPO5JJ5wQOuG9d4zjc1g2TPgLx3gMT4fXbQIxSZ7HYRo/w
         uBHgT1kiEy9SrIpAeoiqJ65Zow84QlomhBtrto9xDYRohgu2UpBAxNhTYW+dJJWPiDYO
         C/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gc4ljEkw8MK7eQ+cTNpVsjZhfSqNFICIhFFUMsATuso=;
        b=hW0QCTQ+IEh81TgmCMnLA9mNI7MGkbMivehj2mD1GQI7oDRjQsaNdPWHbiFT36vKQ6
         wMak4kue2TubSM4WgG48UzDdfkkRY/GYrlEJNV67Tpm1WNDeqN6X8dogpRHpAfoLOGJm
         +UlGWR2YePID0EZDugz7WQah/IaPBIu4EBT/nEiqEJIPO9Rz5KgRpz2zP8eLzz8zuLWc
         R3BYaUJD3sKO1MqU2NDXtjlEAbv3zayrm0YuxsTRtn0wbQ8+lerfaDFHqn7OgXcqG98p
         hnTnzQDJQhbQAiElXrywvSITrdC5YSYYMFJEXXHNrl3kOEfnsNmm1RhDKDg52Dr7ChZX
         sv4g==
X-Gm-Message-State: AEkoousiPl/7DOWkRFpyOYPc8tILpaNlFMeJ/bP60ie4KRlfjuJWPmVMjGRuPmw/FRbjFjr536l0sXFODdXrgg==
X-Received: by 10.36.43.88 with SMTP id h85mr3311004ita.57.1471078222032; Sat,
 13 Aug 2016 01:50:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Sat, 13 Aug 2016 01:49:51 -0700 (PDT)
In-Reply-To: <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 13 Aug 2016 15:49:51 +0700
Message-ID: <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Stefan Beller <sbeller@google.com>
Cc:	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 12:27 AM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Sep 10, 2015 at 9:28 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> Hey,
>>
>> does anyone know of any tricks for storing a cover letter for a patch
>> series inside of git somehow? I'd guess the only obvious way currently
>> is to store it at the top of the series as an empty commit.. but this
>> doesn't get emailed *as* the cover letter...
>>
>> Is there some other way? Would others be interested in such a feature?
>
> Being late to this thread, but I think
>
>        branch.<name>.description
>            Branch description, can be edited with git branch
>            --edit-description. Branch description is automatically added in
>            the format-patch cover letter or request-pull summary.
>
> is what you want. Maybe we want to see a patch that adds the reverse
> functionality as well, i.e. git-am will store the the cover letter as the
> branch description and git-merge will propose the branch description for
> the merge commit.

I almost suggested the same, but there is a problem with this
approach: if you're are on a detached head, where does git-am save it?
-- 
Duy
