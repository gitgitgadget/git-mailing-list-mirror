Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBC51F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754205AbcIDUR6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:17:58 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37747 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754170AbcIDUR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:17:57 -0400
Received: by mail-wm0-f51.google.com with SMTP id w12so9240120wmf.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EUJ4yw+D2K769/1vgIjQtcnfzKwyhHRGORNz23vp+70=;
        b=Wzhrwo4S5Q+5HBqlfEDdADG0u7kCgMlKCZpPxT3//I/EACr61SYio0SkMc8JAfIhTA
         CffOq1YLqOCAe5i6psO9PS3Dx/j+c1zZBiAXY2g4lAock8tr8HJUd5SPYBoIVwlADDi0
         Jyxcl/HABJJpOAshVR2nGLyFWi1w8bZCg5sHaqd/Yu/hccOXvxp/Gn7AMJ1wM7Hjnhtn
         w1XTkVpyZ45yT9FdTMcqHxWVu1BRDUoveT7y0L2ky3c/oMwL6dWiOZeaaiDa8BFOyQWc
         Qmc9uC0EvCy5UPdsqaA0Obe/Ef2iOiK8j375I8OsmGx2a/VgyPXSv3MTpqzhD+Y0d8hU
         LE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EUJ4yw+D2K769/1vgIjQtcnfzKwyhHRGORNz23vp+70=;
        b=MkPQB0BxSIOYuPs9M6tAsD0mfR+leTsEv4xkwu0oZagCkDD3k5dePFDmLhRG6eB1aM
         GyRf9jXDdCvz4dY79TJOSWrzZNbl1bMn9tfW2aH8v6eDYquSorlnmSGSkXV6a/HE+aKn
         dj0VFDS1HuZJncGgmQPuhqvCW1NnTyehqD6FOim/f3Vw4hHyrRfiAsaPOSO/DRZ7na+W
         bU1kHH0kXtPvXPomnjrgBKKaLmGNWBGlJApkBl1ShCIXYRah3z1/dTRIjqMkQD88CDtq
         yli80D8IEIQijrZKxYY8jVXo3ymU118bfVOu9nnePQEZCex22D8JB6n5k14zkSP4MZsG
         cStw==
X-Gm-Message-State: AE9vXwM6zNlvMC0RFSQ8E7xMW/d9UhtMj8jdK5i4hJIU8PVXHD5V7Wvb75+wkRC1t1L6cuU2bzy1MfV+bjMkow==
X-Received: by 10.28.111.198 with SMTP id c67mr7192878wmi.34.1473020276147;
 Sun, 04 Sep 2016 13:17:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.222.132 with HTTP; Sun, 4 Sep 2016 13:17:55 -0700 (PDT)
In-Reply-To: <xmqqzinrwly4.fsf@gitster.mtv.corp.google.com>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
 <xmqq7fazbdmk.fsf@gitster.mtv.corp.google.com> <CAP8UFD20GY0h8n-7oJp8zhjHPUeKSkcEkNrOMuyGBrtS8JE6Jg@mail.gmail.com>
 <xmqq1t14zit7.fsf@gitster.mtv.corp.google.com> <CAP8UFD3wA32eXYq3F4=KS-9SkV48Yh45TKgFnn3AmGVfpjwWjA@mail.gmail.com>
 <xmqqzinrwly4.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 4 Sep 2016 22:17:55 +0200
Message-ID: <CAP8UFD3+=g+UqwkW7wUG3q3gmShg+6hw6SaGQ0-AfVEVJ6_w7w@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] libify apply and use lib in am, part 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 1, 2016 at 7:48 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Following Stefan's review, it looks like I will need to resend at
>> least 02/14, 10/14 and 14/14.
>> What do you prefer me to resend:
>> 1) all the last 40 or so patches
>> 2) the last 14 patches
>> 3) only the few patches that changed
>
> If this reroll is to be the candidate to be the final one, I'd
> prefer to see 1 to give an easy access to more sets of eyes, but if
> you just send them without giving these patches one more read-over
> before sending them out, it is not as valuable as it would be.

Ok, I will send the 41 patches very soon after having given them one
more read over and implementing the few changes suggested by Stefan
and Ramsay and one improvement I spotted.

> I think 2 is of the least value.
>
> If you do 3., pointing people at where the remainder of the series
> can be found is necessary.

There is always a pointer to the full patch series on GitHub anyway in
the cover letter, but I will send everything anyway.
