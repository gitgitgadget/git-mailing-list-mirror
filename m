Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBEEA1F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 10:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbcICK0V (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 06:26:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32921 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbcICK0U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 06:26:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id w207so6030767wmw.0
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=n067QGHSoXOhOkdxfS2EfKpyj0ziBaZtQV/vcSDO7f8=;
        b=ZJ0IeG3FkuO1nvuUFHOdFW0OuDmk/Hr/EPJCt+1GAXOYSwsmzOrcZwuGTTjNeKKxPx
         edbXsMR3oCgW2FDFZ+Gv9A+0p4XFia4Mp+ZyPTplt7j2h3qF3ANk20c++cRfvWfq63T0
         Pb+pVT2tpUCnLtlQR6amVzl9Q5aVFA+G0UU+1sXybLnveAoNKOAOFvORZQe4Ilj4+zG6
         a12/VhTftPP4iJQJg+dUkSuOv5bms8i3lhnCko2kN8MQDk33gr4darAsRKCGfuvIUgOx
         pXvs+VWedigWqAaePk2NiLGPmOu8Vv0FB2tMxyZjWX/edeJwhcbH/YiXrUxapgSYuh7C
         n3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=n067QGHSoXOhOkdxfS2EfKpyj0ziBaZtQV/vcSDO7f8=;
        b=TdGsIGmPmSMcE3tlM2zuQd+DoWpMIwmAc52QmAB9EfigC7P+9fuTnxIaUmbCwzZYrv
         igPr6ak/co+0CIWPxufjWaoMGqG9sLVoKxwRv2kdXHnvv5A+autlhmFCaoqe7LkLOnzR
         M+09R0X/oKWuKlcbyOr66+8qy3F07aZwmd0GqdNjCEegmycF+buzh1iNf0IhX3mzJISp
         nC4nNF81GHgITqmjr16IjKF0pCdqRlbQMuiLJZV9MOvDpm28acBfL2vEz9qJZDZcOUUI
         r0d5bSyC9FB0kOVlGbLV57KOAcPDz6P4NljtoUkh350mN1DP8ImRHpZzP1hcOzw1d4yG
         tfPQ==
X-Gm-Message-State: AE9vXwOVis5QcgWfppLeRGUt6vqUVjjEH1z4RUEnZj1kcuVCKEuUTQpA+m8TdawHP3dMmA==
X-Received: by 10.28.12.76 with SMTP id 73mr6900689wmm.118.1472898379044;
        Sat, 03 Sep 2016 03:26:19 -0700 (PDT)
Received: from [192.168.1.26] (ewi71.neoplus.adsl.tpnet.pl. [83.20.232.71])
        by smtp.googlemail.com with ESMTPSA id w203sm7839899wmw.7.2016.09.03.03.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Sep 2016 03:26:18 -0700 (PDT)
Subject: Re: A note from the maintainer
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqmvjpsp5h.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <77c9288d-4b4d-fda8-a1eb-dab4b5056b1d@gmail.com>
Date:   Sat, 3 Sep 2016 12:26:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvjpsp5h.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 03.09.2016 o 04:17, Junio C Hamano pisze:

> Please remember to always state
> 
>  - what you wanted to achieve;
> 
>  - what you did (the version of git and the command sequence to reproduce
>    the behavior);

I wonder if it be worth adding to not use aliases (or expand them).  I have
seen quite a few such questions on StackOverflow...

> 
>  - what you saw happen (X above);
> 
>  - what you expected to see (Y above); and
> 
>  - how the last two are different.

