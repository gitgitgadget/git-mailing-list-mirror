Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6F91F4F8
	for <e@80x24.org>; Wed, 12 Oct 2016 04:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbcJLEn5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 00:43:57 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33173 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbcJLEnz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 00:43:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id i127so2733742oia.0
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 21:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ew0cibUtfaSFem1FozmqhB0JjIjPwnF8cjjIw0WotvA=;
        b=JKCm/mhYN01kmcYFXXxhK2tzGnq/E4Gzeu6jILg74oRpInISG1cC2VkwIAZ2kFy6Tn
         y9zmj0YEDsj7FxdffPKEFtN0CZA2zDn2GC25LpJaL/J6gN0RvZhvzIJu39/OnITU+GM3
         TrBWaWuT9wQCoZRTj4a+yUQGH/0tnxif0WHckVP9nsfRBdh6FJcFjZsb8A4bOMf1cc6z
         fej33wEZaq28cltsz4/vi958lf/8zDef8KS65tQKsa2HyvlEXTyLY83ETiRWY2Peh4Da
         L7MfBxnNEqkUVOLgl7XFtjAMrjaYK+ArgH5CeRxIBe+XPC0vpK0wEW8HUAV48YOGKiAq
         sDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ew0cibUtfaSFem1FozmqhB0JjIjPwnF8cjjIw0WotvA=;
        b=ALUccVK99vLCPFkRuTeU7mwGTYNG6RJqIyCbfgyrxS1nd2RdXUOUfqMyBruprf6dj9
         C7pumbE7V/SNAtodIfNV8M1/glmdTY9TTTNHNN1/DsyGrADhTj394ltAYLSjAiezQWqS
         6KjN5u0ceE4kFKldUiCKFWcdVAJeubhenoQhFVpLnZ9z4YFbMK3A8m4ifOiOoUwaek6I
         95AflWc1oRXT//7cipf4iWclm+gwzLa6QiWyVmzETnGxkXmhp1EIw1PJQX1aMeKJ+K3e
         UaDoXydgYH4yKfsfJ/Q+2vZIZ9norF1VXcMGStTFkDV32kbujeglyBn91uSsKHtJjoaG
         Nwwg==
X-Gm-Message-State: AA6/9RntdPxgbzsQKymkW08RTWn/Sx1Ftc7Y6Na8zolaEBn19G6k06aOPBTBLEqaZWjcBw==
X-Received: by 10.157.2.72 with SMTP id 66mr4062595otb.120.1476246512382;
        Tue, 11 Oct 2016 21:28:32 -0700 (PDT)
Received: from larrylap.suse (cpe-24-31-249-175.kc.res.rr.com. [24.31.249.175])
        by smtp.gmail.com with ESMTPSA id q3sm2354895oih.11.2016.10.11.21.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 21:28:31 -0700 (PDT)
Subject: Re: Formatting problem send_mail in version 2.10.0
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
References: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
 <20161010214856.fobd3jgsv2cnscs3@sigill.intra.peff.net>
 <20161010215711.oqnoiz7qfmxm27cr@sigill.intra.peff.net>
 <vpqfuo3l4fl.fsf@anie.imag.fr>
 <45cfc4e5-c30e-19cb-ec3e-407ceb4e3ad5@lwfinger.net>
 <vpq4m4iamfs.fsf@anie.imag.fr>
Cc:     Jeff King <peff@peff.net>,
        Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
        Jorge Juan Garcia Garcia 
        <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
        Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
        git@vger.kernel.org
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <b8f93bf9-bfa5-2405-437e-6bf9abf77c87@lwfinger.net>
Date:   Tue, 11 Oct 2016 23:28:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <vpq4m4iamfs.fsf@anie.imag.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/2016 11:18 AM, Matthieu Moy wrote:
> Larry Finger <Larry.Finger@lwfinger.net> writes:
>
>> That added information at the end is intended to be passed on to the
>> stable group. In this case, the patch needs to be applied to kernel
>> versions 4.8 and later.
>
> OK, but where do people fetch this information from?

This format is used in a patch for the kernel. When the patch is merged into 
mainline, stable@vger.kernel.org gets sent an E-mail with a copy of the original 
patch. Maintainers of the indicated systems then merge the patch with their 
stable version.
>
> When you use git send-email, the content of the Cc: trailers ends up
> both in the body of the message and in the Cc: field of the same
> message.
>
> If you need the mention to appear in the body of the message, then using
> parenthesis is fine: git send-email won't remove it (more precisely,
> "send-email" will call "format-patch" which won't remove it).
>
> Not an objection to patching send-email anyway, but if there's a simple
> and RFC-compliant way to do what you're looking for, we can as well use
> it (possibly in addition to patching).

I do not want it in the body of the message. I just want to pass a hint to the 
stable maintainer(s).

As noted earlier, this has worked for a very long time, and I think the previous 
behavior should be restored.

Larry

>

