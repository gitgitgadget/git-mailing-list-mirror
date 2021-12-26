Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15DFC433F5
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 00:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhLZAsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Dec 2021 19:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhLZAsu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Dec 2021 19:48:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94799C061401
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 16:48:50 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso14807994pjc.4
        for <git@vger.kernel.org>; Sat, 25 Dec 2021 16:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8Wzda9URQmwp8j1eYULIKRG3q6bv1lwgjuUtBTcIVyI=;
        b=pAJr/D38UVY2v6wDNsWfTKTbO1wSPckHr0QHylp/UN/hEZSSp6zHwz158I4SJ3gLl0
         VUPf5JV9r/zohJN4lgPALOPb5J7iH7osQJ7ujuyKkn6u6ZRop8MQWM7hFy1Jm5hu2F96
         7zUh9Fh17Ynybu3vR3ARk6nNFNuHTKMh+P/v9Wv/plHEVFdVXunh32PxHluiwDzVGQN5
         owe5rT/6ixBlvrwiDb2rjZJzzsZ5pS9HXMo4EoUmc9AdVw8tJSzZhbymR0vjWyQigK2v
         VTGzlLy38t8hKm1t/IV7DrQleCwt5Cl38JpKfx7XVE2CL1tCJrnbnSbKTZ3OzD7Q6GZj
         3NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Wzda9URQmwp8j1eYULIKRG3q6bv1lwgjuUtBTcIVyI=;
        b=PrkBRNyrf7ONpIoNrRRmelhCkOKk9bJuqjzzC2zZQYtQbuweXwXRBWui7sic+o0aO6
         JpnXDvwbPhnzU6juH5eheDFsVNL2anMWoecI8zy9Ns/+UWLXiHQLn+5r0FMAqTA+6kwy
         n6oFjGUfnzwWFaIA2SwXRqvZ/Hap96rBbiL15VMY+QMscsK/3YFaHOVqjGtnr/4+u+2H
         DHZ9YcEfQbSA40CCouyy32qT3Za86zYVczZz+F6lwQUdpnXjbAMyQwcJ7M1TEIH2uWOg
         DB3bQ/9Ipxf/r5rXdT0X+BFrtMGm9J1WcGzkoO9i5/J/StAmDiXdBsOHMzWjr0CGxxv9
         STyA==
X-Gm-Message-State: AOAM531LsF1OzJ0ot4kuz2paoUUnZHpv+t4n5pnJgQVqlLUOFXV8SZbB
        6Z4afF2Ot4IifiZsaOgEtanvLmmnHU+gFFPU
X-Google-Smtp-Source: ABdhPJw4cTSIw/DDkH1qxwX/7q8/U4ZIrAXKUs2h9sF0sbVx7sc2pc4d8PX+35KXhOF0QZjF/WePVA==
X-Received: by 2002:a17:90a:a00e:: with SMTP id q14mr14372670pjp.88.1640479730002;
        Sat, 25 Dec 2021 16:48:50 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id u15sm13586436pfk.186.2021.12.25.16.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Dec 2021 16:48:49 -0800 (PST)
Subject: Re: My git repo is broken, how to fix it ?
To:     Joseph Mitchell <josephmitchell36@icloud.com>,
        torvalds@linux-foundation.org
Cc:     git@vger.kernel.org, litvinov2004@gmail.com
References: <19E9B3EE-705B-4275-8615-4C09ECA45BC7@icloud.com>
From:   Lemuria <nekadek457@gmail.com>
Message-ID: <b1dd7f8c-c7c0-5d80-4c85-6d7e957d9c9c@gmail.com>
Date:   Sun, 26 Dec 2021 08:48:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <19E9B3EE-705B-4275-8615-4C09ECA45BC7@icloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have no idea what you sent. It's just the default iOS Mail signature.

How exactly is your git repo "broken"?


On 25/12/2021 4:30 pm, Joseph Mitchell wrote:
> 
> 
> Sent from my iPhone
> 
