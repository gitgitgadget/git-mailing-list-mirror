Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257591F667
	for <e@80x24.org>; Sat, 19 Aug 2017 18:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdHSSCL (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 14:02:11 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35989 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdHSSCL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 14:02:11 -0400
Received: by mail-oi0-f44.google.com with SMTP id g131so122930073oic.3
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8oCTlxNYXD6aFyD0BxISWIfFy3rxDs6Ud1eJfBbsCBY=;
        b=MltR4tE9hnMv52jyJOtFbuMCnbPYxV1Epj+V54YrTus8LWD4AIjsidLze5kx0UInNH
         IS2J3t/sqW/phBVKqwm8kFSJEqWBGJuzz+qK31pAPqnbcMOYMUN26HtiJjSicm3CX3kh
         MAQQNe6XPJE4EWFsoBMHRwXDsR2zo8tN6Da7SoWrA8KmaosBVsXOCoVay9hCtId1N8Rl
         haQ7LqnFb+PEEkAPN2yZfjGou2S5dIf8Cps1Cudu0SW78uJgNhif2BhdEp58xkxTMkWk
         a/GXS2N3u1exN+6H+VHYXEcURR8E5BdK60Db30fCSmrRkoV89Y26hvhYW9GP/tKp0U2q
         om4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=8oCTlxNYXD6aFyD0BxISWIfFy3rxDs6Ud1eJfBbsCBY=;
        b=Y0I9BUrmqPAFOuCMSFYLntHzgQH54ltsZZolT8+Ujac1+2PBEwyhcuACo2mesBwVo5
         w/3hR5nqAGJ5xsxs1W7vuIlxqbnid6mRL68dJMI8Zcv1MK6kOvDUYhY4mrNqNgu4+g+4
         NupVv3mVuDYQm5L7chOZKds7bhdkYBBAvigRmXgSqWAWqs0l0Zrb9rEAO+nkQ9b8khi3
         vlNg3ge2n41OAUl6+h+IXd8o5r0bfL1UJaOGWDLEl/xmQkHa5EQNvz+70+Ioc6VmDpNI
         zGxyu5BdYFGl3u9t4nUT/P8nlydDU6R2J0MZSGrKTqtStBzQa6rQCy8LLq1Z0mU4/Way
         TDqQ==
X-Gm-Message-State: AHYfb5ieT7g5rohGfguJvTeVJN0FK8UIzrd0lnbjqMz1nWQWIV6ipeLk
        uukHcgtbljIDKrCLEEiKAn6leLmHBQ==
X-Received: by 10.202.63.85 with SMTP id m82mr18566643oia.113.1503165730583;
 Sat, 19 Aug 2017 11:02:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.98.28 with HTTP; Sat, 19 Aug 2017 11:02:09 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com>
References: <CAH8yC8=i33rtopVt=sgg0k+P4JQO+1EVpPJ+u5CPGEXKvZ+PBA@mail.gmail.com>
 <xmqqbmnba50e.fsf@gitster.mtv.corp.google.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 19 Aug 2017 14:02:09 -0400
Message-ID: <CAH8yC8mpPRN2y1k07_Jk9QP88=gpLKNWfV3W0QQwXTWxyL5STQ@mail.gmail.com>
Subject: Re: Please fix the useless email prompts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 19, 2017 at 12:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Walton <noloader@gmail.com> writes:
>
>> Is it possible to fix the issue shown below?
>>
>> I'm on a test machine. All I do is update to the latest code, build
>> the library and run the self tests.
>>
>> The test user account does not have a name and does not have an email
>> address. There's nothing to provide.
>>
>> There's no reason to break my workflows for useless Git policies like
>> "please tell me your email address". Its not my policy, and there's
>> nothing critical about it.
>>
>> ...
> Hasn't this been asked and answered already?
>
>     https://public-inbox.org/git/CACBZZX4vEOD-4a-eK-uBxmFrb1GLSvJKxHW51whCSbCZdh7amQ@mail.gmail.com/

Its 2017. I'd like the tools to work for me instead of me working for the tools.

Jeff
