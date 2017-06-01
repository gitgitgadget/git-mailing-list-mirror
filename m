Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FA1E20D14
	for <e@80x24.org>; Thu,  1 Jun 2017 22:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdFAWJH (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 18:09:07 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:35245 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFAWJG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 18:09:06 -0400
Received: by mail-it0-f44.google.com with SMTP id m62so2643501itc.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=flUZio8dXwvZIrZo+LmbX2XhPZ1VbyYrbXhxsGGTrQU=;
        b=JXmGIEwO4G7SqgRKzHt8LPmi/094jCf2biNgMt2J6I7S6OPaPhwyboPvWYpaKLKDBC
         Ej8dFDPYFg7qlzJhJxytecnYopw+aFmCGNd3iGmmyxaObq9L6+3Fxs/eaGMkOdDJRozt
         be8ED+GoJra0oNIqQrPrFT7GrH9pcTK1Jy6IXl1bFbQLb2Gf+QLf8m4+pSRYqasvmE/z
         ulZr0C97rchZT0FMjuaMsXy6A+orXdCmyPiPUEePhSoK3FVC19boiVE3foxDOjEVx/JK
         wxiPUYVyE9N6bS5Luq7JXRC1b9PT/Og0jxbsvMXlzxOC1WI2DMFVRexxAHmJXR9u8Ktd
         7JVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=flUZio8dXwvZIrZo+LmbX2XhPZ1VbyYrbXhxsGGTrQU=;
        b=TU4UdNm9A4uA5YHFXzvCqWG9ab02JIs0x6HhEtFvSuh6fLp39e+SbDkb7iBw/qBi2v
         sOdm5Ma9FFuwdqYyBc0IDMMQn4lLL9ec80yWg+cK6aotpnIVJf492dxpvZoIub4gIiIY
         d/XDdhGFH31zUlQ158g5kqdU6V9dllT8q+wnDpjo1FpboSlRK0LIK7EJHSrroxx00tgM
         q5GGJVCoH8mry98g7crHwxyPGlqogV87VpwVEAB2AZZDJj0T/k5hchl+42fCYatCyKyQ
         KpNrIeDoeHt6NxvTlESJlpKcB+q4lwir0z3IJOeuyqa444z4hSIB+370X4eXK61khXGk
         /8wA==
X-Gm-Message-State: AODbwcCJN78UDgR2P7aPn9m9I5GKLnwnrMrPT2c3KLGPp0086EQaEBpi
        1v25PnpiW9oKXzmGF/GgA4jHn7LoFw==
X-Received: by 10.36.222.69 with SMTP id d66mr1733566itg.14.1496354945709;
 Thu, 01 Jun 2017 15:09:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.5.13 with HTTP; Thu, 1 Jun 2017 15:08:25 -0700 (PDT)
In-Reply-To: <20170601152624.GA29442@alpha.vpn.ikke.info>
References: <CAMOGhMJyO=+EZz6qCejxeTe5FdE=RheJX9A5g3U6eKhUKj8_BQ@mail.gmail.com>
 <CAMOGhMLMo82RgH0HareB78KVWz2gMGzhB1i5s3SobW9wHk0zbg@mail.gmail.com> <20170601152624.GA29442@alpha.vpn.ikke.info>
From:   SJR <haltekx@gmail.com>
Date:   Fri, 2 Jun 2017 00:08:25 +0200
Message-ID: <CAMOGhM+6wyKMN-XtMNSopjy399_CS7gavgvgybswXeQ1uxtrKQ@mail.gmail.com>
Subject: Re: wrong language translation part7
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So when v2 will be translated to Polish?

Regards,
JanR


2017-06-01 17:26 GMT+02:00 Kevin Daudt <me@ikke.info>:
> On Thu, Jun 01, 2017 at 01:16:11PM +0200, SJR wrote:
>> W dniu 1 czerwca 2017 09:43 u=C5=BCytkownik SJR <haltekx@gmail.com> napi=
sa=C5=82:
>> >
>> > Hi,
>> >
>> > https://git-scm.com/book/pl/v1/Dostosowywanie-Gita-Konfiguracja-Gita
>> >
>> > part in polish part in english.
>> >
>> > Can You repair translation?
>> >
>> > Regards,
>> > JanR
>
> The progit book is not maintained by the git community itself. You can
> find the project at [0].
>
> If you look at this specific chapter in the Polish translation[1], then
> you'll see that that chapter is just not completely translated. Someone
> would need to step in and finish the translation.
>
> But note that this is version 1 of the book, while the latest release is
> version 2. But that one does not have a polish translation at all.
>
> [0]: https://github.com/progit/progit/
> [1]: https://github.com/progit/progit/blob/master/pl/07-customizing-git/0=
1-chapter7.markdown
