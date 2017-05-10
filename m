Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1145B20188
	for <e@80x24.org>; Wed, 10 May 2017 12:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751760AbdEJM3c (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 08:29:32 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:33606 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdEJM3b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 08:29:31 -0400
Received: by mail-io0-f170.google.com with SMTP id p24so131075ioi.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T1vr5p/Issq6m4szX64uPIIqx1k07V0IhE8+QNqVi+g=;
        b=BTbnlAlxvxdvHRiNkwRFWvYplIvLbGzrEa0y8bvPkGls++64hzLlouuSitM0epeUHv
         6Jolvrl8Tk8MBVeTWoG2JLQmyjQCz4cu6UUfCvwdpRRwCnx3NhQIljGCOdQwtn35TfzB
         0tU06D55soWZPHbJBsccUt58STnCDAGvgmkUEy73PUwiIhPYtJa3tTkV8hY0JYGv82uT
         P7UcIMxsyQxROOPw00jV941A/Tx+Ul9CMM+vOpQ5gDJdZk4vVUrekmZ8UN3/PrkcyYy5
         /C0O1rQraMvUOqkuSc7ZKuf2TstygcuZZakZFkioCaAlEetXlKc2jOB7iK9CrH7mdfjb
         8L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T1vr5p/Issq6m4szX64uPIIqx1k07V0IhE8+QNqVi+g=;
        b=PDbitvR7NxOHJR5KxO75CggBcoFY7Jfo6sUahU9/UVCG5jk6GDSTVc2LY5ET8r82+N
         p8Lbyk9roOK5JRbGKCEcGXtJmIFiaxBaLyK7UuHuERq9gxu8XvDz3aTWJsQLJqMEh1kc
         QCOBUra6MJUOdDJrEsA+BkmYs1Ff/OOcdWEeWASW1ZITRf4ROI3brBxuDNHKsBvlavpT
         khqZYv3tqE62xqEDZQHcaBb4ER3TqDQJ76IU5bg4JQJ0ReLw15BFpYLX9v5V2aMTYlyw
         FkQ7bEVtDrMzHcNOSUG8zYwmvAZU5qk97sQXuqpuUM70l9FbyKSbvbohuU6WNEXgAn5R
         6AhA==
X-Gm-Message-State: AODbwcCB/orRtzK8yMjmxYuphkIlFZM7jIbiEzvdF+KE2doagWzmTrrX
        DdwIdH/GxD1DKrJXWxJaT6eECbLlSw==
X-Received: by 10.107.201.131 with SMTP id z125mr2826072iof.160.1494418923225;
 Wed, 10 May 2017 05:22:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Wed, 10 May 2017 05:21:42 -0700 (PDT)
In-Reply-To: <20170510104343.GE17481@vireshk-i7>
References: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
 <CACBZZX4pz26SCZBbivDneRX6hRPxpuPHXpOQKnn1zJL6xWj_Eg@mail.gmail.com>
 <20170510103400.GD17481@vireshk-i7> <20170510104343.GE17481@vireshk-i7>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 10 May 2017 14:21:42 +0200
Message-ID: <CACBZZX6zVY=Nq9UZxK+ABtvfKF5Wi-QsGV4vRhg=S70x-YS3AQ@mail.gmail.com>
Subject: Re: [Query] Override sendemail.tocmd
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 12:43 PM, Viresh Kumar <viresh.kumar@linaro.org> wr=
ote:
> On 10-05-17, 16:04, Viresh Kumar wrote:
>> On 10-05-17, 12:18, =C4=86var Arnfj=C3=B6r=C4=91 Bjarmason wrote:
>> > On Wed, May 10, 2017 at 9:23 AM, Viresh Kumar <viresh.kumar@linaro.org=
> wrote:
>> > > Hi,
>> > >
>> > > I have a use case and wanted help from you guys..
>> > >
>> > > I have set the sendemail.tocmd option in my kernel's .git/config
>> > > file and that works very well. But sometimes I want to avoid that
>> > > (for example sending the patch to someone without the list and
>> > > maintainers).
>> > >
>> > > The suppress-cc=3Dall option works quite well to avoid almost
>> > > everything (including running --cc-cmd), but it doesn't suppress
>> > > --to-cmd.
>> > >
>> > > Are there any specific reasons why it is being done that way?
>> > >
>> > > Currently I need to go edit my .git/config file and remove tocmd
>> > > before sending any such patches and it sucks :)
>> >
>> > Does something like this work:
>> >
>> >     git -c sendemail.tocmd=3D/bin/false send-email ...
>> >
>> > ?
>>
>> That failed. I tried with 2.12 version first and then on the next branch=
 with
>> version: 2.13.0.303.g4ebf3021692d
>>
>> $ git -c sendemail.tocmd=3D/bin/false send-email --to vingu 0001-abc.pat=
ch
>> 0001-abc.patch
>> (mbox) Adding cc: Viresh Kumar <viresh.kumar@linaro.org> from line 'From=
: Viresh Kumar <viresh.kumar@linaro.org>'
>> (body) Adding cc: Viresh Kumar <viresh.kumar@linaro.org> from line 'Sign=
ed-off-by: Viresh Kumar <viresh.kumar@linaro.org>'
>> (to-cmd) failed to close pipe to '/bin/false' at /usr/libexec/git-core/g=
it-send-email line 1687.
>
> And even if this worked, I believe that the right solution would be to fi=
x
> suppress-cc to include tocmd also. That's the whole purpose of suppress-c=
c
> option.

Indeed, it looks like either there should be a new option or the
existing option amended to work with tocmd as you suggest. I was just
wondering if there was a way to do this now, even if with some
non-obvious hack.
