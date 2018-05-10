Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88CC71F406
	for <e@80x24.org>; Thu, 10 May 2018 17:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966542AbeEJRu0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:50:26 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:33916 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965017AbeEJRuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:50:25 -0400
Received: by mail-yb0-f179.google.com with SMTP id b14-v6so942740ybk.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 10:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z8MPWBuzhgTUq7B1KdQCMgaXA4cxwBbUNfUdAmoBmg4=;
        b=btn7dTbkw4IKXHjL9riaZxwGsESL42zq2HHoVM+UwrLnrammXi3C/jMIH9Q52woqcY
         x7EXtUtnPK0Wc4Inykw1Eq4Uni6El/ihCX3zhXhq7k90I+60RnsEoDOx8kjBFnIlpYZ+
         fM/QyRgr/1sKXMecaz1MsLNlAPsFhx08HGMHWMFHlSSGFc+KvXVoZkhVJRtCmBA5mV7P
         LjDIHAvTECeDj9cJK/mZLZLzjkSGidudxPeP/S/7cr/93Mjfsb5S5Ct83VnmC2sE7n/4
         +pKkwQGv5EEcYYbacrpcKPG3g3N6GXkGt/xhtnlfrChod3jlVSF2tfAwvvcdnqu3vo0c
         9vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z8MPWBuzhgTUq7B1KdQCMgaXA4cxwBbUNfUdAmoBmg4=;
        b=oPC2D/EB4FJHF0Q9zpsjK4uxNDEW4Q2++5hHR27AudPdvj6IwcEnobjXv3+H/FBbon
         nM4QR8mV1ImT7gt1MlIvA7ZDGxU+KB1XncQyOwaNIaT+spiEqlCjUut2oG+j3+iSOqc/
         I5492wV36+VnOdQ9it/4ABfpKaw3i7TnByC10FGvwmrCfVPM7mbL9qGtmxDufvVyY2Kc
         LV2cX9pDLc6SU33kfSi3bT519trlj/Q0QmcabQq8UKt5yyhXUayNapjCqHg4LobYHq6g
         I+nHGhULjN9h+v/bKW42XyK1asFZWONei1gOsBXkI690vAXRB0rI/sNOAL12BjYmeoRs
         ypuA==
X-Gm-Message-State: ALKqPwdoZWnfMz65/iZhaOV86zHuK1ZLhj7BrKkaYzpwlWkUAdm777Le
        PubFLy6sVo0IXActqj4Gmhn2Ewbz8zGNSTLtgPbVBg==
X-Google-Smtp-Source: AB8JxZr82UgXg4EDrbPMQiOEBsGGEV/z25Jb1d+T/MGGAWxyBukudiQWB4WhVQH5O0yXlIsB/0p2ZE885wCUo7ZCb5Y=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr1297479ybn.167.1525974624353;
 Thu, 10 May 2018 10:50:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 10:50:23
 -0700 (PDT)
In-Reply-To: <20180510030723.32586-1-predatoramigo@gmail.com>
References: <20180510030723.32586-1-predatoramigo@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 10:50:23 -0700
Message-ID: <CAGZ79kYddyMjRTQ6Vqi-rvpy8NL6Ypti70uBRGs=DBjtK6Pk6A@mail.gmail.com>
Subject: Re: [GSoC] Info: Week 02 Blog Post
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratik,

On Wed, May 9, 2018 at 8:07 PM, Pratik Karki <predatoramigo@gmail.com> wrot=
e:
> Hi,
>
> The week 02 blog post[1] is live. This post is part I out of II and this
> time it will be biweekly. The part II of will come in 2-3 days which
> will describe the current `git-rebase.sh`.

Cool post!

> Do give me feedback.

In "and you=E2=80=99re choice of DVCS is Git.", s/you're/your/
