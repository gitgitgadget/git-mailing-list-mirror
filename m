Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD031F404
	for <e@80x24.org>; Wed, 15 Aug 2018 20:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbeHOXfl (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 19:35:41 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:39529 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeHOXfk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 19:35:40 -0400
Received: by mail-it0-f46.google.com with SMTP id g141-v6so3746051ita.4
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUQCdC8zbobDH9N9hoMg7oZlajneyMsKmgiZOWSJyL8=;
        b=KEhzOUUpfroHdNqKhDOqxC953d+wrnCr/fp1epBokVTc6dW2UQN9KQFK0zhlY17gWR
         NzK5oc+HsWvdF5/0loNax6N2RIAQozcHhmSTuz8C1UU2XXsJ2S2lF00116cxy2r+YCvG
         HqqrBvn23ks/0vjCjRM8Pg7gnws1Y7yhvbSnlERhLEpRUeE+4U5eEAwV1raQ6cXiTD22
         QMPwqsb3z41OhWaX9EgVDVypDKA8j4vWsL4I+z/h3oFHnv7nOWLKzr7lKPe8ulcRgbGK
         SsFWDdivJ6PqZ3Ka+VOBwkI4kVRG4lKjBR1YLrfbu1JLpBsi2PmYd4t+Sk+/ZucTs1P2
         uFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUQCdC8zbobDH9N9hoMg7oZlajneyMsKmgiZOWSJyL8=;
        b=HNWtP4ZlomDxKBr3mSN1kQSYt/p+/Xwk8OHDtm99fEjRffZaEv7pt8qsWQLMq/wiQ6
         kRMiKsKPAEBecA5pVEB5akc5rPIe5PVcqM3+5xpcLduSQWcHCossP9Pp/VONuRvd27Wb
         KAP/DicFbAmDwZxF1An1E2rsOkOV6KtowziONGmaUwBxqeKf8L6NYa07NnXjiHO0JIkG
         /EEANoNTahDesibnB2tEgLzjMgP3UG3v2qzZjwD+UFL7Gt+opicphGkGtg7mMncjQjX+
         BUPjmJKhERpDA45XMM6sVOzXqWyspRhV7CAchRtMKK8W8HCTYDNKJq/a+6lh0Lw5pzzv
         /H2Q==
X-Gm-Message-State: AOUpUlHPHqn1JuIs0prbTnQ/mDdN+khougj6bZC5OPqAZrVwds5OQ8V1
        4kmVddL7hP2XDN6VRrt2Cn7k1CQt
X-Google-Smtp-Source: AA+uWPzWXpNVEcIoDRzb0xF5Oimxfnll4dRJnAYD6mFdMAOYxNBRZWj4nzs8m7DJ0lYkch7SbnE8qA==
X-Received: by 2002:a24:3d81:: with SMTP id n123-v6mr20062704itn.40.1534365715212;
        Wed, 15 Aug 2018 13:41:55 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a11-v6sm1326128ita.21.2018.08.15.13.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 13:41:54 -0700 (PDT)
Date:   Wed, 15 Aug 2018 13:41:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 0/6] Add missing includes and forward declares
Message-ID: <20180815204152.GD181377@aiede.svl.corp.google.com>
References: <https://public-inbox.org/git/20180813171749.10481-1-newren@gmail.com/>
 <20180815175410.5726-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815175410.5726-1-newren@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

>  62 files changed, 152 insertions(+), 18 deletions(-)

All 6 patches in this series are
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your patient work.

Pointer to previous rounds for the curious:
https://public-inbox.org/git/20180811043218.31456-1-newren@gmail.com/
