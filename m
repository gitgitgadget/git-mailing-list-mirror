Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FE51F462
	for <e@80x24.org>; Wed, 12 Jun 2019 18:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfFLSOd (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 14:14:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37051 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFLSOc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 14:14:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so6967283plb.4
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ikxj7ie37c1RAy87t9UfcmGokycJvWZOx1tXjBh4cek=;
        b=i4FZYUwZt3CpVd9W8t5rZzZS+s149eBJ+SGiBB4QQcfYDSk5Oojh/q2pGPzDGRCdMN
         JlsE8S+Gem9pa8WN0R4dYVI5TlLPYrOGsRokZIv1eyg786S65bspHmQdf/enSTJtiyyu
         KkKiiFcFqm/A3EXwgn2WezFw6b2pGYSw9woCV/4BeXynuyRIi2Jr6rY/MxHcJFoXzVhT
         6F8O/KsapyyXJvGdsXsfg99W6uGfK4uP/jhmuGUyv9p/DDjcFm/Vogn4LdKQTVx58500
         rBdsLlbglf9IikrlBA56glacR2hHfuyEjGpYXZu8sa8NdQRl7LcwHm4o9RStjtyHWVSN
         peuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ikxj7ie37c1RAy87t9UfcmGokycJvWZOx1tXjBh4cek=;
        b=X+gBIYUUbX3SAqBIS4bjSKUjrJsJtKxBMUBaHKE5gP/dHYQ+XVez8vvO1r+36dzQ+J
         lYg0OhNG/aNxIJHeD0hCnHjmJ8Siq6cI9dpdFpXSirv4GTd9DJkd9q3Goi1+4JNHQBvt
         jvdyp8e8E0yMAbFHwMtHBpLJyOIUUTu85qyPe0TG8GjAmiEwchNmr7+S8P8UMg+OZbcK
         R37lND/nVYbfBQ30iDZ9aKgzCNVQ0H2xRx8zKGYmw2AKGmMFHoEbwyY28mDLny7V/Mxe
         dnYtUHmnfdcDIv0z0z0cPoJF5hdrYXb7LQHqcEGC2oqApvKE7GBkKbm/wHJk1yflkkYR
         P2jw==
X-Gm-Message-State: APjAAAWIQd5BWOojYwMnKzuA3BjuZO5wuS8jO8Iq6rOW7ePh5obXzWNE
        uXlm34Qkau5Db2BN5kzszJil89WwGTB+aA==
X-Google-Smtp-Source: APXvYqw/QjcvnpwhiC31LWJvfCNeKsNNDXUAPZCgqTxC/fwsYjj+0vPA6kfJKZTlUvbnibDYMZbAGA==
X-Received: by 2002:a17:902:16f:: with SMTP id 102mr39564472plb.94.1560363271785;
        Wed, 12 Jun 2019 11:14:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id a64sm164492pgc.53.2019.06.12.11.14.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 11:14:31 -0700 (PDT)
Date:   Wed, 12 Jun 2019 11:14:26 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [RFC PATCH 1/3] trace2: correct trace2 field name documentation
Message-ID: <20190612181426.GB42943@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git@jeffhostetler.com
References: <cover.1560295286.git.steadmon@google.com>
 <8bcd72a762f0fd349f8bf7d0b134cc7033ae6f00.1560295286.git.steadmon@google.com>
 <xmqqwohqiszh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwohqiszh.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.06.12 11:00, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Correct the api-trace2 documentation, which lists "signal" as an
> > expected field for the signal event type, but which actually outputs
> > "signo" as the field name.
> 
> 
> Nice.  Is this one of the findings made by your validation, by the way?

Yes. I based both versions of the schema purely off the documentation, then
tested against real output. This was the only discrepancy that was uncovered.
