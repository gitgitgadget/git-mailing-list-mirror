Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD4181FA7B
	for <e@80x24.org>; Thu, 22 Jun 2017 19:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbdFVTNo (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 15:13:44 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36771 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdFVTNn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 15:13:43 -0400
Received: by mail-pf0-f182.google.com with SMTP id q86so12859481pfl.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jMd9+fEuEyODMGShJPQXLvct2w8+vFN1Pgm1bZLGVhg=;
        b=thMR28IZLR9GAdgU95vZRQV1WGzarUz7FpbsNPnei+JL1IAlJuGOHpUMTnPv1Px80q
         Q2CiGOECwjng6/nfyH3FXFko9SIdFkshP2btfpbKzNDBhH5XvRygeMf+/anpgtEAnVt8
         6LeMCBb9UMQqX5X//iA8RTx+1aX9c46XlCcQiXpD8fiMMtl9IOeOobPHQ67L3vrvl3sH
         QU1Dm6Jv3FJnrTZ4AnWU+z1ciASTsqJkHc1ZgK/of9w4x9O+QhZ1DCFN1xuqt4p86HN6
         ifZoaEuCthSlJDFFJ2/6Frziy9w/nsXTw6ecXckdQ8thO1Tra4NNoiddZBNYkc9T3Hw/
         U2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jMd9+fEuEyODMGShJPQXLvct2w8+vFN1Pgm1bZLGVhg=;
        b=BO+W9+Fvgrrxu8WLBjGXGIYc4AJWiYBJEnK0rYIkpa61aLO5yPpPllUKTh7A+eh5gl
         m2KmkS/Blz+DVVhHlplHlotW6h7vPopHttxXSCTMyK7lkOnTYKtMzeyFTPWZfXoGi7wD
         +4uMMEt0Z3lE6vY48AUMQ6SgFjZ2SywRje5ovgyG6ZelBGB7xB5aE/chocBgZVfzJWxw
         ruf5qPVfznTCR7MMAZ9vsaWDRCl4uap+lArEJnof+BjeOG36biaMHOCD1t5sKNMP77ER
         DZpVfywlmpmGwQQbYepbZB4rt58UoCIWgY5WXppbPU4Rq3MbbuXw5cdwoEO6AxxCkZ8W
         i8Lw==
X-Gm-Message-State: AKS2vOyKx4Q+TX8NiFuePKajR1lxApWrs+Khzk2UjJZ+wxtrLy7yHmnk
        r5cBL6Dxsc5IJes235AV3r27i+rdEa6o
X-Received: by 10.84.171.197 with SMTP id l63mr4530175plb.167.1498158823116;
 Thu, 22 Jun 2017 12:13:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Thu, 22 Jun 2017 12:13:42 -0700 (PDT)
In-Reply-To: <xmqqr2ybkfj7.fsf@gitster.mtv.corp.google.com>
References: <1498066891.32360.1.camel@gmail.com> <0102015ccdb6695c-7a8b1188-5bbe-43d1-8a8f-913c006c2474-000000@eu-west-1.amazonses.com>
 <xmqqr2ybkfj7.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 22 Jun 2017 12:13:42 -0700
Message-ID: <CAGZ79kYAJR7WXn9p1tGXTWTw9V4kpBX9g_W2_dy0AE9OLFPcvw@mail.gmail.com>
Subject: Re: [PATCH/FINAL] Documentation/git-submodule: cleanup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 12:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>
>> The "add" section for 'git-submodule' is redundant in
>> its description and the short synopsis line. Fix it.
>>
>> Remove the redundant mentioning of the 'repository' argument
>> being mandatory.
>>
>> The text is hard to read because of back-references, so remove
>> those.
>>
>> Replace the word "humanish" by "canonical" as that conveys better
>> what we do to guess the path.
>>
>> While at it, quote all occurrences of '.gitmodules' as that is an
>> important file in the submodule context, also link to it on its
>> first mention.
>>
>> Helped-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>> ---
>
> Stefan, do you want to add a Reviewed-by: to this one?  I've scanned
> it over and overall it looked OK (iow I didn't find anything worth
> complaining about).

I found it a pleasant read, thanks.

As all occurrences of '.gitmodules' are touched, I suspect we will run into
a conflict with sb/submodule-doc, such that I will rebase on top of this.

Thanks,
Stefan
