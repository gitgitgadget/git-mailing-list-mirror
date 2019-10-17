Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39A2F1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 08:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405242AbfJQI5N (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 04:57:13 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:41654 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389541AbfJQI5M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 04:57:12 -0400
Received: by mail-il1-f172.google.com with SMTP id z10so1262389ilo.8
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sterex-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5OurNsz5eAs0Q2hDNg/UD4w5thQcbk1Tuzh+totPD4o=;
        b=OMjxAIMkr/+/ddQVJWK5y/BpgctI4kRHtOJmtzubjIReFRlFy9sluqYmXy+b8p6V7T
         6KrNWbhUFFFR1uZSH9UKEWXhYPwspB6aVmbUt6ZE0WvbPg6YdHCqd1UjzqDIYftln1LE
         f2ZySP89X4xx/pwaozHtYvWjE4unS0nCw2/WhEb2nqZiek8F0G0A+UXApZUSYNT9/oIP
         W/aQym+VaY6DXMsTiv+RkHSvvne6Wji3mg0NEpre5lU9daH5tm/eLTF12PAFP1bClf0t
         JIYrUd16CaEHAHyJ0+1MxeiSvWIj/Vyo7QWpPYQMa99zPcJuEqzrDM1oSiiR26YLoTYm
         CrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5OurNsz5eAs0Q2hDNg/UD4w5thQcbk1Tuzh+totPD4o=;
        b=GbLNpwOn3YXdgvLPA8FF2qupl5JmQJzzV0fqWLJ0P8wysKjscIZmyG3WjOqeENYx2s
         mYEsyzI6c63mUn3qoDbQM2lB48RrwQfT91PLFerIYRls/K4kwun//Y/WsN0JgtI61RJ+
         Nm8tqA2M9e5NqDDvUUQx3dQ5GhY/GRXF4KQM/7TwyLL5TIx2HGjL2s2Rvr+xwvxN4+Fc
         /1CNVnQxzPOkf52+mBDrl2zloSRDgB71IZ6WT3YMecpcvQP/K/aY/eLni86XLKP+EJTg
         2QDbW0/KPAigBuDhQ1BURLwKUN8XDH6QISQ4xNYg7Gj2F5l7GcVdja31Y9Imwut6ofw/
         FkPA==
X-Gm-Message-State: APjAAAWIVqoIbA0H2t0LuiUlKzMfVJI/4cGGwej9EeSre4CT/71hW46k
        xhWG+vTRo+npLuVCokTVkfrDS1KMovn5ne/aRCrxVxxunQ==
X-Google-Smtp-Source: APXvYqwM9iqrRM3ODr6suRolN0TP7WbrSIHRKoFiGM7HeqiLzsQz75a67/IOLaU7NCPd3yEWt/oMSrf1CRkjSJzJp4o=
X-Received: by 2002:a92:3c04:: with SMTP id j4mr2443295ila.120.1571302630265;
 Thu, 17 Oct 2019 01:57:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: *@sterex.in
From:   Manoj Sterex <*@sterex.in>
Date:   Thu, 17 Oct 2019 10:56:34 +0200
Message-ID: <CAJoS+LqqeD3zLYi=jnxc9A=bLT_bpTrjP1bZMPX4NMehd2V3cQ@mail.gmail.com>
Subject: Commits with --no-verify option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Currently, AFAIK, there is no way to know if a commit was done with or
without using the '--no-verify' option. That is, git does not track if
hooks were skipped when the commit happened.

Is there some way to track this in the log?

Regards,
Manoj
