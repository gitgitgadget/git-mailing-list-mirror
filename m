Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A8F2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 13:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932620AbcLMNXx (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 08:23:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33907 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932446AbcLMNXw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 08:23:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so18414577wme.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ZaBle3X1E68msFFLI2yH5RNNBLxo5k8mamPH+V8nCN4=;
        b=k0uxi+v+vnVOB0zuB407FC19/PDFAZsOxMrsQqZhSMMKVBEz1bpjyTkulOK27qOwjE
         Io00VXDfhcxl9Ed0h8McxgHoTmYvFNk3yF4UZ/Lz77rZdlep92CvVJx/2JJoOv+eN3lM
         VDwAL5c2E4OU8QY3AMEKTfjAuzw+fjvYp62ewGm3qq6jkHXqHuV9HZtaR7Rwq66EQ0Q2
         ce8hPC+rxrzK+CBFIKYrZ9mw0NMeV3Z9qpBYJ1/unt0X8tIF+XgG/5eyUcxzhKwkFoc2
         kp3jo/mPE22c7nsenC0ClIpVNHcn31rQ53Ja/tgq1qD/DvT0+Kx+bBb7+c9uQKVaDZ3f
         t4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ZaBle3X1E68msFFLI2yH5RNNBLxo5k8mamPH+V8nCN4=;
        b=ckNkWm4Jb2qaUlztR35ctg63k0kiKe9LOL9kB1VDQUvu8ZEia+QH1BpPU6adQ62nQN
         rPI5V5rMjNjhoPfHzwgak4UAreHc6T51u22dZoKWdNDrZPXsHORaSY+A4uGZRztQq4u6
         OxN5L2YHbODVsSNPczRgT0q8mmEvDHlwqXr//LvEsh/T554Wo9385ih5dgIwjCuECxLc
         Yi/qnqDDbHJvSeVJ9F72juTpbEGm2QNUTS+g/tcoaSkPA41qjJClmYKwc1kfNc2OCPUj
         y0l3ejYOfScjKsHmq92HM4BxlcNFcebDjwQog3b4iug7dhlj8NpYRAAadk9gDiw4HeTe
         vBfQ==
X-Gm-Message-State: AKaTC00C9jJlsfE564XR++fVmgGFWmgrQuZaxqXJTfS/XXVcmS+8LqHsrzpnMpXzVT1vZw==
X-Received: by 10.25.64.16 with SMTP id n16mr1093195lfa.119.1481635430811;
        Tue, 13 Dec 2016 05:23:50 -0800 (PST)
Received: from kristoffer-SZ68R2 (uib-guest.uib.no. [129.177.138.114])
        by smtp.gmail.com with ESMTPSA id n124sm9937200lfb.33.2016.12.13.05.23.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 05:23:50 -0800 (PST)
References: <20161209155112.2112-1-kristoffer.haugsbakk@gmail.com> <20161209155112.2112-4-kristoffer.haugsbakk@gmail.com> <34DFA15DE05248069167FE613B66CD70@PhilipOakley>
User-agent: mu4e 0.9.17; emacs 24.5.1
From:   Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     git@vger.kernel.org,
        Kristoffer Haugsbakk <kristoffer.haugsbakk@gmail.com>
Subject: Re: [PATCH 3/4] doc: make the intent of sentence clearer
In-reply-to: <34DFA15DE05248069167FE613B66CD70@PhilipOakley>
Date:   Tue, 13 Dec 2016 14:23:49 +0100
Message-ID: <871sxcj72y.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Philip Oakley writes:

> Looks like a reasonable emphasis to me

I'll add this header:

    Acked-by: Philip Oakley <philipoakley@iee.org>

To the commit message of this patch in the next review round (version 2
of the patch series).

Let me know if I should add another header, or do something different
than this.

-- 
Kristoffer Haugsbakk
