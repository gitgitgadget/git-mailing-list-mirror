Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCE11FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 22:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbdALWZl (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 17:25:41 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:35941 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdALWZj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 17:25:39 -0500
Received: by mail-io0-f170.google.com with SMTP id j13so30156263iod.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 14:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ADW4wp20PKhzaKO8zRwyis3bwMhsi8SwvmTgc2KcYcQ=;
        b=tbYwKf1lQSoagejDVHA2St3X9/ZUErBjPgkDpLxTtJdqao+nOpsJF1IYZiXcapWBQq
         ZExH2H5mailf0WsTe+3bgl2HfCypAqGtmwGxIVw31wo71QgXfLg0CJ68rQ3JBfLk+EwR
         3oC2nNr8iMnKBMHWr9LkXmIROQaKGdPWwlUGxw0v8cY20WYV75oDZx6ghHMp3qvY5pBQ
         ECDPoPy1TUJRCbFcS1LSL9rHEz8WqW8PnjFa4j7uShBPsOnrtmJGa0mHsWczwwkZ/9Wc
         LUJj2lZA02h2pmBDnSm2MJXsDPZxJvDUaLBm5CcNwC12O84dvRW3AqxSUU3oM1B+6qmi
         PqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ADW4wp20PKhzaKO8zRwyis3bwMhsi8SwvmTgc2KcYcQ=;
        b=tJOUP+jT5HUqZxd6451mCJ8Xnp8GsZUQGyMyAEyuuYqCwx1xnB2KY8ribKPxeRQ129
         JsBgA9AXKMZgdFeefYdY926ZRdDHomn6AQfp5gLnf0zOpYYomfV4QhpMbFQ/uCIRPXQ0
         YIQyumkWytLfjmAlHgNrCOaKh6Gt8Anr2qUizFsTeXODprrDPtORR+/VouMjX2lXGgrj
         GDneutAoYSgOeNtOtlSna0q2EhpuWQt7NGZxJWOCSMB8CsGJlomkY/68MunCaqJHCL1W
         1LvZD+gubGalhm58ze+1q9t17ke+Ze1EoTnar96gqgSejukInYrpFbprsMKACvoaOrTn
         cN/g==
X-Gm-Message-State: AIkVDXLY3uSuhDnnjVn4tXmvMSHaKmE2pOoky+7KcWvQubZJsuMnDAV9bhMBnV2Vp92f90m8qZgzXIvU/hDIHYd9
X-Received: by 10.107.16.14 with SMTP id y14mr14646295ioi.164.1484259938498;
 Thu, 12 Jan 2017 14:25:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 12 Jan 2017 14:25:38 -0800 (PST)
In-Reply-To: <20170112213240.7972-2-philipoakley@iee.org>
References: <20170112213240.7972-1-philipoakley@iee.org> <20170112213240.7972-2-philipoakley@iee.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 12 Jan 2017 14:25:38 -0800
Message-ID: <CAGZ79kZThvdbGgk0qDv38RWDrWEF7-7hSZhX2h5tGhW0+-Nt4Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] doc: gitk: remove gitview reference
To:     Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 12, 2017 at 1:32 PM, Philip Oakley <philipoakley@iee.org> wrote:
> contrib/gitview has been removed. Remove the reference.

Thanks for this cleanup.
