Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AED0220A10
	for <e@80x24.org>; Fri, 29 Sep 2017 04:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbdI2EeS (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 00:34:18 -0400
Received: from p3plsmtpa09-07.prod.phx3.secureserver.net ([173.201.193.236]:36461
        "EHLO p3plsmtpa09-07.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751355AbdI2EeR (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Sep 2017 00:34:17 -0400
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id xn02dNObCQQ9Dxn0Bdyl2Y; Thu, 28 Sep 2017 21:34:17 -0700
Date:   Fri, 29 Sep 2017 07:34:06 +0300
From:   Max Kirillov <max@max630.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
        Paul Mackerras <paulus@ozlabs.org>, git@vger.kernel.org
Subject: Re: [PATCH] gitk: expand $config_file_tmp before reporting to user
Message-ID: <20170929043406.GA9325@jessie.local>
References: <20170928041417.28947-1-max@max630.net>
 <xmqq4lrn30bz.fsf@gitster.mtv.corp.google.com>
 <xmqqzi9f1lb2.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709281428170.40514@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709281428170.40514@virtualbox>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfMLJm31fZTh5+tFhlgel7m6/XxNdzFXQJyWYwq6aVtU+zBuGq3Msp+kFusL8bn/VEpU+ViQT4o8AKCYLnfOXIk3ilFjAmIEFXAPL/SB0fV6xYyXrJT1w
 /aPSdh5v9rBmyTM1XH71QQBEtCPe6gxwUGY6CaQpG5gSpI4rgLja083+3j1kJyqXaK9XT3F2VzZQEvLCrJqIJI9QY/BAQOq5eRWAu+D5PnJXjt5AFrjS7sU9
 jni7voUibs5M3U2IcvXVzPerGLexo4625iIbyZQOV7wOXoJ3VCrbxUN+ciH1Pg3H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 28, 2017 at 02:31:17PM +0200, Johannes Schindelin wrote:
>>> Max Kirillov <max@max630.net> writes:
>>>> Tilda-based path may confise some users. First, tilda is not known
>>>> for Window users, second, it may point to unexpected location
>>>> depending on various environment setup.
>>>>
>>>> Expand the path to "nativename", so that ~/.config/git/gitk-tmp
>>>> would be "C:\Users\user\.config\git\gitk-tmp", for example.
>>>> It should be less cryptic

> Thanks, Max, for your contribution!

I do what I can. Just noticed s question at SO about it
(https://stackoverflow.com/questions/46450479/how-to-remove-the-stale-gitk-tmp-file)
Provided that I was author of the message, it looked like
something for me to fix.

> Sound good?

As Junio noticed, it would be more reliable to show full
path, and error message does not have to be very nice
anyway. Also, gitk is already too big and I always feel bad
when adding stuff to it, so let's save couple of lines by
not adding another "if".

-- 
Max
