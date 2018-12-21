Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02E7E1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 02:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbeLUCWo (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 21:22:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40725 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732301AbeLUCWn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 21:22:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so3688962wrt.7
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 18:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tcBiBJHRmwXS6/EBlsEzQhGEZMUJp3hx5Rwu1WyyIoU=;
        b=P6ZoRCiRfYLC1vVBuBKsvuzsckN6+G6vGSRfaQUotU2r5zQ9IqwMPCKp2vdOZns1Si
         2OjnvfNR1XWaGh5TxaoTvkusp+/Q5VYqxoj9Kxzb1cA89PMAeW5JNNys/6jMPUbO2l6G
         sk5W7doBu/26kvjt9wCSo89Jr7wumgoeUblnVmXSD2nZgNEPByeQgMaSUMt4B4ebkSCI
         HNWrg8wOKPo6ob6apZCgQURVp7lzAAPpPVOdh8ymHg/VYpS8FOICNo7XOwY/marsRh5k
         W1v8CwnoODiDBXd8nPvJrN/EG/0fxHye9C2ASBVOIjNlOYjvwKCnp+i5fAQaj1ZZXJeF
         UcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tcBiBJHRmwXS6/EBlsEzQhGEZMUJp3hx5Rwu1WyyIoU=;
        b=MFXtw4B5AG2Fpz7QnK7ZeMICwhqlJpWDr1ZN1B8mA6Ot/n3XOZsCAH6hEdm+UDVC68
         6s8wvvejWant6rzVo1F8HmuG6vvPZxeg4Kg0F4UZ/mXq3LSeC5ASVEI/MZutEfplll2u
         o/f9C3WeRdcNSr0D5L6wy7tFzFBLh6XurWVu8kj8kh47riOXhi7GlFJZ8N3amHYn8fvL
         RFlo/c5G+wD78BzjsVXptLdQbu1T9B9bSRCPDAdkOOMvGVrxxcfYWTmwOLt0y+OpvUiX
         XMp75C32sau6CzH1I5JlAr9MtAzNRTi2JRDiSKQ2gtvM50vnLRCO0BBhCm+saK0SfdWj
         MSyw==
X-Gm-Message-State: AJcUukd5XJSRtwvRvUNRLZjTY29hxfeWbNHvFilOrISFWeukSBX4qSmi
        DYMTeNK6N4bPSs14wFpUUcBN0DItSNUyo8Meeuauo1KV
X-Google-Smtp-Source: ALg8bN7uWr+b6SOib1jsL1s7uG29rgVHuhZnN2kibLF2DDuBNBaQhc7n1l/A3O7V6cqlS3COXMJmB9sgcbOski2EKUA=
X-Received: by 2002:adf:fd50:: with SMTP id h16mr548340wrs.231.1545358961918;
 Thu, 20 Dec 2018 18:22:41 -0800 (PST)
MIME-Version: 1.0
From:   Nicholas Hsiang <xianghongai@gmail.com>
Date:   Fri, 21 Dec 2018 10:22:32 +0800
Message-ID: <CAEcaDL=M1pYkfSOV=y3f=6AB04-rOoH1sqPffgBxOnc71b1rNA@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git:

When I type `git remote --usage`, The command panel will prompt
'error: unknown option `usage', Then there will be `git remote`
related instructions.
But I type `git show --usage`, just display 'fatal: unrecognized
argument: --usage'.

![git-show-command-no-display-usage.png](https://i.loli.net/2018/12/21/5c1c4d34075c4.png)

Yours sincerely,
Xiang HongAi.
--
Live Long and Prosper.
