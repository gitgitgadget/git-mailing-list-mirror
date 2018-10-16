Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24EA1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 14:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeJPWSk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 18:18:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37835 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeJPWSk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 18:18:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id d14-v6so25887544qto.4
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7tSA1WbktAuwBfzKG4jM6Oc02BjhWaWH+RlmGUk1+0=;
        b=WkO8kHnWb2ABFAYq2As2s8+xVTivQyzItwbk+9R2EITAtjEjCgW08OxiV5wGxkkXn1
         lOVx8chafRI2TT/DoJ1cYtTeblb8LrAjjM2Ln3OvQCEdkw4Y6EZvDoyTnY7TqJTOn7ke
         o0OPwlR+QwB4LGtDhJYbL/ysS+1vZatPUbXHUNDSUtvUJd6X2NU16GZIWPE1TTZKu337
         KG/l70CXsc+01kgTT0IO3rNU1ztMoWjt71HwyHeJ3WwA5Vh9ryMCiuQ1qqyNCIQWFPKL
         CorX9fmsjjARa3jnn1xSxN8XA6z+MOOEMSUxLzFgEB/+bN3rBvNmCvp+3OdwqRHmAEiQ
         0agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7tSA1WbktAuwBfzKG4jM6Oc02BjhWaWH+RlmGUk1+0=;
        b=SN6qEbsQHdORo3CYnNIBjgF+xsgH9dvZ/l3bk62B+Q0zeGAOxkEyiQUHhfpgbqBREt
         s4zM7N6MCNsbm6BCdWVObnd3R/qXLTaX2eGuiwc3PiEJEi5z/kOS5NgsvkI7ZJ5xuN/M
         d50rqGnvZIPI0uErA1DFyqS2nKVyq4CEitrm8NRa4uk0lVEWyS/FK14Y0v08jGHCEyAv
         akLuBr88rnf4nXR0ZHL08F6TF/XHglQODIUIS08i0LSkGCIun3BT39/MtELCpPTxLOCA
         +8S095/4VcxqbNzqB6FmbiiSvrSU4TOJPZqJKzdaRlF78EwgQmLBjxFDJrmI1jU2awer
         OW5w==
X-Gm-Message-State: ABuFfojJI3rxOJcbdKyzqNF8/a9uW3pSOQrR5TPQQjLcBtvjGczLnKdz
        eavyaDy6w49vUIOdKcclKuUa7YmFGDuNFBPbyJnyJg==
X-Google-Smtp-Source: ACcGV629LjKj95BNg0I45a755pso+RkIsL0ZQCG+7fkHGi2y4zKGAMiz3gpzyainm0pXKVO+KI/ANq8Ihe3UbiXD2vU=
X-Received: by 2002:a0c:d4e5:: with SMTP id y34mr21886097qvh.106.1539700075886;
 Tue, 16 Oct 2018 07:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181015193525.GA8349@sigill.intra.peff.net> <20181016141405.2022-1-taoqy@ls-a.me>
In-Reply-To: <20181016141405.2022-1-taoqy@ls-a.me>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 16 Oct 2018 16:27:44 +0200
Message-ID: <CACBZZX5yfjturpWnMoLu_yso+NLS3eOWjSDaRnXunvN3bbS0_w@mail.gmail.com>
Subject: Re: [PATCH] branch: trivial style fix
To:     taoqy@ls-a.me
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 4:16 PM Tao Qingyun <taoqy@ls-a.me> wrote:
>
> >Sorry for the slow reply. For some reason I do not think your message
> >here made it to the list (but I don't see anything obviously wrong with
> >it).
> Yes, I cann't send message to the list using my email clinet, I don't
> know why. The only way I can make it is using `git send-email`(including
> this message).

It's almost certainly because your message contains a HTML part. See
if you can find how to disable that in your mailer and send plain-text
only. The vger.kernel.org mailer just refuses all HTML E-Mail as a
spam heuristic.
