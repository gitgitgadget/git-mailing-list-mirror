Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BC5B2018F
	for <e@80x24.org>; Tue, 19 Jul 2016 16:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbcGSQM7 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 12:12:59 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34347 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036AbcGSQM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 12:12:56 -0400
Received: by mail-io0-f180.google.com with SMTP id q83so23427666iod.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 09:12:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mBUaaxXGJKp1XObmhkWrfU81lTtgDUXt05ygx8+AzP0=;
        b=bPczHQNjmqDb1rXZfGF4bIJm730A3RpVvSg3Zgw0hCVQZ9KQ+2nRjqSW98sGvxJq/1
         QSGvH2kc+2yKrjabBCqNhxb0eWZg0I/NEDcfEA0/a/5NDveE88JAuTR7385ZWIsg8YS2
         QDiSKUSCnAxGkU+rA6zeZ1Ggi7JLqoxr+B2LTs4PLOnBQCcsBlB8lb3TtvlixgVIvX9R
         N9RrcaeHi0V3lsQLZIAIYUtJEx7Nf1WTJvpXTmZgMFdjImR+YjYBFt2Oszdz6JrW3em0
         iOuT2p+k7wQLAJqQO7V+ZnKvephPS1o+Lf3ZN6pY4EjU0xspHWx4oo/1RrhdyyVRH2vx
         3dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mBUaaxXGJKp1XObmhkWrfU81lTtgDUXt05ygx8+AzP0=;
        b=PnItOS6ljBD6TuqXMqVY3ftVxw34aH9GiqwQ5hb05nhwN8TYy2alnEDKk0zxAznbuh
         2zrghkdKZa40mtcdpqaPl29atqzZ37+xL5GwVySTa2CaiEZhyzDWIJ7sDc0sjqsVIdjG
         2fb4znbasPt6I/DC/Z96m1CtNY/eyadVnYkdLeO8QGe0KLAqEvpJGGW4FXGmZLvHwwXs
         TWYLRxtDPwTirZVsbT0fpdVSK11169dW3+JO64KBmsd/LW/+OIaZgj12ZVhP8xWiWePh
         8QN4tgzn4V47nuRh655L4/f1VuyQkIyBOOVhRoBSoiqYT/7U/EoWDrhR44PR6kQcNseT
         RJnA==
X-Gm-Message-State: ALyK8tKL1mbh08/WnWP+woYjtTF7VaIg4R6ABtGSQnbg/cc8bOVNhS0voHCi7I4SJk0bXo/rqFuRqhh+R1YGZQ==
X-Received: by 10.107.2.78 with SMTP id 75mr3058053ioc.128.1468944775787; Tue,
 19 Jul 2016 09:12:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 19 Jul 2016 09:12:26 -0700 (PDT)
In-Reply-To: <20160718225424.GA813@plume>
References: <20160718223038.GA66056@plume> <20160718225424.GA813@plume>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 19 Jul 2016 18:12:26 +0200
Message-ID: <CACsJy8CRHsyT8YLPYoHZnxCuMvF1W=S5iayy2eoHZhbSe_qmDg@mail.gmail.com>
Subject: Re: t7063 failure on FreeBSD 10.3 i386/amd64
To:	Eric Wong <e@80x24.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	David Turner <novalis@novalis.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 12:54 AM, Eric Wong <e@80x24.org> wrote:
> Oops, forgot to Cc some folks who worked on this :x
>
> Filesystem is ufs and it fails regardless of whether
> soft-updates is enabled or not.

Nothing stands out to my eyes, so I'm going to install freebsd this
weekend. I hope ufs does not have any nasty surprise for me. Stay
tuned.
-- 
Duy
