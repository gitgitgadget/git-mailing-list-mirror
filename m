Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B34208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 03:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbdHWDz0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 23:55:26 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:34468 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753142AbdHWDzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 23:55:25 -0400
Received: by mail-ua0-f178.google.com with SMTP id d12so1884267uag.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 20:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H0e4q+MOgB0+XwYj5VfwCSg/3nwHUL8ouiD3LHBJzuE=;
        b=YoBq3D7DmJJiqKRwbLcV5YUvuRR5kOurqGapRm8k49iBn8iKlbqM+7BN56NJtpslte
         inMpd/HMEjkVj93d5QVJdkdY/C5bBj7vvlUatvcK3JIHIhibcpqCjGWsWe2UsU8pLYSI
         kAnj4bckwWCvBY1gYOpoUMNvyw75Vi+iTtpVN76wsI0pyD6jpQpY4J1vCL94QQ0Kw2D2
         2sE4HJ5wv7BHteUcwyeJi7G7QkCIl46TP1QagNw8iPkQ8/zOlc1CaItA3x4ncouUVXZX
         MR5CKPEYtXu3dp3Z88HHlx5KC5couGG1UB6LPVq63AiOCnhjZ3O9vb1UlGrj2wHxoA/E
         TOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H0e4q+MOgB0+XwYj5VfwCSg/3nwHUL8ouiD3LHBJzuE=;
        b=bsN190i9v/8Sz2g4m6F6nWTILaI7vUq/EYZ6+TS7ybirckcfPa+zJJsoe0R5h+s/Tt
         iO2eVTch+5nQ8Zh9cfmH087CizwhgB02hUJMybiS1nlllHyNBApFDQ3Pn+1aWZ1E8Fkz
         +/VyZYxM7G1+wP9gFrUEzCP/MILFnjIJZglQ5pj0uz/sYaMVXzMRp7svCNbYIHk/WzwW
         M519UhxH84K9Cdt5N1K6lmXkCgpPIO744tys76ECGUtI6np6SLmS3zbrPOT/xa8JENG8
         WHBaK52afz7StlEvmoqPpqii6EDk/+sveKIk0/iuU9md0LFIOXpxCZzwW0ayyHDrvqxn
         qZRw==
X-Gm-Message-State: AHYfb5jlrlOz9x8213DoLqIwuiB6CHEB00t67BWMU1CVK+yLEYhg9EdA
        WKOyVA9LeIlEtxkyW4l72BcPKMArBQ==
X-Received: by 10.176.65.193 with SMTP id 59mr946064uap.83.1503460524792; Tue,
 22 Aug 2017 20:55:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.111.68 with HTTP; Tue, 22 Aug 2017 20:55:24 -0700 (PDT)
In-Reply-To: <xmqqmv6s5yzn.fsf@gitster.mtv.corp.google.com>
References: <CAJXxHvVzTrhJk6pFsOzUKBuU2VcW41-tMk5A7s+rxXsacXpppw@mail.gmail.com>
 <CAN0heSrh_+J=LQnGZtngxQbcHAjFhX9vPKKDa7_ORz4iDpXf=g@mail.gmail.com> <xmqqmv6s5yzn.fsf@gitster.mtv.corp.google.com>
From:   STEVEN WHITE <stevencharleswhitevoices@gmail.com>
Date:   Tue, 22 Aug 2017 20:55:24 -0700
Message-ID: <CAJXxHvVSXkQ4SYA5=ZtnWZCBbVk51oWY1OqM_XbGNoruyAGBrA@mail.gmail.com>
Subject: Re: "Your branch is up-to-date ..." is incorrect English grammar
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, Martin and Junio. I'd be happy to review any patches. Thank
you both for your help! :)

(incidentally, I've had a devil of a time sending my two emails on
this topic--a total of 5 bounced mails for various reasons: didn't
like my email format, didn't like my email address, mail client, I've
had 2 syntax errors! I've only had success by sending via Gmail,
plain-text, in a browser; and God only knows whether I'm wasting my
time typing this. I'm not used to this world, so the bar is
sufficiently high and irritating that I'm very disinclined to dip my
toe into these waters again, which is a shame).

On Mon, Aug 21, 2017 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>>> But =E2=80=9Cyour branch is up-to-date=E2=80=9D is INCORRECT. And, beca=
use it=E2=80=99s
>>> incorrect, it conveys an odd and unsettling experience to native
>>> English speakers whenever they read it.
>>>
>>> If you=E2=80=99re curious, you can find plenty of discussion of this po=
int of
>>> grammar. Here=E2=80=99s just one example:
>>> https://english.stackexchange.com/questions/180611/do-i-keep-myself-up-=
to-date-or-up-to-date-on-something.
>>
>> There is also some previous discussion on this very list:
>> https://public-inbox.org/git/CALFtnmeRxgetuCVbO8ZmVkCR302vQ2s4hTPoHxAe5N=
EfmjtXEg@mail.gmail.com/T/#u
>>
>> The code base contains a few instances of "up-to-date" and "up to date".
>> A tree wide sweep could be made to update user-visible strings in the
>> code and in the documentation. Fixing source code comments seems like
>> overkill.
>
> It should be safe to update any message that is meant for human
> consumption (i.e. those inside the _("... message ...")) i18n
> marker).  As the use of "up-to-date" dates back to the days when
> Linus was still doing much code for our project, I suspect there may
> be some plumbing message that contains the phrase that scripts
> expect to stay spelled that way, and it is not OK to "fix" them.
>
> Thanks.
