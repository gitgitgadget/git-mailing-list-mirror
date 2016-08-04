Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3720D20191
	for <e@80x24.org>; Thu,  4 Aug 2016 03:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbcHDDuW (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 23:50:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33596 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373AbcHDDuU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 23:50:20 -0400
Received: by mail-it0-f66.google.com with SMTP id d65so18007511ith.0
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 20:49:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=N0XygjL01U7ZlxqUgFUEf1sMv+8oKnZ783Ouoz/mm+c=;
        b=CZViuxzafnHk+NHadm3zKMGgWyMFZCJ836dZY+ntVKkiGjG7qQ4WOcy8XVMmdc1sDu
         lORwt9j7QyiZyGBSgU8E/18G2rWfOitQ+WI0sMKQQBR3SDMo9W2Zirk4lWZ8Sgta9GoT
         n4gs4pPV0cGj2BhLPo/C37OrEu86PL70lPlE5DRuV3BiyUEX/7qyBULXtQWDdhShPngV
         F9xkWkJkiXqhVPM+/ar1hA6oD5NdC2t23oqmy16Jd48BJplPWqRABukxgn3JUQBiXbPc
         RkE/uFemE0eCDTbXnlSx6gFGTEzyLg56lZYZg3cya6cA0RbWlWH3NboAO2T411Ab3qpE
         Tvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=N0XygjL01U7ZlxqUgFUEf1sMv+8oKnZ783Ouoz/mm+c=;
        b=m7OMxUzCCsSzsQ/h1LdzTaTlo7cm0mQuFcZ0PjZv6GGFMXrE5HE3fHG9Un5ueBhFjd
         wXPlrVxpD1LDT7NufkCp6X/6/+QNJZ8K9kDqP2YB2THK0NaJVToXm9rMBNZPJ6eWSy1S
         VdG3Hjrv9TVajx1mi2Jjb+HkWn0v7ZgJeP6no1UMuRnWt86O0CyUb10QVN6UUUV9UiWB
         j/j8rHeDjlsmiaJSbWOohBcFI5gqptM9nDGdiL7HOEdlmLXnjPuhWL/BRDxlPfMGGsau
         BtoFz5Q0eXVC279tN3mzRnMe591ASBZg33lgJWNUvvYcHyLE0Fnb5VNQwGsPr1iWFg+X
         TwVg==
X-Gm-Message-State: AEkooussH3gks0ufUblimMKo2hNBKQo9xb+zzk/JBvx9zGfsf6SWz3y5s6IBzMkIWWJYVOZr1vJ7xYLiuJ8AUw==
X-Received: by 10.36.122.2 with SMTP id a2mr69791658itc.25.1470282543688; Wed,
 03 Aug 2016 20:49:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.217.135 with HTTP; Wed, 3 Aug 2016 20:48:43 -0700 (PDT)
In-Reply-To: <8f70b88987a2c69252c939a17c3cd474fe69d66b.1465893112.git.git@drmicha.warpmail.net>
References: <8f70b88987a2c69252c939a17c3cd474fe69d66b.1465893112.git.git@drmicha.warpmail.net>
From:	Jonas Fonseca <fonseca@diku.dk>
Date:	Wed, 3 Aug 2016 23:48:43 -0400
X-Google-Sender-Auth: kq5ZVy1DXJ-XUBJ9Vf2psBUuyIc
Message-ID: <CAFuPQ1LY=Td0qGZZuSFecRj_veN96LqBHymHYEaLVpWR0UBN_g@mail.gmail.com>
Subject: Re: [TIG PATCH] test: make diff/log work with git 2.9
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 14, 2016 at 4:34 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> git 2.9.0 switches the default for diff.renames to true.
>
> Set this to false in config so that the test suite runs unmodified for
> old and new git.

Thanks!

-- 
Jonas Fonseca
