Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B7B1F453
	for <e@80x24.org>; Sat,  2 Feb 2019 12:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfBBMda (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 07:33:30 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51080 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfBBMda (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 07:33:30 -0500
Received: by mail-wm1-f53.google.com with SMTP id z5so770870wmf.0
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4HiiLtkMazyU+hIVpuh6hoPWsf5DHngIWzzsAO7wG0I=;
        b=t6hxEiYpk9rNxQm8T1A1xmxIxLz+KigW/T/2kd8FJR0e9R20GzoK+B/408RwKLWTKv
         KOOheu7rlbFudWmXkppVb7b2H405ug7RBPfZlt7AbYH98PNrd50UcEpagzcFGG1mnzuU
         26GtZyKMzBJ4f67c6/kTNhK8VY7vwnQXd4llI8iPspPzMLXM1YJsAxigfY6XiTg/NXya
         +fhUnGaxZCwrof7NdwzEaQtzzTdP4dQ8MRleMTQf5L2pFtMgdAkxQsrzYHfhkxT1+vDr
         q3gtdnCBr+8lsFLweH48gPWDnTEBjPxRVy0IwPe6vtyO7WNuXRk8o1neWvrLqmw+YcY8
         S7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=4HiiLtkMazyU+hIVpuh6hoPWsf5DHngIWzzsAO7wG0I=;
        b=LLROoLU7YtAKrrHWd+G3VoKTC4I+juUZXVhV/XQ5BqLL3yi8MAT7oGz2MqX5zYKHBa
         gaH5UtFaPr+PObZXuj54Yz0fK/MtS1YrSwyyvvcI82qYZO9VoVSmovmXUvKzSMejj1JH
         TOX0rWIS2TBNlk+lDkuwy1EF2kdoV9HwxvnLwDu11EG6q2Y4zi58WdkaEPctz+doRs/x
         Cb7fA3XcctLufKwGjrQyxCFf79MFRVquyoWh0kxTi8LMqIkTqhV4EpcziR2mdBZTSncd
         mJJCLRO0PEn8fbN74jCuX7i7AyS+uYdNODZYW3pQYnkl9jVuYrKEeJzWYI5SUhS6CTtl
         yqTQ==
X-Gm-Message-State: AHQUAubaqobFLLuWYyiRMoS57bWx3FTJDSl1n9g1eJLmMsGbYDX7wNK/
        HiNvx2xFkd5aeH03YyBbfdoUhr8U
X-Google-Smtp-Source: AHgI3Iakj8Hfa9+uauWbxBul4J/nXgqwi2X/vhmvJZb/PCIJdG2oLbx2aKsc+6MhhBO4ZyOiO7Kq3Q==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr6215473wmc.87.1549110807645;
        Sat, 02 Feb 2019 04:33:27 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (egc230.neoplus.adsl.tpnet.pl. [83.21.66.230])
        by smtp.gmail.com with ESMTPSA id o81sm11988505wmd.10.2019.02.02.04.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Feb 2019 04:33:26 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Contributor Summit Topics and Logistics
References: <20190122075027.GA29441@sigill.intra.peff.net>
        <20190130230702.GA25423@sigill.intra.peff.net>
Date:   Sat, 02 Feb 2019 13:33:22 +0100
In-Reply-To: <20190130230702.GA25423@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 31 Jan 2019 00:07:03 +0100")
Message-ID: <86va22qsj1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jan 22, 2019 at 02:50:27AM -0500, Jeff King wrote:
>
>> If you're not coming, you can probably stop reading this message now.
>> The rest is all logistics.
>
> Here are a few additional last-minute logistics:
>
>> For people who want to try to join remotely, I don't think we're going
>> to have a particularly fancy AV setup. But there should at least be a
>> big screen (which we typically do not really use for presenting), and I
>> hope we can provide some connectivity. I'll be visiting the venue the
>> day before (Jan 30th) in the late afternoon (Brussels time) and I'll try
>> to do a test run. If anybody wants to volunteer to be the guinea pig on
>> the other end of the line, I'd welcome it.
>
> The remote connection will be done via Zoom, using this URL which will
> become active shortly before 10:00am (Brussels time):
>
>   https://github.zoom.us/j/186903655
>
> You may need to download an app or other software; solutions are
> available for most platforms, and the zoom site should guide you.

Thank you very much for setting this remote connection up.  It did make
it possible for me to watch the Git Contributor Summit 2019 (and take
notes for Git Rev News).  I have had Zoom installed already, so it was
not a problem.  (As I have seen, Szeder G=C3=A1bor was also spectacting ;-)

The audio was not always clear, which depended on where the person
speaking was positioned; I understand that it is a very difficult
problem to get good acoustic in such unstructured setup.

> Note that this is _not_ configured as a one-way webinar. It's a real
> video-conference where joiners can participate in the discussion. So
> spectators from the community are OK, but please leave your camera/mic
> off if you're not actively participating.

As far as I know it went untested (but then nobody announced that he or
she wants to actively participate remotely).

I didn't stay for the 15-17 breakout session (talking in individual
groups); I wonder how well the remote connection setup would work with
multiple discussions in parallel.


I have noticed a little 'recording' indicator; would recorded session
(video or audio only) be made available at some point in time?  Did
anyone take minutes, or take notes (for example of the Summit agenda
created at the start of the meeting -- when the audio was muted)?  I
would be very interested in your impressions.

> See everybody tomorrow at 9:00am.

The event actually started at 10:00am CET.


Thanks again,
--
Jakub Nar=C4=99bski
