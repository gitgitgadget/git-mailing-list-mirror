Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D137C2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 17:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbcGMRRv (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 13:17:51 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36602 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbcGMRRt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 13:17:49 -0400
Received: by mail-vk0-f51.google.com with SMTP id j126so20593452vkg.3
        for <git@vger.kernel.org>; Wed, 13 Jul 2016 10:17:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FxxnF3BD6DpNtm2XBDwiKq2ZWvHSBZXjDfKQKybLeLI=;
        b=U0hhMqhw2TSdFtedTmzFWcy+odvEViL6O6paVzSETd3MGT7x9uQQRn0aehFRxMU3eN
         IHvM5H7AUs91kBS5WNOJm4aUJHwA01rl5NWVReGaL57S2s6K+2qoYWvilw0bih1U/jUW
         WIeetN9PXymet9EtTZT3cmnXEkp1k2RUvxkHh3ex+8Nrc8e7CM8UBoB97nvZlQiEyiBs
         jYJ1EgfQl7MHbTYbCWO5vXKqS2pzu8zAWCHjgAg2Gwv9q0zdOKMIs2Fa/Mus2qjeSnuZ
         SLuantsqdkid1OGD9dVxAfAAI9XyCnnYzQzAP8DA7P8iS8Wk6k4YsYojgaAB1gCo+3ww
         tI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FxxnF3BD6DpNtm2XBDwiKq2ZWvHSBZXjDfKQKybLeLI=;
        b=bO0MnrBBvCFDJYIIoKJjRcek757I+xEZTIYwkY2TC3V5slWF/D/rkRwvXMmujAaKGI
         0Q/04Ry8ZjGCk8AA7qa/kV5JBAwzl2SEjPhaGkUTSt0q+MV5PflEDrm0JmXDcQqK3nfB
         zpiMHoioLr1Oa8JYvBiB4v8ui2o/wSSjZE0443OGY4hplpHhpJ2SdY6pmByIF6tpo2io
         Q9iO4zlgxaonqYCy9mTI5VzHv0uMFSr1sdtjnB9BxQtD6j0lhAcJqO8yjiEsUk4u6LVc
         gDhIOu/cHWgogR6oTtkl+fPGZE+KnVc9+n11vwo10p+EoA4mO9BnTO4RRu264MZv4sfw
         xllg==
X-Gm-Message-State: ALyK8tKEoRq4iEjRuyro23+mxxtmsr6Kev4gd7/CmbHQ3QmL2xUgszZ0XqZDd4wtAUi2OeZp/2mj2l++aYr6BA==
X-Received: by 10.176.1.117 with SMTP id 108mr3854248uak.128.1468430210777;
 Wed, 13 Jul 2016 10:16:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.65.5 with HTTP; Wed, 13 Jul 2016 10:16:31 -0700 (PDT)
In-Reply-To: <xmqqtwft1nbi.fsf@gitster.mtv.corp.google.com>
References: <CAFgjPJ-E0k8KQjdcRki4Qr1tPjwfJVtuFWOKYV-+f6POgb-=wg@mail.gmail.com>
 <xmqqtwft1nbi.fsf@gitster.mtv.corp.google.com>
From:	=?UTF-8?B?SmVoYW4gUGFnw6hz?= <jehan.marmottard@gmail.com>
Date:	Wed, 13 Jul 2016 19:16:31 +0200
Message-ID: <CAFgjPJ-E=eW_ZiAUf2jKu6z3WfW_p+BMbEJwf=OSGUXQB78kwQ@mail.gmail.com>
Subject: Re: Bug report: --invert-grep and --author seems to be incompatible.
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Wed, Jul 13, 2016 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jehan Pagès <jehan.marmottard@gmail.com> writes:
>
>>> git log --author=someone --invert-grep --grep=something
>>
>> But it does not work. Actually it looks like it just returns
>> everything (as though I had done a simple `git log`).
>
> Do you see a commit that is by "someone" and has "something" in it
> in the output from the command?

Indeed you are right! Commits which are by "someone" and have
"something" in it in the same time are missing.
So here --invert-grep works as a big "NOT" operator on the whole rest
of the command line, which is not expected (at least by me).

> I think --author=someone greps the "author " field in the commit
> object looking for the hit with "someone", and your request asks to
> show commits that either do not have "something" or was not written
> by "someone", I would guess.

Note that I can still see commits with "something", and I can also see
commits by "someone" in my results. So my request actually ask for
commits which have neither "something" nor are done by "someone".

Anyway I don't think that's the expected result, hence is still a bug.
Am I wrong?

Jehan

-- 
ZeMarmot open animation film
http://film.zemarmot.net
Patreon: https://patreon.com/zemarmot
Tipeee: https://www.tipeee.com/zemarmot
