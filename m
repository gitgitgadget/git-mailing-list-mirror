Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E103203E2
	for <e@80x24.org>; Tue, 26 Jul 2016 00:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbcGZAnn (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 20:43:43 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32773 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbcGZAnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 20:43:39 -0400
Received: by mail-yw0-f195.google.com with SMTP id z8so11620574ywa.0
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 17:43:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iNBoAK2bs09tBhssVc4ly94fFKK5wkqtxzUE/3OMa3s=;
        b=w+xgnvCMf70tXN0VZ4s3HhIWp4w7psy/vv0hNr6FO4yYKJ9yy+b4u0GXHC8WYZitFG
         7sTZbIQXoh4qGK7/QtWT/2BRwBp5FiW4rVsxTP4SZ6kl75ZDLV+7sjrKTBKDICDrm29q
         6empEPWtFyDb4lgK89YeGjT0YXjrppcgEXgoAQ2818PIEEt81Hol0foFwdj3pIEfZ/83
         aLeStFa74Bqo2qwlk/jIaQnXY3VF7iUquobT4GWgWvL5v1ishspgtYQ9Ct4oeYuMU5VE
         Pjst+CDG4o4lZUfYdj+QwX17GqQKRsxLxFf97Ordz2rn0o5uds5PaIPEiNLLp9H0iPOZ
         wkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iNBoAK2bs09tBhssVc4ly94fFKK5wkqtxzUE/3OMa3s=;
        b=SDoNd2pr8BWNc5lxKXNSSn3FXHREKtFLkThUs+GNrdCjq1D7L16v+NCD8yiqO8w3Cn
         P1rPYAXT3qag7jahHG6UonLnnNzJ2qWs2+Y14o1ELO7Vgp6atSnKMknxdl2MMTvBNN2l
         7+F0azfsBcJsfvlk2+H9k0N4/N0uxbtYYdFAXxI/hDNGw5cODNDu3glcUN7yTzVGHxzg
         0soOAznWJNQi4XG6UwiR0Mj1uLrzdEo9rNgDlsXz5IvDMhhvKevRvw/vHZ0ZXSghl4WT
         tlApKibgAuVYcM1gzORnu9B30IxIH8GHMafPby7XMDNrovcJJQ8r0fzMbQf8HQVXwSlF
         OvYA==
X-Gm-Message-State: AEkoousX26qUOZTZ0pGMrBv864w05iZ1VN3J9mPAx1eEDxCM9VVAcirs058FekeT4n+Qhc6q9kVES2Ks/gwyYw==
X-Received: by 10.37.209.139 with SMTP id i133mr17061791ybg.80.1469493818290;
 Mon, 25 Jul 2016 17:43:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Mon, 25 Jul 2016 17:43:18 -0700 (PDT)
In-Reply-To: <CAGZ79kaJf9jU-fnicnB+jDTOvqOPTJWBy+9oo=fGm82Z8+eQgg@mail.gmail.com>
References: <20160719234508.7717-1-sbeller@google.com> <CAGZ79kaJf9jU-fnicnB+jDTOvqOPTJWBy+9oo=fGm82Z8+eQgg@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 25 Jul 2016 17:43:18 -0700
X-Google-Sender-Auth: tvUTZJJ5LO54HblXFaeuieCmJZc
Message-ID: <CAPc5daXP0E13zuQkBsxgwfVhLnJjG6U9zocpAHn0wUSfo6KN8Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation, git submodule: Note about --reference
To:	Stefan Beller <sbeller@google.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 25, 2016 at 5:38 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jul 19, 2016 at 4:45 PM, Stefan Beller <sbeller@google.com> wrote:
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Any comment here?

I personally found it Meh in the sense that those who read
and followed the previous note would find it adding no new
information, and to those who don't bother the additional
note would not help very much because they would not
understand (and more importantly, would not care) where
that "this affects ALL submodules" comes from, or why
that leads to "so it is only useful...".

But it may be just me.
