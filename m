Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C28C11F453
	for <e@80x24.org>; Wed,  7 Nov 2018 23:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeKHJGk (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 04:06:40 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:57214 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeKHJGj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 04:06:39 -0500
Received: from [192.168.1.12] ([92.29.15.216])
        by smtp.talktalk.net with SMTP
        id KXKegnQKNAGVrKXKegdsTl; Wed, 07 Nov 2018 23:33:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1541633636;
        bh=CE6UTvQstA1xKsPGNpShYLh685tTK1LtiJxfLGrpuPU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=YOczwnG6rUWPS7sC6OPVO4huTGO0YukuqPdbRAhAqTXywRY5GESv3F71jw/uAl+NI
         oHe5L7ID6cGdFj5ujgi8je4EjH2GMFU0XAJoal3vk6kXdZueC7dm2m9umZhFQfOO84
         iBEKgNHlluCjNe3L1vadch1KWDxg/gnfVAYxy8Ek=
X-Originating-IP: [92.29.15.216]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=nW19o/PZ5qZJ0p49dqPFUw==:117
 a=nW19o/PZ5qZJ0p49dqPFUw==:17 a=IkcTkHD0fZMA:10 a=1YunhJp0st90rSj4sjEA:9
 a=QEXdDO2ut3YA:10
Subject: Re: What exactly is a "initial checkout"
To:     Christian Halstrick <christian.halstrick@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, rene.scheibe@gmail.com
References: <CAENte7hoHxQCiQwSaAGPyaeFK8rb2Q23DcbePd01fcvgxtodZg@mail.gmail.com>
 <xmqqa7mleond.fsf@gitster-ct.c.googlers.com>
 <CAENte7hN6=ChSWHKo=cawvwV_2xVDW0uCRY+yAjAgCz8_TtpmA@mail.gmail.com>
From:   Philip Oakley <philipoakley@talktalk.net>
Message-ID: <f81eb37d-e432-7451-6472-7ddc0874d0c7@talktalk.net>
Date:   Wed, 7 Nov 2018 23:33:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAENte7hN6=ChSWHKo=cawvwV_2xVDW0uCRY+yAjAgCz8_TtpmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAK3tserri1JPtmYA8oPMuIawHM9gJKsuwk27Gz19lH7sDRUaYjdDXHb1v4903COC01HEW+uB4RUemf0Q0P9sDh+Q9As/4oLZaJpK35YtWsAGKFrLAn4
 wjdqf4QiATgP4KXgJOyFVNWUbKXTyoQF3lecFcarbuhGnSTrWxP7oPwfeZjkLtvTEGYTqDSjK2aZs9m3NXyaeH+ojvELLbL+B6Svgs61t/m7aa20eNv0wLzm
 LnN9oY3/ekj0GLukkTfgoap3qmz6VOmcmIEwwveLThH02boUBiI+SJrcKrtuWuwM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/2018 08:50, Christian Halstrick wrote:
> Ok, I know understand the problems which are solved by this
> special behaviour of a "initial checkout". And also important I understand
> when exactly I should do a "initial checkout" - when the index file does
> not exist. I'll share my new knowledge with JGit :-)
> 
Given that the initial query was about the lack of documentation for the 
term "initial checkout", do you have any suggestion of how it might best 
be incorporated into the documentation to assist future reader?
-- 
Philip
