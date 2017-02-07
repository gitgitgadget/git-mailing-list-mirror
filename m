Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8631FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 14:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754436AbdBGORh (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 09:17:37 -0500
Received: from mail-wj0-f178.google.com ([209.85.210.178]:36611 "EHLO
        mail-wj0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754282AbdBGORf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 09:17:35 -0500
Received: by mail-wj0-f178.google.com with SMTP id n2so4449186wjq.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 06:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wkY1U0X/IGjd6YseQcoY+NGmEVZfYAFaBQuEk7hcjEI=;
        b=j9LpSnJhzbXxoWqVRxxb/Je7/4VDTy17/DqJdnKLWsFR5iWKYuYqbS2lUrAmEQLxyZ
         86N4zdLQCbuICed4RvnNA8Xe3mKl61C8fG8s/PJ93UtEv6HkSbMrK0ev3ZKSCsULqL0L
         FxNDXY6JSQoC+uB601ANnIzHSWj1lQeD1Lz8T/30UQv4korM+0URj/AGYFMvZBjqVW87
         /5swlAEBlEdrjJSHDyD/Z17ZVkPJstbRIikqAoy5Dc/BGNTxx+4AgkzdCfXUZm76C3oE
         ZvMQAn3YgWLP4aAyD5/ibMZ0NrfiFdAnhyAl2eB9+hxZt+QddY4YtFcYTtYjwXIkEmHf
         Wz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wkY1U0X/IGjd6YseQcoY+NGmEVZfYAFaBQuEk7hcjEI=;
        b=ZzII3pNqUWoeCLsu9D5V8kOo++NJT3FM5/5paCCQZ1SQgGdolwS2ahkxLi9Ye+Wg2n
         8LKwPZuiJvHVquLQmUHVLWTbOcOTpOF3ekbhYs+p70xVK42LqJ27qNtJAxgxF+QD7Rtg
         xTa7dRJeH6kD9tjj1kgI5JeqcOY4+e1Zs4FCm8eSOYvb+nCo93rAn/8FNJkcbvKP2bzU
         aDDSfFLHzq/iSYEBvIY4WUUgN6w5qWD+20MSqHwfE92FixoLujWxnRYMRxTC2NoAURS9
         QiCDvK5sFl678hHNhG30QkFlTWsJ9VNb60NwVG6NNYRZhYnEUKoru9+6oNyUarMlTyHZ
         yJQQ==
X-Gm-Message-State: AIkVDXK7RS4jDjX3FnxnloGMjQmqxvkqPR6jAamMdV45jtLMLGaUdUGoUz506CzpzOiBnGbKrUI2C8vmzZq9xw==
X-Received: by 10.223.141.229 with SMTP id o92mr16287011wrb.22.1486477054451;
 Tue, 07 Feb 2017 06:17:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.208.134 with HTTP; Tue, 7 Feb 2017 06:17:34 -0800 (PST)
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 7 Feb 2017 22:17:34 +0800
Message-ID: <CAGP6PO+qD6eRkKbWAxOfiqUQw8o+dOfgwgvt_8OxHQ5ocAopEQ@mail.gmail.com>
Subject: ``git clean -xdf'' and ``make clean''
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

In order to delete all of the last build stuff, does the following two
methods equivalent or not?

``git clean -xdf'' and ``make clean''

Regards
-- 
Hongsheng Zhao <hongyi.zhao@gmail.com>
Institute of Semiconductors, Chinese Academy of Sciences
GnuPG DSA: 0xD108493
