Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879F2203E3
	for <e@80x24.org>; Fri, 22 Jul 2016 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbcGVUbq (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 16:31:46 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34290 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcGVUbp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 16:31:45 -0400
Received: by mail-yw0-f171.google.com with SMTP id z8so91754019ywa.1
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 13:31:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZQVGG9zpHMbpEwAkDmZ0JhHLixso3Gj7KxQ4bF4EG6Y=;
        b=O/YJt/v4AtrwssjxW06D8YSxcYs4kljF4WC/DO+ouxQR+5gq6Cc8MX5rJX6++/FcPF
         tGxxuPWYCWF4cWcUFFTkdefF2nsHRaSEiHtAvYrIEC5uZs3MRSzIgy+qRtx3XhsvE6t7
         XYvt/z3rJinpdsIxYZhyU0kbzWsOWxcHyqufWAJXZZMGAXzA1Z++T93uAASPGoQP/Oe4
         hB773aBS7cvFajXcxfB1fb/bWqfBcv/4r+NuebplNIHjIYns/6o3xyjnjZx7jfJQgEww
         UOEaNn/EBCkcZhL5xGkAAMSlbeZPwNl2wzCRbn9YayKrNSljut/JxyE59RJCNV6/8x+M
         g7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZQVGG9zpHMbpEwAkDmZ0JhHLixso3Gj7KxQ4bF4EG6Y=;
        b=HLnWzeVRBFB+LQg83cYE77b2IfIF+W98B8XhVp7GN50q77b6hEIr1vkqhhOTP33uOC
         Iefz1MpsThGanAzZWxG9Yc1cLOXp0lNppdVUyhhoga6amZYMYYSrR3tQ2jbMVI5dYBBh
         U2LGaVr5jslGZ8rVYyLE8rOsW18CbDrBtUr0GOS06B6q07aUo8Gw7Jm+ySDGYYXHv6RH
         QnXwRIT7anJ1pJeGBDzo6ZM6YOBpFSI7YaesfvZALvReAIWgYEXQOvqB8+66Rsg49Zyg
         b33a2J7bNki77+SYJygiaNWv78PwJP+9l6kGAQeDUM3UvFpdtsjDKe/ddl6Whhp8TpN7
         ICFQ==
X-Gm-Message-State: AEkoous+F1rnxhKjisxRRSAHLIKt4p9fntr2+/dmgog2dqmieKWE9jVaexfgO8+Pbt70DE3BcjBXXZnvqsvqxw==
X-Received: by 10.129.82.130 with SMTP id g124mr5308436ywb.208.1469219504577;
 Fri, 22 Jul 2016 13:31:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Fri, 22 Jul 2016 13:31:25 -0700 (PDT)
In-Reply-To: <20160722202820.18688-1-sbeller@google.com>
References: <20160722202820.18688-1-sbeller@google.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 22 Jul 2016 13:31:25 -0700
X-Google-Sender-Auth: LB9OO0zQj7kd0I5SuCdKcpfsuGQ
Message-ID: <CAPc5daXKiGr2CXCkz0D87cYygScVuCOBk40xUM-3O64ki=pXNg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: pack-protocol correct NAK response
To:	Stefan Beller <sbeller@google.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 1:28 PM, Stefan Beller <sbeller@google.com> wrote:
> In the transport protocol we use NAK to signal the non existence of a
> common base, so fix the documentation.

Thanks.
