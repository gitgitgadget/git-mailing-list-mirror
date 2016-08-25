Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1AB1F859
	for <e@80x24.org>; Thu, 25 Aug 2016 15:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759525AbcHYPLq (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:11:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35969 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759483AbcHYPLn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:11:43 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so7819377wmf.3
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bsbW1nvk5gldMiWjNbP84eST+mUI7WhErHv3gIo7uaA=;
        b=kCgxD5UvLrQbd3OskjT0rMyN25FArh3ffm8WzWfzESbJr6k0fCdrHGT2CW3cwaDiXB
         7d+nQX6c3AhhENfpI66pZPaITFCCmVvD746Zk/wES7y36u6qz5EdUkb+jOo+6nPh/SI0
         BzV3Ur4puuRoQPukmIAy4XFLoaiSxVA17+J4aO7DGPFJYLY+Y7LEPKLUB+2tbCX2tmTl
         SJn6IjoXsGa+OYzFSzARJY3I8YcpQacYCGJ6u3gMlTMSXCbosUqaEG43/Pgvb2YTBwB4
         dzRvDXTbvpMI4pfHpb6KRGv1jC+LHUKOZd3r0VkMb5PPUYE8tgGTxZ1QBYyAvNuhNSKk
         G3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bsbW1nvk5gldMiWjNbP84eST+mUI7WhErHv3gIo7uaA=;
        b=IoetIYE+L/kDn/NpV6EOHE4hlXHjEjuP6JcDrl9k0ApH0lZ8KG+1iJFHHFT1raT/Am
         XQ4satIl+Q2xAtrKY3bl6SdHUfKc5fPwMHc5dRYZHs5/U0aj31ZrMXiMxUVnQ7/jIstc
         mHq5A0t6Ad43YNhF86yhvcYCc74tKloZmziO/MRBXrL9JvtJg8jc/0Kn3nwvEF48qntj
         WQLpRBBP/+0jD1/X7OvpJohoUdBW3+OvxQ9lVoRlL0uJbivpm5L9h0Pb/xA4IhzIMOh3
         B/Goueke3ZcuUFw8OqMw5Xu8K34vaHdPHKP9exicv0iq1Hqfl/W17Id7GzxM4dfHexAC
         GwMw==
X-Gm-Message-State: AEkoouuwGUeMGOuioUg+x0wMNoQlaQm7YDT6iqXzH8uL2M48K0lsQMdc6X/1kSkV05VD/g==
X-Received: by 10.28.183.135 with SMTP id h129mr32175636wmf.2.1472136789817;
        Thu, 25 Aug 2016 07:53:09 -0700 (PDT)
Received: from [192.168.1.26] (afj243.neoplus.adsl.tpnet.pl. [83.25.139.243])
        by smtp.googlemail.com with ESMTPSA id lv9sm15531594wjb.22.2016.08.25.07.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Aug 2016 07:53:08 -0700 (PDT)
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
To:     Andrew Ardill <andrew.ardill@gmail.com>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <CAH5451n0=kmr9SeOKSH5iiJr5Lnr2TapfZrTUR6Pm90xUEKFxQ@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <90165dce-c508-4cb4-ec6e-c3d271181fe3@gmail.com>
Date:   Thu, 25 Aug 2016 16:53:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAH5451n0=kmr9SeOKSH5iiJr5Lnr2TapfZrTUR6Pm90xUEKFxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 22.08.2016 o 01:59, Andrew Ardill pisze:
> On 21 August 2016 at 04:56, Jakub Narębski <jnareb@gmail.com> wrote:
>> 25. What [channel(s)] do you use to request/get help about Git [(if any)]
> 
> It may also be useful to ask how people hear news about git, such as
> when a new release comes out. Not sure if worth a separate question,
> as there is a lot of crossover in the resources available for this and
> for requesting help, but knowing this information would help us
> understand what kinds of users are responding and which communication
> channels are effective for git news.

How would you propose such question would look like, and what proposed
answers would be (if it were not a free-text / essay question)?

Note that there might be a problem of severe bias: people who heard
about Git User's Survey 2016 are probably ones that watch news about Git.
Still, it would be useful to know if people read RelNotes...
 
> Related, it might be worth asking how often people upgrade their git
> clients and servers, particularly in corporate/managed environments.
> This question would ask two things, how long after a new release comes
> out do you install it, and do you install every update that comes out
> or do you skip versions. I suspect many would just use whatever is
> released in their distro and update at the same time as they update
> other packages, but it would be interesting to know if people, for
> example, only upgrade their managed environments every year/6 months
> or something to avoid introducing changes to their users.

That is, if people have a pattern to their upgrade of Git, and can
tell how often they upgrade.

XX. How often you upgrade Git?
    (multiple choice or single choice?)

 * as soon as new version is released
 * when there is new binary package / distribution package
 * when updating distribution / system
 * around every month, or more often
 * around every 6 months or more often
 * I use what is installed on system

Something like that?

Regards,
-- 
Jakub Narębski

