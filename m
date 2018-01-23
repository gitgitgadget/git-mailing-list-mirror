Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92E71F404
	for <e@80x24.org>; Tue, 23 Jan 2018 03:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeAWDWX (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 22:22:23 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:37938 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751142AbeAWDWW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 22:22:22 -0500
Received: by mail-ot0-f170.google.com with SMTP id v5so9473307oth.5
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 19:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=RtM+hf9MIe5qCD4nhG9nXHZeUayobp5GbuKHf6WUG8U=;
        b=ImYHXMgDKbc9uJ4FysoTEHnkR0OI8Q1eA0Qfyc3ZUoLStuW5Kh4R7T7W7T4gKzbuXw
         owhf3Jh3BYO0vJ1SR8J/YI0AbM1gK8YM7KP4+2MzEDaEKtpJUfcx8EnWrWX2Hq/5t3uI
         nbkHmIc74xJE3mKpzalhpts65dx9mbQ24xerHctQ29S0Ker4iEHB9qu1exKFcoEDwoDv
         WilAUTcPgiD0aKtag4SVkPRAx5HDLWjQbLKpzvYCBGzOrqUhpzJTUoENrRXvmI4twfuX
         OnHkhhj2wf2hg2x+PiOKUB5DtejU8ghwB9uIfthA+xcXHYC9EaLOb048Lg9X8/E/flBj
         KM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=RtM+hf9MIe5qCD4nhG9nXHZeUayobp5GbuKHf6WUG8U=;
        b=Twj0GDutkT4gj+W43QLWZo/pqDhuoRZLivgJZZYYOopaKmX2or+GZ3o8No48LhhbL0
         Yn6nNRggQJ+tlXQi63g6PlPhZgMbqE+P73OiQc/Q5xf1kBF3dBgF8Glcpon96MWlhRSW
         b1mLL/L8AslWZy9NvYSmzewZxgbtjXIkRlz/UB6gRxQ+ETrrR1SUkunP6EiRep/VXoJE
         sFeRtT0CZ9gi9Pq/fisvboz1mbYY+aXkpFM8qop7bpoMQasXhWeOVxdMds0oCcZBsjQQ
         RJhpt7/R22PcKpi1O4k1ZVgCqrGkSbkB/RemQYs1qqCNV56yzumU+Bp0e97YQr+H8ILK
         WhSg==
X-Gm-Message-State: AKwxytfgHo8CaMuCnvvfu6oF7/TjZq4qt9GvG1lFJ149twCsEeRM2E5q
        UygLXYkSMRntsatcy9unfDSXaktMlAOJSIc6wZHyuUPf
X-Google-Smtp-Source: AH8x225gHCPbofmbNL6gstYCvwgxZbSB8ImKgfBIf1+SLIe9FEG6n8qRqzhXKOexCm0+KCOYBu+aDxFbMW9TWppzwi4=
X-Received: by 10.157.49.99 with SMTP id v32mr5788273otd.389.1516677741909;
 Mon, 22 Jan 2018 19:22:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.5.168 with HTTP; Mon, 22 Jan 2018 19:22:21 -0800 (PST)
In-Reply-To: <CAMAMitCV3xvaSr00H574Pww=r_c3=0NqT1Ge13kc=gWJqDJ3Ug@mail.gmail.com>
References: <CAMAMitCV3xvaSr00H574Pww=r_c3=0NqT1Ge13kc=gWJqDJ3Ug@mail.gmail.com>
From:   Aleksey Bykov <aleksey.bykov@gmail.com>
Date:   Mon, 22 Jan 2018 22:22:21 -0500
Message-ID: <CAMAMitC-iyH_YOAsJcPpLcUbmX-Zun4MCL89Pxn2rr7Lu_m2cQ@mail.gmail.com>
Subject: Re: The original file that was split in 2 other files, is there a way
 in git to see what went where?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My problem:

I am a code reviewer, I have a situation in GIT:

- before: a.txt

Then a developer decided to split the content of a.txt into 2 files
and add a few changes all in one commit:

- after: b.txt + few changes and c.txt + few changes

Is there an easy way to see:

1. what came to b from a?
2 .what came to c from a?
3. all extra changes apart from just moving stuff?

A specific command would help a lot.

A certain policy/workflow that prevents from problem like this (when
there is no way to visually diff the changes) would also help.

https://stackoverflow.com/questions/48350398/the-original-file-that-was-split-in-2-other-files-is-there-a-way-in-git-to-see


Thanks,
Aleksey Bykov
