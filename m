Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD72920286
	for <e@80x24.org>; Thu,  7 Sep 2017 21:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbdIGVBH (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 17:01:07 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35678 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdIGVBG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 17:01:06 -0400
Received: by mail-wm0-f53.google.com with SMTP id f199so5521201wme.0
        for <git@vger.kernel.org>; Thu, 07 Sep 2017 14:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h6cajTSRd4i7d/YbIkloP5A7KUrAsboa7F8x13n+Ekw=;
        b=kZI97DWT4WAtOAdT4ymNokevs6KbnzfngtCz1iVMetll+meOzwSziHnp48O0x8P3pE
         Rgr4JaLbHs+giHUfmmCbEj0gg4RiKhG1CMGqIDv/odyBgfIGkP2//NZQB79JouloudKw
         WRAjU6WW8vees0NlDen5007Xuu7JxhQFif1sNfHXm7pfY3jJRhkPL2OWwnKLKEMTUB19
         uM6eTjo/AuL/TE+HZTTXziXX5Ild1BoHni9ZqJDZMvHP92QjoACvC+Zr46e286VVtCjW
         zK0m2PsNMHZxajXGxFYGGDVl6KGy1+lFjjCC1SJ3kDN5t4RcwUYal9KTWQ63dz7qMq2V
         crSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h6cajTSRd4i7d/YbIkloP5A7KUrAsboa7F8x13n+Ekw=;
        b=pPkRGA0FQj/FP49NDtQzXADYjNZeWr9rCQg7m5oJV1msXQXf3nadre048Tshn9I/YF
         ncRR0h7HykUX3RZ8D8pvOuEwb4wI/nVsEJpTA/kYb4LMtrNZYWB1bMzLjCCFyuUdyfGB
         0DQ6hXKzmg2O/kB4rI/5Mg6diG312X7D5Ssrcb9LjtjuhC3DjaMBMZVw3XP9M4GIzhDp
         furJY+uQOi+KfcWS7COis0p7HFjG1yJxXaf2KkOgvesEKBkdJwg64iVj3B69y8ssBCTw
         OapvZYgdnnyFn2Gv5K0qPsSK5x940LNe8mNOrkID8qXdF7+HUEJ3GN3i4EaBMudmjHu2
         7lWA==
X-Gm-Message-State: AHPjjUipcvvwGXyz/t9Kh4eRUCgz5DGouylP5TxBaD2LSdSHG1durQDM
        ICyOSWruO1h3ytsxwX0fbX+r4PvWOA==
X-Google-Smtp-Source: ADKCNb7EVYaG+qn2FtQ2Uw+bwjFuKqhROSAM4zoI8YQXrCTQ8p1eYx2K09eE19j5C5tglcawGXf/Kbha/msKuRXIBdk=
X-Received: by 10.80.186.110 with SMTP id 43mr249792eds.18.1504818065249; Thu,
 07 Sep 2017 14:01:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.204.206 with HTTP; Thu, 7 Sep 2017 14:01:04 -0700 (PDT)
In-Reply-To: <CAGZ79kYaOKPRGXE8sc74uXQ__iGY1wZqFhyQeXBRAiGH=ujYLQ@mail.gmail.com>
References: <CABjWGHx5VQaLubeWsqWJzufDU3vt9BSS0=LpwgOtMDYhje=qMA@mail.gmail.com>
 <CAGZ79kYaOKPRGXE8sc74uXQ__iGY1wZqFhyQeXBRAiGH=ujYLQ@mail.gmail.com>
From:   Kermit Short <heraldstorm@gmail.com>
Date:   Thu, 7 Sep 2017 15:01:04 -0600
Message-ID: <CABjWGHxb43_Hy+_gQ_tV_DQvs82_ehtwq-c7ZZzQrHJPk4M5uQ@mail.gmail.com>
Subject: Re: clone repo & history to disconnected server
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

OK apologies for not reading the docs thoroughly enough, and thank
you!!  This looks to be exactly what I need.

On Thu, Sep 7, 2017 at 1:35 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Sep 7, 2017 at 9:50 AM, Kermit Short <heraldstorm@gmail.com> wrote:
>> Greetings!
>> I have to set up a workflow where I'll be developing and testing on
>> one network, and then deploying to production on a disconnected
>> network. I'd like to be able to have the full commit history for all
>> branches, tags, etc. on the disconnected side, in case I need to
>> perform a roll-back, create a hot-fix, etc.
>>
>>
>> Most of the solutions I see involve creating a mirror clone that is
>> then merged with a different repository. My problem is that my servers
>> are on two separate networks and I am unable to talk to both repos
>> from the same computer. I'd need to be able to transport the files
>> using sneaker net prior to importing on the second repo. I need to
>> keep the production repo in full working sanity...i.e. import only new
>> changes or completely overwrite the repository such that the full
>> project history is intact and working.
>>
>>
>> Does anyone have any suggestions? I've been looking at the archive
>> command but I'm not sure it would bring out the full project history.
>> Thanks in advance for your help!!
>
> Checkout https://git-scm.com/docs/git-bundle
