Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08F0920282
	for <e@80x24.org>; Mon, 22 May 2017 19:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759166AbdEVTas (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:30:48 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34108 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbdEVTar (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:30:47 -0400
Received: by mail-io0-f170.google.com with SMTP id k91so87957540ioi.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASxspxAYqJ/aLS+kYmSMmC1bMKBwdGmqqYbUdpx5BBo=;
        b=RrCmClnqEycHmbHxyyjl51N8LR2jL/9dYepecrYdAtRWGm0cZozv8TTnpx3jtfiSFO
         MvNs/OOdEU5WCXI0QICGuo3sPF1YW7nSqktSlRTwr1fWuqZzykRpPkgdwe/MejnHqYFQ
         UBJ30UMQaC5067wDlliiJW7T+RjlUG0+uCEfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASxspxAYqJ/aLS+kYmSMmC1bMKBwdGmqqYbUdpx5BBo=;
        b=bN9LDcvrHnrRmuyte7CVbQTNe60WZOLWPqCRgq5VNjuaiXciJ4BGo//Q0FSB109sWX
         w7MmtWwrb9/sHkByVWYLWoURUW5gOMfU0O/NQJ7o0b0cDAw7UH0aFI4xvIQTMBslrf/+
         f+Lg4cenyuJX7qih0bisUcQVyW2rh2L4kgqpyauyGAAUSbTd5GBmWQDFqxGc3nQHYNEs
         ioAbycTaQm01pptulAtpi+ozwOmZhq/mXQs82j7pjarJlxiWb694LvYNKaRXHCt3GBx3
         NfkQJwX/Ob3I6Soj9Uz/RikspTiSsjKhL4AOjpOLWfFpT6a0Ic6E8TLUVTY5/DaFBY0S
         4v6Q==
X-Gm-Message-State: AODbwcCff5h2dxyIdVMtKfud+lNNfpIYT2kmMFJhnWAnamNxJUXgeJXs
        TxmpnVk9KTiZk9BC
X-Received: by 10.107.142.201 with SMTP id q192mr21522872iod.99.1495481446903;
        Mon, 22 May 2017 12:30:46 -0700 (PDT)
Received: from localhost ([206.168.224.82])
        by smtp.gmail.com with ESMTPSA id b1sm14292937itb.30.2017.05.22.12.30.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 May 2017 12:30:46 -0700 (PDT)
Date:   Mon, 22 May 2017 13:30:43 -0600
From:   Taylor Blau <ttaylorr@github.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tboegi@web.de, e@80x24.org
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170522192749.GA31160@syl.local>
References: <20170522135001.54506-1-larsxschneider@gmail.com>
 <20170522135001.54506-5-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170522135001.54506-5-larsxschneider@gmail.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have no remaining concerns about the protocol specification in terms of
implementing a filter with this capability.
