Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B9D201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 13:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbdBVNvh (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 08:51:37 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:35797 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbdBVNvg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 08:51:36 -0500
Received: by mail-io0-f182.google.com with SMTP id j18so2056147ioe.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cOMplza1ghFMC0P1Ok4Vh3X02zzwcKCccXEpxgXLuTQ=;
        b=rtdsEpXL5Mr8NmACDVPkUwzTkn6cNMlkW8rSvyUhZvHfVbW5w6jsdXbbYNo7/yCJ7k
         52X+vZY7+TbXrgxBMX+bSWzb6jCCQ8lU4Qds0nwqezd+NoXBRftUNjv25CABDkbqROh5
         Ze3KsVznrnbGI1/64MkstQAlIN+L6PFD3m9WW9J+vhH78k4ZjO5FaCWS4q6L4l0zK2YF
         eHhlCZ8nv6QNH7z5cxeP50DPl3q9vD8Ysxj2COH+3UULUEBYM0Z9KckEpR3qCMpcD4iv
         bXew9P2u3u9OX+nUBLIwkWGHnP8vPcVk0AcbBTIxl+ZHS51C1SdARyITh29HEI01K2av
         gUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cOMplza1ghFMC0P1Ok4Vh3X02zzwcKCccXEpxgXLuTQ=;
        b=teEbpAJ7Hwx2WhWV/B0ycm+MxogdHecjNaNS0bAu+tP6QzWr49xewCBDg+1nLU8Re/
         9dgDpWFl06yGzQl4v2yVnXsHYhATZx/HDzNEdZxVoltcOCcfiab/uE/qMXlzkFSoAUuD
         1fUAyx2cIce2JMBBjTca3vrHxKEuh0QH3UcG3qz+eu7oWU3VkStZtluDAwthnJcb7Iwq
         +D+r4yar8v7syAsQL/0dnrrhG7+0F4+8DLDK8Bo7DkvlwSwPzPFKtuoEqwxx9yQN+P5S
         1eEK5izkWcEmhCX5fxG1uaR1CJpni++aXYYMjKGZwjLSnpJX0NMMDAbuJs+T1bL1FyNX
         n+Dw==
X-Gm-Message-State: AMke39ke+lfg+GJgr/2rlnaLV2NEaw6HEtjXOHZ4ULYNx4Z+ksvZ3KxIxyP0bDvbOCHqKOPCbYmLct2FKnyCSg==
X-Received: by 10.107.182.214 with SMTP id g205mr28231655iof.120.1487771495984;
 Wed, 22 Feb 2017 05:51:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Wed, 22 Feb 2017 05:51:35 -0800 (PST)
In-Reply-To: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
References: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 22 Feb 2017 19:21:35 +0530
Message-ID: <CAFZEwPNEeCyVUbaU2J_9CuqCnvRjMR0DuHjz9cM81DzN0MYN8g@mail.gmail.com>
Subject: Re: feature request: user email config per domain
To:     Tushar Kapila <tgkprog@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Tushar,

When you run `git config --global user.email abc@xyz.com` it writes
out this setting in ~/.gitconfig which is then considered to be
"global" ie. this same email will be used for every repo, but ...

You can always override this. Let's say there is a repo named "foo" in
which you want the email "xyz@abc.com", then you go inside that folder
and type `git config user.email xyz@abc.com`. Note: the option
`--global` is skipped here. This creates a file `.gitconfig` in the
folder "foo" and now whenever you commit, the .gitconfig file inside
the repo will get the first preference and then the global
~/.gitconfig.

This will work for you assuming that you have different repos for your
company and for your open source work. Will this solve your problem?

Regards,
Pranit Bauva
