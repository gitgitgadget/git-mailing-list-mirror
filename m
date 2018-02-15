Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B6A31F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755336AbeBOKih (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:38:37 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:40421 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755283AbeBOKig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:38:36 -0500
Received: by mail-wm0-f43.google.com with SMTP id v123so27028503wmd.5
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mNY0NJYSvYb3Yu9y+sOh4cGzIHjJGj1lu2wIxUBUvN8=;
        b=OdPDWYmVhrtOGh7d4zT1p9LeZu1YnvX5FKhEPKY448czhzmsnh9mAt6JYiKAgXpsGJ
         lGsXzEf3lkHpey93tJw9cfSoK8eP1cYFNYNg1Qso98yNKO+3S6JQJYCJ13Gut2W+Yisp
         q0vVNpRybHLDFl5PjVE4MHWEvltmp33EjC/y2NZYRH6VR6aMr/Vw9R5d9T2Pn0xjvJ13
         RkOUIduVMgYo62G5iN6DckhQXJta6mJQRMcJ/kZiLB9gcm/192Wbby1a1m5g06xK2FgU
         dW8ZQt+7Kf77cQ0jt2gOUlWhRydk3A7yCTXOwxDXJF9wniGzglvqVbHSJJPbonxPi8bs
         Jwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mNY0NJYSvYb3Yu9y+sOh4cGzIHjJGj1lu2wIxUBUvN8=;
        b=Bd1n05iKA2ZgRvL4GCaOuY3T7ffRXKCugZM2tu8Fyn00bH+iorf85qoJYA1/qepdLU
         q4dmA5Qx5eH8FmfJ5fVbhPMZIfJqESJgr7Uoa22ZY6e3t/jiEFfEYlhBn7HTAizUfKVH
         NLNfCEQJiHmCswsdcdA0icYYnjnVAbxvpqI3t9Ku0PHjSjaKy1UjWATzziAq1A7Y33Y/
         4tA78VkbxoqVDcDfEhoEcVqnR8+iim9+ihL8/nycW/oCyg38YQSvA3ZOm7nRgiLtHAPW
         v0sUZQDBNEiCIAolCTTM3uI5f1tx4Q5DeSBKpl5QUBx0ggDu8Y1idleEjfI39uugPg9P
         k+ZQ==
X-Gm-Message-State: APf1xPA6zP8T0i9TpKRZzC2UpNlfxkK2E6TkWtRo57ANGdyNlm6DEunN
        OSN0aYWCR2TU0dsmyFqiNwxqtDj5xdln0vyP2YU=
X-Google-Smtp-Source: AH8x227R23wJ/BWqC78mC4VJMKiEypjs0clxzVkGW79FAlUDFnpKxi4cap2N4qff+qV0CAYe722FC9zWWh6cMKOCDTU=
X-Received: by 10.28.135.142 with SMTP id j136mr1771303wmd.33.1518691115734;
 Thu, 15 Feb 2018 02:38:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 02:38:35 -0800 (PST)
In-Reply-To: <20180215055711.GQ18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f438c-9d30a51c-129c-4721-a85a-a3d66a2270b6-000000@eu-west-1.amazonses.com>
 <20180215055711.GQ18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 13:38:35 +0300
Message-ID: <CAL21Bmk6vcyKLDMdd9+Q-mt3huUEguO2fEaHFbce0hWNTE8h6g@mail.gmail.com>
Subject: Re: [PATCH v3 21/23] for-each-ref: tests for new atoms added
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:57 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> Add tests for new formatting atoms: rest, deltabase, objectsize:disk.
>> rest means nothing and we expand it into empty string.
>> We need this atom for cat-file command.
>> Have plans to support deltabase and objectsize:disk further
>> (as it is done in cat-file), now also expand it to empty string.
>
> I'm glad that you're adding tests, but I'm not sure it's a good idea to
> add tests checking for the thing we know to be wrong. If anything, you
> could be adding test_expect_failure looking for the _right_ thing, and
> accept that it does not yet work.

OK, I will try to fix that when other parts of the patch will look
good enough. I am not sure at this point that we will add my code to
the main version of the project, so these tests were written actually
for checking current functionality better before sending the code for
the review.

>
> -Peff
