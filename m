Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A25201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 02:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbdBUCWz (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 21:22:55 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33091 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdBUCWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 21:22:54 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so15491594pgj.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 18:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CyMSRjW+sQx3WZxg2kuzOgbqvlpZQXBwb0gMNl8la8g=;
        b=bEQ6sWr+iyrR+gCdlCknzEPYrCk1qtdpoaC+IX166LJbCyG3XDKdbyhNcEpcUCcgW+
         Z90LG0O2rH2DHf54DA/IXrEektT6HJSyosndJClLn/uF9FiFpTjprnuBkb/BP4MVfDM7
         g7fPeq4Wc3OHNtl+VsqrWP5H+akYmQVTwiiJ0RRdW76nCsWq2aqCkuEtiXdKEEzAM/wf
         w+3s9V2LGvijw5qnJKeJqmrcy9f/iqCg9TArPNqNDhtd/D4WdUvsvhCSkCZFQyIwuNS0
         hch9nz4LUVAd5IT4iI/7NHmDsafIs/HBfxOvBz7KPC27QqEttX9m8gnV3D1nONtUNdJl
         caug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CyMSRjW+sQx3WZxg2kuzOgbqvlpZQXBwb0gMNl8la8g=;
        b=dna2J50iYK1rWEsTwgCv9gqEk9CEjjHe3+3yHln7tMhTEd1z5u9X/NL0C2UWPskjYI
         R1YPVsoCGgsKjEzdMwtKQw+1ByHWA+bPlHSWna5LBYSS4MFNYJAyWGQpSsOjb1o7V2pF
         Lcb1xKZfZrJSl8ZDuRncDZ0ETk07p8BVgnvzG4c6iOt9A9AVa4TlKg+3hmosxi36hn+0
         rmr9X3tJdBvyaOwn+6jfPhSv/fkTSZVuF7jYQeAQC718qng5e/EJ9RTxjn/8j77HRWTv
         tNudSz3/0w45K3RRksil63E3YyVd0zJAVA948hBuXBUpQ4uFlB2xYovCFhw60JtVp/Hx
         8oNw==
X-Gm-Message-State: AMke39mfdX9MrPdbvFD1QmRy/gGLpeC02ZhQlUPScqTF7gjL5kzXa4EM+FAsEG1kF29Jow==
X-Received: by 10.84.238.1 with SMTP id u1mr36552689plk.174.1487643773546;
        Mon, 20 Feb 2017 18:22:53 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id b67sm37250750pfj.81.2017.02.20.18.22.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 18:22:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Leon George <leon@georgemail.eu>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: slightly confusing message
References: <7cca3326-d6b5-4669-7256-ab275567b72e@georgemail.eu>
        <xmqq1susk43m.fsf@gitster.mtv.corp.google.com>
        <8e66c3be-7cd9-d72c-123f-308b63ddc1bd@georgemail.eu>
Date:   Mon, 20 Feb 2017 18:22:51 -0800
In-Reply-To: <8e66c3be-7cd9-d72c-123f-308b63ddc1bd@georgemail.eu> (Leon
        George's message of "Tue, 21 Feb 2017 03:15:07 +0100")
Message-ID: <xmqq8tp0i8p0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leon George <leon@georgemail.eu> writes:

> On 20/02/17 21:19, Junio C Hamano wrote:
>> This sounds vaguely familiar and indeed I think it is this one:
>> https://public-inbox.org/git/CAEnOLdvG=SoKFxeJ_pLmamGj_8osC+28TSg+pbFLLTr+ZLcpQA@mail.gmail.com/
>> which was from late last year.
> Which means I should have found it before bothering you.

It means no such thing, though.  It just means that I happen to be
more familiar with what has gone on the development recently than
you were ;-)

>> I suspect that the issue may already be fixed at the tip of 'master'
>> (aka Git 2.12-rc2).
> You're absolutely right. Took a while to build, but here goes:
> ...
> Splendid!

Thanks for confirming.
