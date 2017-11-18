Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51DE8202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 04:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932518AbdKREMc (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 23:12:32 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:44519 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754597AbdKREMa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 23:12:30 -0500
Received: by mail-qt0-f182.google.com with SMTP id h42so9215807qtk.11
        for <git@vger.kernel.org>; Fri, 17 Nov 2017 20:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=stgW2QAnOsy3Ak3Yfst/tRTskScUXfdruDwiM6ukIyQ=;
        b=Ga9zGXpMpCjmDQO8/ZCYM8OMIFJpkLqTmk8wyTGyHAVYj91Dq1/DOALjGF1ySkMacb
         RshpU2Rtqh0eeAYdkmI1z44rNcZNV4hzFL0/MO5AjN0PaycBiBmbSy0S4y9hTLplytC5
         cd1sT+gHrMJa8EArcloydye8jZY5esuOBqUtFEBfPCLS5MGex+MKj0rRHQfd2bObaJyt
         V924nBPcQm94U0VzgVLuEriLexg0lMzaiDhNl+20nH1Mb1M3YeLIt26wYaYCHSS8a0pn
         I3ULlE46uQI+I5g019YRcMNIBaA80Hy6is0er2SP78QjSS1vP/ZlcCAqrRZdZePdqg7+
         FdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=stgW2QAnOsy3Ak3Yfst/tRTskScUXfdruDwiM6ukIyQ=;
        b=Oyz7h1AqSDIB0dgZhInclVJrrFKpTqEVTs9sXZ6jXgJYBdgSVwuLWxL01Y2a0WajKr
         2T/fg3ea1/8cOTpIDLk9/2yGpDV3HZXnnH9hA8XF+cnyLb6/bSjOvdT3IqLSokZA7d62
         seJQoW3xgsp+vEMn/W5Igi84nugPY4HxVb/0ZZArG09CRPLEK7QxMFsbt7pRKQdAK8/g
         AqHmsfBZMLqOn+yTpWOJ06sBJo64qTRQJ7C2eWPASrx1dq0gXHpVTj4FcZJHbNAIgIpU
         Wu0X7WQP1E0DCkSzaAat92R7nN2jfzqNpt43EvO9VqCt2HsAFRFHO8gI5h3KLSvQv1HG
         /A2w==
X-Gm-Message-State: AJaThX7qqU+fBoKarv7XykEhTJwtXD8wCO5AfD2lcTAEMocxpA8Rqc8z
        aSUDzGfSeI+8GFl/CcwEgZGS0RZk2j+V5aIJbpe7ow==
X-Google-Smtp-Source: AGs4zMarQ2NTdXWN/yoEfLake69Io2Ivu2Bev4TsXfJHC6LNy5N0kxSNLNgZKsCHIYE6xVClUmYiCpDMqf8unoN5EL0=
X-Received: by 10.200.15.249 with SMTP id f54mr11649045qtk.216.1510978349812;
 Fri, 17 Nov 2017 20:12:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.54.4 with HTTP; Fri, 17 Nov 2017 20:12:29 -0800 (PST)
In-Reply-To: <xmqqzi7kp7j2.fsf@gitster.mtv.corp.google.com>
References: <CAC2Jkr+brEKLy-z45WwP2iqssA14na9xpaCoKrNKbPcTvtUxJA@mail.gmail.com>
 <xmqqzi7kp7j2.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?5bCP5bed5oGt5Y+y?= <aiueogawa217@gmail.com>
Date:   Sat, 18 Nov 2017 13:12:29 +0900
Message-ID: <CAC2JkrLWVEHvV7tf24bPmVEDpgnrKTFtHR5UHMh+kC8v_fWumA@mail.gmail.com>
Subject: Re: Is it not bug git stash -- <pathspec> does not work at non-root directory?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Please make it a habit (not limited to when interacting with _this_
project) to state a bit more than "does not work"; instead, say "it
is expected to do X, but instead it does Y, and the difference
between X and Y I perceive is Z".

Thanks. I'll rewrite the issue.

Assuming that we have sub/something and something is not included anywhere =
else,

        cd sub && git stash -- something

 is expected to make a stash for sub/something but instead returns error li=
ke

        error: pathspec 'something' did not match any file(s) known to git.
        Did you forget to 'git add'?

.

I don't know what I should write about 'the difference between X and Y is Z=
'.

2017-11-18 12:53 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
> =E5=B0=8F=E5=B7=9D=E6=81=AD=E5=8F=B2 <aiueogawa217@gmail.com> writes:
>
>> Is it not bug git stash -- <pathspec> does not work at non-root director=
y?
>
> Please make it a habit (not limited to when interacting with _this_
> project) to state a bit more than "does not work"; instead, say "it
> is expected to do X, but instead it does Y, and the difference
> between X and Y I perceive is Z".
>
> If you mean
>
>         cd sub && git stash -- Makefile
>
> does not make a stash for only sub/Makefile and instead makes (or
> attempts to make) a stash for only Makefile at the top-level, then
> I think it is a bug, whose likely cause is that the implementation
> forgets to prepend the $prefix to the pathspec it got from the
> command line.  But I am writing this without looking at the
> implementation and with your unclear description of the issue, so
> I may be completely off the mark ;-)
>
> Thanks.
