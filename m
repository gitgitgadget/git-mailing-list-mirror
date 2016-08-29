Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A8C1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 14:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755857AbcH2Onq (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 10:43:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33662 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755800AbcH2Onp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 10:43:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id o80so9888862wme.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=d0Vn2XjGin0DAivCNchrS32K9ZURyr0kO92oSFVJU3g=;
        b=oDIkzAM1XSmCqwh1Bfhfs/lWRkg1/ZzPPejQKbM6KMxIuhPoVar6AMsowUsMe++/C0
         5gUhaFVxvW7jL35DT+8Fwe0QDhNJ/4qhEC1LESoSI6OwNsXQ2zDj4X1JU2I2Un1IkInG
         ryVdY3dIqIjeJcYoU00OaJmnrwKyENsEqpfP6blVRn3AXJbDLgwSZrkRFPwpG1gH/RTt
         CUXxdxvo4BE5UETst9nWhAodM2QPJ7Lkra/ftrJEdm4/+e1GCxFGvixWkwa/w/JXYfpP
         /idJPZCPX6DkUfA3UZ5hjTcR1cCyXODOJypkn/pXIqY4DA5uG35/6/MYQBIUxi9N6j4S
         +idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=d0Vn2XjGin0DAivCNchrS32K9ZURyr0kO92oSFVJU3g=;
        b=VHUFLOm5C1SXmixkvsXwrf17eZ1uv/ruDSx++4hZnv02DinkNCB5zQA8mjyMhbG71d
         SR+UOBC9nGUDpYodSU/F1SpNPdV75V0KykNJm/a8GE0CLNztRFuDHFVAFuEsmF6zYnUc
         YsciblmYCBuZU2Cu4ClDlqbXU0a6M/5HB/L+fsBa7H67Dwl7gx5RH92cKmthGiFa3Z1m
         4RkIlqjJOzjXX/w1WEnt+pGMsL3fwAHShS4EmnE9d4wHarAMFYycSPWcreTsSZHYvaP9
         /s/q7oc15+qFHc41CC0i2fixSCMOKA0tIZOJdEkpk7D1v9zrAWlWK/VfHRKGjKb+lbwu
         aX6g==
X-Gm-Message-State: AE9vXwMveBzxyrJgq0FNFeD8eCggFijKGlYHWMOeiknmAy8Vz5pgkjfz9AeJZXzIJrUZ0A==
X-Received: by 10.28.132.16 with SMTP id g16mr10481076wmd.97.1472481823664;
        Mon, 29 Aug 2016 07:43:43 -0700 (PDT)
Received: from [192.168.1.26] (exa25.neoplus.adsl.tpnet.pl. [83.20.250.25])
        by smtp.googlemail.com with ESMTPSA id q4sm34762848wjk.24.2016.08.29.07.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2016 07:43:42 -0700 (PDT)
Subject: Re: [PATCH v5 09/12] doc: revisions - define `reachable`
To:     Philip Oakley <philipoakley@iee.org>,
        GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20160720211007.5520-1-philipoakley@iee.org>
 <20160812070749.2920-1-philipoakley@iee.org>
 <20160812070749.2920-10-philipoakley@iee.org>
 <494c1bd2-19c8-e2af-da1c-ff1331f91c4f@gmail.com>
 <EDA7BA88AB1D42C7B4228D71CC28145B@PhilipOakley>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <557eb782-ee45-3e33-33bb-aa88817dcd82@gmail.com>
Date:   Mon, 29 Aug 2016 16:43:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <EDA7BA88AB1D42C7B4228D71CC28145B@PhilipOakley>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 29.08.2016 o 15:21, Philip Oakley pisze:
> From: "Jakub Narębski" <jnareb@gmail.com>
> Sent: Sunday, August 28, 2016 2:01 PM
>> W dniu 12.08.2016 o 09:07, Philip Oakley pisze:
[...]

>>> +For these commands,
>>> +specifying a single revision, using the notation described in the
>>> +previous section, means the set of commits `reachable` from the given
>>> +commit.
[...]
>>> +
>>> +A commit's reachable set is the commit itself and the commits in
>>> +its ancestry chain.
>>> +
>>
>> It is all right, but perhaps it would be better to just repeat:
>>
>>  +Set of commits reachable from given commit is the commit itself
>>  +and all the commits in its ancestry chain.
> 
> It's very easy to go around in circles here. The original issue was
> the A..B notation for the case where A is a direct descendant of B,
> such that new users, or users more familiar with range notations from
> elsewhere, would expect that the A..B range is *inclusive*, rather
> than an open / closed interval. It was the addressing of that problem
> that lead to the updating of the 'reachability' definition.

All right, I can see that.  It is a worthwhile goal.

> The main part of my sentence formation was to make the 'reachable'
> part the defining element, rather than being a feature of the set.
> Maybe it's using the 'set' viewpoint that is distracting?>>

One one hand, the "A commit's reachable set is ..." approach puts
'reachable' upfront.  On the other hand it introduces new terminology,
namely 'reachable set' (or 'reachable set of a commit' to be more
exact)...  it doesn't read that well to me, but I am not a native
speaker.

But as I wrote, this is quite all right anyway
-- 
Jakub Narębski

