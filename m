Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 042541F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752298AbcJKVCn (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:02:43 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35229 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751993AbcJKVCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:02:42 -0400
Received: by mail-qk0-f182.google.com with SMTP id z190so7753603qkc.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lq18JNKKirA2mUgPQgu3pjhd4QNns3mXNy0Lw+mfZQI=;
        b=cTfLX606v4+Qors+oG+qMgdVncbx4LPCdCuLwLkgOtHTOgsUDCmOX3/TDpNlv8f05A
         xo5ZxwpWbbSx2lTLl048zBPBXem4MEIwdpZ2UtTgU4+hy0piGzec/JbtoJZW+r0KIltA
         gLB7IbQCzjVP7S0Ft5Tb0V7I0kr9e79B1vKZ9kVsVXUnzPvRrGiYwTAZXkzizUEPPxkN
         dlCwH6HypM7O/qpHcEfX/GrBS6gSyy9SPC2/ghNdKjMfdWhxC0dtZ9mwJE0a2Sr1coEL
         xvLKhoICrcuTjfWhOtqkhtvHRz0UbFujFYWi15eFcHnmptAhREbFze+5yP1GqG19D4Uy
         N9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lq18JNKKirA2mUgPQgu3pjhd4QNns3mXNy0Lw+mfZQI=;
        b=BmqGnSROxY1a0ak5jMByZ79Ydfd4y/3vcHf7O5+lfkFCwcqFnd6cmPYL10ZTYYwBtn
         1chN4ahkXbxY1ArHvYQpPxjOrMUWuFTPqwtV4XMSQLl+UECA4rAas8cId/cpYkQxwm4M
         akdHnktR019iPcwi5RwCsART2Ts/Wf45/KRhsywkSgbDdKp4IOhxuQu+MMysoiO0tdAP
         cphGGIkqOPmsfCpDgEILCBMUlcs6uMYolRXwXsmyYngX1dAL8oX/Qrvg6fmmlj9Jv9ED
         Mmi6Eapf+oA5z1GhOQGR40rWxpE575fehouzVMyHu46caJ9GPWXe3MN9Qiyq2Uc0FNe8
         TuFA==
X-Gm-Message-State: AA6/9Rm3Mz8/O383QMT1fxO9MvWDArcpjWr5gEku4ZgjV6FzDmJn+DcJs4TTpUFQAzEbJpT1HM8AtpeWtM/5f3+X
X-Received: by 10.55.64.80 with SMTP id n77mr5891673qka.173.1476219322564;
 Tue, 11 Oct 2016 13:55:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 13:55:22 -0700 (PDT)
In-Reply-To: <20161011190745.w2asu6eoromkrccu@droplet>
References: <20161011190745.w2asu6eoromkrccu@droplet>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 13:55:22 -0700
Message-ID: <CAGZ79kYg3sZ42W-PEE7MgCDvt_h7hEQ7KWZsVKMb3DY=x5VK+w@mail.gmail.com>
Subject: Re: interactive rebase should better highlight the not-applying commit
To:     Joshua N Pritikin <jpritikin@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 12:07 PM, Joshua N Pritikin <jpritikin@pobox.com> wrote:
> I assume somebody familiar with GIT's code base could make this change
> in about 10 minutes.

Can you elaborate how you come to that estimate?
