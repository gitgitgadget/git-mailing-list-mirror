Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8555F1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 22:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756358AbcINWPF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 18:15:05 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34068 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756435AbcINWPE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 18:15:04 -0400
Received: by mail-wm0-f43.google.com with SMTP id l68so157812wml.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0QAOCV+DI2/1v7xM1t5XUU40sLfiiU3L3MoNj0PlkIM=;
        b=pq4B5LvzesGyDZqB34DEJUSx4jcrAc91GcZvP4oWCuKh9mxnAPM9f3XIYkwc7i3CDQ
         wJLF8qttT2Oovsx9xRfajT1yBTpXfCp9Ogq8eGkKFREnig6B1JN5sTP5vSOZuJEEbbF2
         6HJ5AigTvXn+0C5/W3zrgItKP+lg7N+dN4cG0ffRz7jX063ZsoBTOBa4phDLjLnfaaka
         xENdQoNJxFbRbXS//y7iVxpQ8xK0I/ZJO4LXh9GLFl5L9ktGbWIz6AZgTphMDsp1Zg+P
         9gdssFcm+j5LSPElZN8451Coe+jpquH3uKuvh4S2Cx3K57z2/frJBHwp7G+FQ+DUK++T
         QJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0QAOCV+DI2/1v7xM1t5XUU40sLfiiU3L3MoNj0PlkIM=;
        b=K884fN5KQwIAqz3iYhqzH8bybn6kpuYotMXaM6y8I9iKAiTFLeGlMpw5PZxBzi4amy
         IWMpOX8xiq0FmrnQZCEirPqFkYCi6T7DletEv5626bm2Kffc6PbmScQQHwp/U0K3SwJ4
         TV2AhAHANQu2IQ/rZX8nNctnRKxe7LP481GmxnZjWDLob2dd69THzLdMuOr6zmf+DIpF
         qfxqn0y+U4+li5x5+sX0mmCu7AkHhKYmg2jDn+Oi2kZkyjyQkLTQ1nMdWfOeZVbKnQ0M
         lgaADhg7PT3S1TrPPXQ1rmMR2J0qsN11rXFbY2+gI+X2Xo4w3FIMe5u70fWQ5ayzkz1s
         9AYg==
X-Gm-Message-State: AE9vXwPDDgiOpZiZrCpqSIWkpENvgC1OsDxbyT1XFTNJMiifVQaIHkBXfd/LkhcYtpTjOQ==
X-Received: by 10.194.229.34 with SMTP id sn2mr5247446wjc.117.1473891303100;
        Wed, 14 Sep 2016 15:15:03 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id t65sm905798wmt.15.2016.09.14.15.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Sep 2016 15:15:02 -0700 (PDT)
Message-ID: <1473891298.3248.6.camel@kaarsemaker.net>
Subject: Re: Bug
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Mike Hawes <mhawes24@gmail.com>, git@vger.kernel.org
Cc:     mh351681@wne.edu
Date:   Thu, 15 Sep 2016 00:14:58 +0200
In-Reply-To: <B1BB8E37-C36E-4F4A-BC5F-FDA32CE162AF@gmail.com>
References: <B1BB8E37-C36E-4F4A-BC5F-FDA32CE162AF@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.21.91-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-09-13 at 13:18 -0400, Mike Hawes wrote:
> To whom this may concern,
>
> I found a bug in git while trying to push my website.
> I redid the process and it happened again.
> I also tried it on another computer and it happened again.
> I was wondering how to claim a bug?

Hi Mike,

When you think git does not behave as you expect, please do not stop
your bug report with just "git does not work".  "I used git in this
way, but it did not work" is not much better, neither is "I used git
in this way, and X happend, which is broken".  It often is that git is
correct to cause X happen in such a case, and it is your expectation
that is broken. People would not know what other result Y you expected
to see instead of X, if you left it unsaid.

Please remember to always state

 - what you wanted to achieve;

 - what you did (the version of git and the command sequence to reproduce
   the behavior);

 - what you saw happen (X above);

 - what you expected to see (Y above); and

 - how the last two are different.

See http://www.chiark.greenend.org.uk/~sgtatham/bugs.html for further
hints.

(The above was shamelessly copied from the "A note from the maintainer" mails)

D.
