Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3609A20323
	for <e@80x24.org>; Thu, 16 Mar 2017 18:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbdCPSyt (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 14:54:49 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34888 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752440AbdCPSys (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 14:54:48 -0400
Received: by mail-lf0-f45.google.com with SMTP id j90so24370437lfk.2
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=52Gth14CkCqPzlHaOahblwEWXpOjrHM3wdw6t6mOoLY=;
        b=gV6XIGrPyRKQigKsog6HOH+SfG1RBxaFEd6yKRpzJma3bVWAuCYHrRZwdo5QM+meGH
         hXlmGWzQSa/jW46IvC5zCe/zZkUFc5VxtPnACFQdOFAKF5821bLPQONvZzHLcIy9jxSD
         ZoNKoWQHgUGNBPh//WQhn4+FlcHUKFACBp0Jh8INoNIP30qvdStQMrtz2GYwrSZjCGHW
         05AzFWXN2Qkg7gD3GrYFPzouT1HUGOBl6U6f/4WY9AacH9K3EeU+WpfnCNKelRWDJcFd
         a6qtkZIuSyYxHwsoO0IqnqGz2MoCNQI+a1kAUSxMiLG+/QTTqbPzeS7gyEzQTvzaDCFL
         jLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=52Gth14CkCqPzlHaOahblwEWXpOjrHM3wdw6t6mOoLY=;
        b=YxR7VkF3Mgrd/oe4eMM7o08x1PjYVfwihKTy6OLn3QF2A+RLO3OuOCz1vzVjRE2o1A
         ocLX5ySIV0mlHmCotf/SMv8HREuPF/ROroJd+ta486fptTWgXeOt7lwPNAZnyHDrMHp9
         Bbr/hXjdpAMGAZK3WOuS/1gKpnNSA3hX7J+CHHgooNbCAovUWvdE8Kw7e+1SRxzxZNCd
         qsmUSpj56GZaKMiEkm8rRRojg6g8el1GrKIRTC/fCqAOJV3JQyfCY4+z3+j0B0/jZ6Ed
         BdKiWu6++m3nmKd4XQj8lrj5W4kO2va7Vk2iiQ2loUI+rI9ZZpjjt+fDQMl9b2woYplF
         Zx4A==
X-Gm-Message-State: AFeK/H12a9YJ+rsMF4u+1+nOuuBsyxdUT7iSrNk7Hv1r5RDmCukXJnibfvzbws2n6ExhU//MkLbWv08txwpTcw==
X-Received: by 10.46.71.16 with SMTP id u16mr3497995lja.106.1489690486446;
 Thu, 16 Mar 2017 11:54:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Thu, 16 Mar 2017 11:54:46 -0700 (PDT)
In-Reply-To: <20170313200854.6905-1-souravcristiano502@gmail.com>
References: <20170313200854.6905-1-souravcristiano502@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 16 Mar 2017 19:54:46 +0100
Message-ID: <CAP8UFD3toXk36wmJu+EeBnTvCa0yHWqCmQOfoJ0+2QTs8MpB-A@mail.gmail.com>
Subject: Re: [PATCH]v2 adding built-in driver for javascript
To:     sourav mondal <souravcristiano502@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 9:08 PM, sourav mondal
<souravcristiano502@gmail.com> wrote:
> javascript is one of the famous langugae,it's needs a built-in driver.

Please use "Javascript" instead of "javascript".
There is a typo in "language" above, also maybe "it needs" instead of
"it's needs", and please add a blank space before it.

> As it was not present in the userdiff & this leads to the patch.

Maybe "," instead of "&".

>         first line consists of some of the well used javascript keywords.statements

"First" instead of "first" and no space before it, but a space and an
uppercase letter at the beginning of "statements".

> in js use one or many keywords like variable declaration, function definition, logical opreation etc.The

Typo in "opreation" and please add a space before "The".

I am stopping here but there are also typos and things to improve in
the rest of the commit message.
