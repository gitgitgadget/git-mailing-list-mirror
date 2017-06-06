Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FCAF209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbdFFSwY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:52:24 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35659 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdFFSv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:51:56 -0400
Received: by mail-it0-f67.google.com with SMTP id 67so28593078itx.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GlrYxGrZnpX+NYJbKbpPZ9yFje+A7jHY0Ie3rO4rBMQ=;
        b=CE07g+6v4xfCOzdU1AZbRsqybiYbL3N/lci0h4bsafPAKn6VuHuXc5M80tOvIqEJy4
         lYu0KukhcJOWzP68CgAykf2kHdj9+8UVTGOzdIBvF0Axso/jWUt/RXCFLyrslB4GyIEW
         wbGRWPc+WRxFqkpEjrNpo9D7pvGGTHXey1S7VfgbsSbbxkZRLjW7cJqk0fpVhKXkw4e7
         hKq3sC57/8RkTz55pZco1QDIFTWey4ysHARNsY4XWNoXEl6Zq4oFjuZhlfdZr3QWdHx3
         vLX+kou/0UUvOT0J4MnD9M2RJH0weFte/7ZIoDztM3pOfuSfX9jNYgC6npepFzxUD5GW
         fcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GlrYxGrZnpX+NYJbKbpPZ9yFje+A7jHY0Ie3rO4rBMQ=;
        b=fDKk3ZWwRitJoa2h7RVD0g40So4bcWsODcUY338hJwwHl8Arwvnas0hyLhqAj5oDc9
         WAoq90Zw7bNHctR0lyYq3+JHQnDqWUiJdvchQj8OUKm3MSKbzLKi0V/IhEah9nYOUIOA
         yev0sHQMXujxTLcD7H89Kp6zKctthMjEgVXyj6jrxOkBczLIq7BMMNOiEZdVuqwtLpsc
         YtNcKY1nMpWcma6b9NfkrNNYzcXBzYnV/m0/lrifHSCGMbKkapc1YvTyGF702fNuzQYC
         SNnsqR1Nm0fACOuhZqRGOHwKpnyDS9NlyOw8lblkhQMXKBHj14T9gVh4eIxkwIqINQGQ
         lZMw==
X-Gm-Message-State: AODbwcBj271aSg/QvV1qJVKRJ7Vs1hXIwQJXPYKDQnvsd84cdnXrmi9z
        AqmpvHm7M8rfwA1f3l5I3SwRtaZ3kw==
X-Received: by 10.36.233.198 with SMTP id f189mr18447335ith.94.1496775115883;
 Tue, 06 Jun 2017 11:51:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Tue, 6 Jun 2017 11:51:35 -0700 (PDT)
In-Reply-To: <CAGZ79kaaRsUBAxRKLPxjuk=oRrw2zBdoHWd9iNDmTbY9MpqN-w@mail.gmail.com>
References: <20170606124323.GD25777@dinwoodie.org> <20170606151231.25172-1-avarab@gmail.com>
 <CAGZ79kaaRsUBAxRKLPxjuk=oRrw2zBdoHWd9iNDmTbY9MpqN-w@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 6 Jun 2017 20:51:35 +0200
Message-ID: <CACBZZX485+W99mRspDTf09LjP-C26PaAi+vNSBkW_aVyXAsQJg@mail.gmail.com>
Subject: Re: [PATCH 0/3] update sha1dc
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 8:23 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jun 6, 2017 at 8:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> This updates sha1dc fixing the issue on Cygwin introduced in 2.13.1,
>> and hopefully not regressing elsewhere. Liam, it would be much
>> appreciated if you could test this on SPARC.
>>
>> As before the "sha1dc: update from upstream" patch is what should
>> fast-track to master/maint and be in 2.13.2, the other two are the
>> cooking submodule use, that's all unchanged aside from of course the
>> submodule pointing to the same upstream commit as the code import
>> itself does.
>>
>> Junio: There's a whitespace change to sha1.h that am warns about, but
>> which it applies anyway that you didn't apply from my previous
>> patch. I think it probably makes sense to just take upstream's
>> whitespace shenanigans as-is instead of seeing that diff every time we
>> update. I guess we could also send them a pull request...
>
> I would suggest the pull request.

Looking at this again it's not a bug, just upstream choosing to indent
a comment with spaces, not a bug.

So it makes sense to just apply as-is so we don't have that diff with
them / different sha1s on the files etc.

> Also as to not make the mistake from before that I jump on the
> submodule bandwagon here:
> Patch 1 ought to go in its on series/patch, so with that out the way
> we have more time to consider the pros and cons of the rest of
> the series?

Yes it makes perfect sense to just take the 1st patch here and make
the submodule changes cook. This is just how I submitted it the last
time and Junio took the 1st patch into a maint topic, so I figured I'd
send it like this again.
