Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9BC22018E
	for <e@80x24.org>; Tue, 12 Jul 2016 16:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbcGLQBq (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 12:01:46 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38239 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbcGLQBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 12:01:45 -0400
Received: by mail-it0-f52.google.com with SMTP id h190so19579017ith.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 09:01:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ngzFtsD8lK1tg48qROvn74O8DmmaJ8Hktr0MdsbshhQ=;
        b=HgonL2r4IK5Pa8zU6878U5tU2OKUtWMed/0bT4b3rgMa0+e30aqYiim9moyDRSQVht
         i7Qk+8om9pkYqivQbXKiT17n6W2UnPRrv3Gk59mWh0oOU8BJ4GmnI7tfppiK3tNs6sFm
         9l0U92bd+vTyK8TMN4LPnep6vRztddzuOpQWghD7Yjn3rLPwF7aZzpVJ0FxVpl/yHtVq
         l1ZV4vP/7tvCJ/C/qEDKGH40TI6/0v7ECbjG3N3WQ+r2B4eO7SGRcj7DY9PAyIgHNLyI
         6vW6hwU67yihPkySH34nyaNQpVNwsyQ89G9aZRGb/wYIBCQ5vJIvpzDjZlNe/+mqzXKR
         qRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ngzFtsD8lK1tg48qROvn74O8DmmaJ8Hktr0MdsbshhQ=;
        b=mIrfzaotsZ4KVKQatF1kPe0gDVJU290lKqOImD14QL9TY/syN0BYxkzt+tmJIFK/Y+
         9KC2bbORJAd7A4HkykHl7yH4UkSR8ppSqgkppdMOMh0v9ADdVGqAs3gcnNJOSH7EUc0J
         FOI51GnXVMQWlAD7UNf+zZcEjlNc9fOakfxFXTTcOtfqIyiiKJI10mOnjxLUJxGiEDNg
         4YBcnIg1TwCbES20BIfSOfxYwnDaO2XxdgO/Lp/EsbLdmPCAnaeBTR9fJerhyt33Y5Ek
         vw3jsSWh6rVXpybvbrtp7vTrDfdCG3Z2VTQmOiafbB4nipJQnGMxFTy56zuFaGVZga34
         sqHQ==
X-Gm-Message-State: ALyK8tKygTqSbZGjH1WgLyFt94A0RcwAyyrNxS777wmOQyC/bgUHNcKt1kGdMP6TZeo1EJPce0HwYlW7hiGjLQ==
X-Received: by 10.36.43.5 with SMTP id h5mr17637494ita.57.1468339301603; Tue,
 12 Jul 2016 09:01:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 12 Jul 2016 09:01:12 -0700 (PDT)
In-Reply-To: <20160711172254.13439-1-chriscool@tuxfamily.org>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 18:01:12 +0200
Message-ID: <CACsJy8ApNJ+EBOVNC0GoPUaO898QRqHUZ2yQ39Qg5uGq4sHHGg@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/8] Add configuration options for split-index
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 7:22 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Future work
> ~~~~~~~~~~~
>
> One thing that is probably missing is a mechanism to avoid having too
> many changes accumulating in the (split) index while in split index
> mode. The git-update-index documentation says:
>
>         If split-index mode is already enabled and `--split-index` is
>         given again, all changes in $GIT_DIR/index are pushed back to
>         the shared index file.
>
> but it is probably better to not expect the user to think about it and
> to have a mechanism that pushes back all changes to the shared index
> file automatically when some threshold is reached. The threshold could
> be for example when $GIT_DIR/index size is larger than 25% of the
> shared index size. Opinions, test results or test ideas are welcome on
> this.

Oh yes I would like something like this. I stuck to the basics because
as you see you need to define some criteria to re-split again, but
without experimenting on real repos, I could just have gone the wrong
way. Index file size or the percentage of entries in linked/shared
indexes are two good candidates. You can also just re-split on
commands that likely lead to increasing linked index size a lot (maybe
git-reset), or run long enough that some extra processing won't get
noticed. For example git-gc should definitely re-split if this feature
is on, but I can't say if it's often enough.
-- 
Duy
