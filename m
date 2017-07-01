Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D429120209
	for <e@80x24.org>; Sat,  1 Jul 2017 14:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbdGAOPt (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 10:15:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33370 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbdGAOPt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 10:15:49 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so18354314pgb.0
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=cLHnLtqHu26YMiqUor0A8QV9ugva+pqdEPdeGB2gBoo=;
        b=pu4N/+w3utXv0YghBi04T/YYMrNoDBZVBm9URoOviCPxRPZyH8r4UwRKSZYestbCHF
         TJ26ljgB94ti1T3N6WK4ktPBzeZWbSDeI2461ysg5kRI5Ql1E1A6kXBlJzFTbOE/nOuf
         0oHq/THo/ImBuWDQ2pyOdjVSW6jzkh3yjnJjLEH25X54pUH1yjmCyXkARjGJwIKyBAct
         5qUxDtWzxCNiY+kmxBkFvbGvA3ZhOufOwPGOpCOnoqQWvbY9akYOpB5tA+2O/W7Tt4IO
         s4V7mT5MOOGfjRMPhdAmu4r24KtpmJU9UtW/Iwv8B4YZhsB6a4bDYK/md+TnZymavGuF
         IDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=cLHnLtqHu26YMiqUor0A8QV9ugva+pqdEPdeGB2gBoo=;
        b=qWrDChrJwKFXPcYQGuMSsJHaMX0KbJap58io1do4qQPIv5/LQFO8Mko+HP+ebHJKoR
         lTjtYdaaDzRpW2SnygKrnShnBsnAru7GYEIbbIAVEaICQHHh8M+xEOYVHOWrpap3ad5z
         q1BWybo9F4lbKy7UyT1g/QRZzb+Blp3Z6hCFr0d96wp1Jd/8e5JvhqZgj+mc2VhuIsrO
         q0b2Mz8RNDgotH7IC0/oDknKHiKHD8sv0MeQP7l/2SCEFYcRfmh18fTtIIPMNqXSjCom
         3Y/+LcGDWXncwCKDYvfanRLfuFU5verNZP0WvX7hXt2sjk4wvUTCVhmmKIM9A2hctFhk
         z/8Q==
X-Gm-Message-State: AIVw113i5rgDoGjrp0V1/l+lFhkcFQMZ8dGLXWLlTVZ0R9bTfRGkeJ+k
        IXbSK070qswqVQ==
X-Received: by 10.84.132.106 with SMTP id 97mr947514ple.234.1498918548286;
        Sat, 01 Jul 2017 07:15:48 -0700 (PDT)
Received: from unique-pc ([218.248.21.162])
        by smtp.googlemail.com with ESMTPSA id n71sm24313878pfi.95.2017.07.01.07.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 07:15:47 -0700 (PDT)
Message-ID: <1498918546.4321.1.camel@gmail.com>
Subject: Re: [PATCH] hooks: add signature to the top of the commit message
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Date:   Sat, 01 Jul 2017 19:45:46 +0530
In-Reply-To: <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
         <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2017-06-30 at 09:44 -0700, Junio C Hamano wrote:
> It does look like a hack.  I was wondering if "interpret-trailers"
> is mature enough and can be used for this by now.
It does look promising except for a few differences from the hook which
I'll explain in the following mail.

>  Also the big
> comment before these examples say that this one you are updating is
> "rarely a good idea", though.
I think the comment specifies the "editability" of the sign-off
drawback but AFAIK there's no way as of now to add such trailers to
commit messages. Until there's a solution for adding trailers that
aren't editable manually, I think it's not a bad idea to use a hook for
it and rely on the user to be true to their  conscience. Moreover the
script is commented out by default anyway.

The portion of the hook for adding sign-off could be removed in case
any configuration to enable "-s" option for "git commit" by default
existed. I'm not aware of any.

> By the way, the one that is still actually enabled is no longer
> needed.  The commit template generated internally was corrected some
> time ago not to add the "Conflicts:" section without commenting it
> out.
> 
I'll send in another patch that removes it but it seems removing it
would leave sample hook without anything turned on by default. That
doesn't sound fine, does it? 

Any other possible tweaks that could be done to the commit message
using the "prepare-commit-msg" hook, that's not done by git, and could
be left uncommented by default?

How about a script that removes the "Please enter your.." message from
the comments if it exists?

> Have you tried "merge", "cherry-pick" and "commit --amend" with this
> patch on (meaning, with the "add sob at the top" logic in your actual
> hook that is enabled in your repository)?
> 
Yes, they don't work with this patch. I have dropped it. More on it in
the following mail.
