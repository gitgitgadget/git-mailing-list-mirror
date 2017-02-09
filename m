Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E331FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 22:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753476AbdBIWSW (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 17:18:22 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34057 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752704AbdBIWSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 17:18:16 -0500
Received: by mail-pf0-f196.google.com with SMTP id o64so45974pfb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 14:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MNrbLWz7AVUnZM8VHU1ViYme2gLLTfV9KNWAlpW4vb0=;
        b=V3zGQOt63MEY0hrRYXfTHFP4hFirApPv4WAoCPKwuZ6PO8TCbbPDQDzAfGvqDswQmW
         CqTUNXQMOqN3Xml6riuDrackF5OnoZ8b6elqEF6KUH9BY2DK2h7nQFwinwYaj7abGDqD
         1Uyi8vgtUisU4yliLaJs8+sHJ9IXK6zR0C8cTwdPKG+fDqY8N4tfPSBF7pz4ZSoC8F0M
         l2f9VbDayk4gLmcmSaMvnkGVOagrCTay5GYWHvumJ0l8E/SiFR6DSIlCJvUhbDbf9kGz
         1ZlkqQykU15p2iWMmko4JZBzOy7LV+yHOYmlO2dLxtr+GBA9owrV6eC0QaBEcG8wb402
         sFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MNrbLWz7AVUnZM8VHU1ViYme2gLLTfV9KNWAlpW4vb0=;
        b=OU4VAA0lL870fKvE0VTVd2Wmp2VzHIfbgHElKZLyJCLZ/ulB3CFu/Oh3sqpG9HBc+S
         1Y+Hxz9exR4HCxbzU+EN8v4aao7Ige3tY1e6cpm/s+v9/jBysk/MaQDHDR1hsaXPm3U+
         KH79PKRsHsHMonloZVL6n3uPMEqyWLVSjjLTNKD5TC5nldv53MK6AlvLy2jXlrdbGyP0
         BeoYGqkboaJLCnR/Mq9o0TBOFJYG8w54UV0OlNwgjCilvX/dz/0zGPdtGltbIMy24VoS
         73pnvnqOwv0GJSdJZ7OCavVjsRqrCotWVo868JsaVVas2UqPvPtrpN2nu4HP2oeEEd58
         NupA==
X-Gm-Message-State: AMke39lZRYLK8TjrayUUw1j9vqeBtvs7Bc7iHrsRIDw21mn3Sl5n0lSTGMmQdReV29rTlA==
X-Received: by 10.98.206.6 with SMTP id y6mr6178058pfg.122.1486678681819;
        Thu, 09 Feb 2017 14:18:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id x2sm31287144pfa.71.2017.02.09.14.18.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 14:18:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: Cross-referencing the Git mailing list archive with their corresponding commits in `pu`
References: <alpine.DEB.2.20.1702041206130.3496@virtualbox>
        <xmqqwpd316f7.fsf@gitster.mtv.corp.google.com>
        <3F7E4C9E-593E-4FC5-B820-E6A0CDEB7476@gmail.com>
        <alpine.DEB.2.20.1702092242120.3496@virtualbox>
Date:   Thu, 09 Feb 2017 14:18:00 -0800
In-Reply-To: <alpine.DEB.2.20.1702092242120.3496@virtualbox> (Johannes
        Schindelin's message of "Thu, 9 Feb 2017 22:53:34 +0100 (CET)")
Message-ID: <xmqq8tpfnh47.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > E.g.
>> > 
>> > $ git show --notes=amlog --stat
>> 
>> That's super useful! Thanks for the pointer!
>> Wouldn't it make sense to push these notes to github.com/git/git ?
>
> I am not quite sure about that. It is in a different namespace than what
> is usually cloned, and it currently adds 8MB to the download (there are
> "amlog" and "commits", the latter clearly being a sandbox).

I do not think the public mirrors of the primary repository should
get amlog, either.  It is more suited for those who are interested
in broken-out topics, i.e. git://github.com/git/gitster.
