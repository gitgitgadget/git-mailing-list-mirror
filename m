Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569D61F453
	for <e@80x24.org>; Fri, 21 Sep 2018 02:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388823AbeIUIRz (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 04:17:55 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:46211 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeIUIRz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 04:17:55 -0400
Received: by mail-qk1-f174.google.com with SMTP id l194-v6so3384620qke.13
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 19:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvlFBrRdkO/3cRUZC9jzv65BATEWtxxg3Mf4HVIbD60=;
        b=Aa3W3E3X5ghkRjJncdKVWt/UO/+oLTdx0qEMwzxSQAnU+lT+9F7hLvbMBBM6s816Bi
         cPNmSJrVw7RC+wc66LgpyPMvceG33FmntaRU7I70udg3sfJs/RFR/w+UI4x3pb2dmuQE
         NRXZSVWoLaHBhthkl+IWSh4ohk5lgugVa3BLukwr/RTEdanS87gpqp/aW5DNZxlGGnJI
         /JZ1IWnNnxWXLxZqRof/kRLnVcR9w3CWUQXAVyCHfnip+d8ABP9MWVAFjZl0nN1nxfyd
         f+kR4LXNJ+nmC9aMPkRualtO2F24kwhrhyWhx4UyGwVzqDScSRyqMCajowkM/PB9Dbv7
         MJFw==
X-Gm-Message-State: APzg51D6FS4CrgFbDWkIa9k0pdOZYucDZMQTJg4b9qATedGQ9BCCEU0X
        1+G0SBkKkZ/8427l+Z0XdW28euGqI5zyBfPVrAc=
X-Google-Smtp-Source: ANB0VdblRgMfFX/ihNc6xn6JhxwZbQlsi+8WkxPuPrbWXCUtxsJPbQx2fszFum51GUB6RZdbezawfk2hNUFk7YzRJCc=
X-Received: by 2002:a37:455:: with SMTP id 82-v6mr8093474qke.26.1537497077956;
 Thu, 20 Sep 2018 19:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KyZp4G6WCXjp_9x+NBWZysfg+Fu_PtF4qrhipT8UuLNnsCHA@mail.gmail.com>
In-Reply-To: <CA+KyZp4G6WCXjp_9x+NBWZysfg+Fu_PtF4qrhipT8UuLNnsCHA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 20 Sep 2018 22:31:06 -0400
Message-ID: <CAPig+cS+8+uGQTfxmq1XGMt5FBM1oq72d3N=3BkjhrA9ui+EWw@mail.gmail.com>
Subject: Re: bug with git merge-base
To:     alexander.d.mills@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 19, 2018 at 6:25 PM Alexander Mills
<alexander.d.mills@gmail.com> wrote:
> The following command sequence exits with 1, and no stderr
>
> base='remotes/origin/dev';
> fork_point="$(git merge-base --fork-point "$base")";
>
> I cannot figure out why it's exiting with 1, but there is no stdout/stderr

Unable to reproduce the problem. Perhaps you can provide more context.
