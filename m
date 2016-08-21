Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FB5C1F6C1
	for <e@80x24.org>; Mon, 22 Aug 2016 00:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbcHVAAQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 20:00:16 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34528 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbcHVAAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 20:00:16 -0400
Received: by mail-io0-f196.google.com with SMTP id i199so7970897ioi.1
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8rJZuo3Xo6yoRWSMakg8pbiY05M4rJ7WSw4yVDBWB04=;
        b=K0clEPLL6RPAO/+JdSXYt0gZZHIDFksgqQWDnxOr/pi7Gue4oskebikM1MZnjbNoeB
         a8nsvflJXVmHAQz9F62eSbfnOX9MNNhqdDAtlUHjra32UryCpWC/yVkY0HVe6F1CNs+2
         Iq5nUdKY4ZlOX1BE1tbpiNMXKAut0/ebAH0aIuuFQ0z5XNbblHm1bNsXUSdZ6/I91hhn
         o0gSIXg6gGdCVPIiZLhnZdDHPHYkgG7yWJffiL+X+4v/IN22FqaKPCjkYHV/SX+iXyLe
         VDBnEc4vFm4VtBaH8WGpgLik9M3jTfXzjk89boIMvSuEuAqicyPJNPWj6Dx8R/+VyyMQ
         VznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8rJZuo3Xo6yoRWSMakg8pbiY05M4rJ7WSw4yVDBWB04=;
        b=DoeM2F4Og1LNpZ74K874uWShjzCCIGd/n9HCLkrKVnWjcQir6F/WsZrhJ7dMI8eWxP
         ePFH8oKY12Nd4eo1BwAtOPR7cE2y4Gl68LCWregwLwnkBdZtxPsILHt06XLoJMae+cG+
         Y8YDuaBDg+EtScCyjEWwB0At6hCnh0OnMFW30c0waa0oK0vNd1pxL/qAVvUGfozxnbEL
         Q7dFuN/VQP3sOj/V2L1xCNuCtzxz74XB1U7lT/1CFsTbecwZ4b4W6vKQTmhxsZWRLIdz
         DMMiRJQFtUhVDr2ftAI/YSHZ1h/VIXU5Asu9IsPjgtpZYv8SHGSAjHgq/T+N/Xo7AVfD
         LCEw==
X-Gm-Message-State: AEkooutjpSL0M0ZsupuXXH3/dIqDR1Y7TODgAtN+4IUbFOTcPX2qwl3ANw11nC1N2HwNdoVlMlCPzSJBhX9GFw==
X-Received: by 10.107.55.135 with SMTP id e129mr24452873ioa.129.1471824015090;
 Sun, 21 Aug 2016 17:00:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.50.70 with HTTP; Sun, 21 Aug 2016 16:59:34 -0700 (PDT)
In-Reply-To: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
From:   Andrew Ardill <andrew.ardill@gmail.com>
Date:   Mon, 22 Aug 2016 09:59:34 +1000
Message-ID: <CAH5451n0=kmr9SeOKSH5iiJr5Lnr2TapfZrTUR6Pm90xUEKFxQ@mail.gmail.com>
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21 August 2016 at 04:56, Jakub Nar=C4=99bski <jnareb@gmail.com> wrote:
> 25. What [channel(s)] do you use to request/get help about Git [(if any)]

It may also be useful to ask how people hear news about git, such as
when a new release comes out. Not sure if worth a separate question,
as there is a lot of crossover in the resources available for this and
for requesting help, but knowing this information would help us
understand what kinds of users are responding and which communication
channels are effective for git news.

Related, it might be worth asking how often people upgrade their git
clients and servers, particularly in corporate/managed environments.
This question would ask two things, how long after a new release comes
out do you install it, and do you install every update that comes out
or do you skip versions. I suspect many would just use whatever is
released in their distro and update at the same time as they update
other packages, but it would be interesting to know if people, for
example, only upgrade their managed environments every year/6 months
or something to avoid introducing changes to their users.

Regards,

Andrew Ardill
