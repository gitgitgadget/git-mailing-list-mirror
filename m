Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E208B1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 17:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbeAYRUn (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 12:20:43 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:33946 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbeAYRUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 12:20:42 -0500
Received: by mail-qt0-f173.google.com with SMTP id a27so21123415qtd.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 09:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=E5W7VzjbqnEdx3srl0qCOP31e0P1f6YMMYvF87h7kHw=;
        b=UKwGV3qtIeIy2ghRSY6j3MF+qj+mlZnQ0CtYUZZVtUunEWU1wi+rVWmOP1gxKapapL
         TUcL3O+wlmLcSN7uQ1QW/O3OcM+ghcswoPgel/Mu/VkCC1VXxhIb/b2zCxETooMYDCKR
         grbRutBLkJHXSiruCcD69s9x2PRg2/S/BBpvHeFic/oxHMki144cOYEZCuhjOH0dFRlF
         FlKTmxVYqxyp/P0EvLG5LqaQ1Lnh0+UcMxxgFP/90Umr4WfkJHXZjf62Uvp3sCZEBwW8
         ulWWHAx4Z60fetM2ACleFswBaM5q3fA4GCpnKkO7kmXREaunaEYw5ZgMRYYnvc2zLrIP
         zWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E5W7VzjbqnEdx3srl0qCOP31e0P1f6YMMYvF87h7kHw=;
        b=p89m/aGL4zxZRJYaGc0f3rqM2MGgRSh0EHpfCzkmExXQwM5CXzEqIZmvEFLVlanZPd
         XPXj4UjDgN6s4zIl+oJ6fs7oC8U3gsid57qPM2IIyebwXHdTi8KjQbQvgh6+woUReMCd
         ldXBQI4E/AzBhWNQua5OTWp0r4AK+j9HXrOSFsZMyotl2IFX+ci6WIHwUGogSZvEjAhr
         BqTVhLV3miuoI4/UakFL4JLZI6CtnUqE+zFLfzT75szqFtvHCK7VL7M6dTGoT1Ga95Ef
         WuDY7jW6gUKNPY37vUZUDM/2AskiIlXannLkiLKql5gU7gnjCSviQjiEVGEVmVNa+w/u
         rrpw==
X-Gm-Message-State: AKwxytesnzf1juoQFKWIT1g2HoW664uH1RS/Zj/9M/ckwN/pEQPph+xM
        4xF9d6TlUw4B9l8NtJlGpu0/InLPkZ5wRdqKS+0=
X-Google-Smtp-Source: AH8x226cgRtxhMIgpEjbskCPlm23Xof0aSGqhacho7pTJuG/Zh8WVc5C4kcVxiVvrv86k5M3kCQq1x/5FlQgbEdHaYI=
X-Received: by 10.200.26.69 with SMTP id q5mr17048197qtk.174.1516900841842;
 Thu, 25 Jan 2018 09:20:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.54 with HTTP; Thu, 25 Jan 2018 09:20:41 -0800 (PST)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 25 Jan 2018 20:20:41 +0300
Message-ID: <CAL21BmkTbr9qYK3+bsbwh9aDQ1twqrNkyUdbaFPSAn5y7ov40Q@mail.gmail.com>
Subject: Please review my code
To:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,
I haven't sent the code by mailing lists because 25 commits (every
commit in separate message) look like a spam.

Please look at my code:
https://github.com/telezhnaya/git/commits/catfile
You could send me any ideas here or in Github.

The main idea of the patch is to get rid of using custom formatting in
cat-file and start using general one from ref-filter.
Additional bonus is that cat-file becomes to support many new
formatting commands like %(if), %(color), %(committername) etc.

I remember I need to rewrite docs, I will do that in the near future.

I would be happy to get any ideas from you.
Thanks!
Olga
