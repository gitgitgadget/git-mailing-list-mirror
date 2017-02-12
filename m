Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F318A1FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 23:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdBLXG0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 18:06:26 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33098 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdBLXGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 18:06:25 -0500
Received: by mail-wr0-f194.google.com with SMTP id i10so21840710wrb.0
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 15:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=q51hDWrgfG1zS1O+AvsWjiTBHxnJhVRPvhdBX5a/xnA=;
        b=jGiJl8Okkib5Yo7E5Brk6WoKMxMVTDHtGU4R+phV/S9Z2zq9kGc+f7VrUQISNH3Jg6
         6wIx4x7hAhXS8ecLOgujah1dachyggCtEkzrxQLbaKiKGZUmG2S8jkc1yZsQhPRQmN7J
         qIdZdTJcULOY7rxxXS2Cb0ucNPjKu1Fx4ByasUV+Gl+fpriFwK0zuPZI2gH/hG4+E4o2
         +Rws646+914DpELd2O0AN05q9WroOenrg6ZIwadqjF84M7WbNweK+YRI5XwWEGpipGe9
         85nZT2iGKTgwHPUSmB4CQTszf9K+sZh1I72cJDMC9sBOZuzAfuVh5QRsZ9MNOLJi/dvv
         XLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=q51hDWrgfG1zS1O+AvsWjiTBHxnJhVRPvhdBX5a/xnA=;
        b=AGpSAJd6e/MD0rfU0E4o6aYP0rqwl2RRQkk2l2MPSSAU3LtdrHTr4tdYPIpL4Gfp7U
         8zaYYUMhdCHP7OQ8hwrASd0CapcO7OFwpQXOvf1ujq254/WdQl3jXJ4abf9OBtSF/Oo7
         9Czy2IcoIP3OjnMis0FlyOO0YrrGVBOQpSN+GNOzO4NfgdPy/QGU9K6xOXhRsvGiqPa9
         viLVxEz90g5QxXrfFGeNb5Y2uQ/FgNjFmjcZhvU+RAWetOCaN1NOw7EaNqMEduAiHzzx
         HwDkfwsorUOkqg2XnxoPD96uyvGr+bDuMz2UMtD/kJvc0WZJdilqh5iKbhB6YJN18mJh
         teUg==
X-Gm-Message-State: AMke39kn9hDUldD+LIYpJh4WLiRuQAvK2vCdHH7y4cfhSZTqT36a9J+UEP5W0KkjW600Ug==
X-Received: by 10.223.139.213 with SMTP id w21mr17392582wra.108.1486940784012;
        Sun, 12 Feb 2017 15:06:24 -0800 (PST)
Received: from [192.168.5.102] ([87.116.181.111])
        by smtp.gmail.com with ESMTPSA id o59sm8380145wrc.56.2017.02.12.15.06.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Feb 2017 15:06:23 -0800 (PST)
Subject: Re: [git-gui] Amending doesn't preserve timestamp
To:     Juraj <juraj.orsulic@fer.hr>
References: <CAEPqvoxM9_Ku-1YgwNiqearUBaaYbAJcehuSwZYNNfJLQNH1_g@mail.gmail.com>
 <8a1179dfbb7743b6b8c23570306120b7@MAIL.fer.hr>
 <CAEPqvozCvFqOTNPw0c1ErKoOd+Mn1WCyJr9hj6CXiWWtL93Tqw@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:   Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
Message-ID: <3e6e8f1f-a35c-45ee-e1a4-83e89ac3c1ec@gmail.com>
Date:   Mon, 13 Feb 2017 00:06:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <CAEPqvozCvFqOTNPw0c1ErKoOd+Mn1WCyJr9hj6CXiWWtL93Tqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/02/2017 22:40, Juraj wrote:
> Hi Igor,
> 
> I forgot to write the version I'm using. It's on Ubuntu 16.04, git-gui
> package version 1:2.7.4-0ubuntu1 (--version: git-gui version 0.20.0),
> git version 2.7.4, tcl and tk 8.6.0+9. Perhaps it got fixed in a newer
> version, in that case, my bad for not checking before posting.
> 
> Thanks,
> Juraj

Hi Juraj,

Indeed, if I`m reading it correctly, it seems to be addressed in git-gui
version 0.21.0[1], introduced in git version 2.11.0[2] on 2016-11-29
("git-gui: Do not reset author details on amend", 2016-04-11[3],
referencing an old bug report[4]).

Regards,
BugA

[1] https://public-inbox.org/git/878ttji701.fsf@red.patthoyts.tk/
[2]
https://public-inbox.org/git/xmqqmvgidlsg.fsf@gitster.mtv.corp.google.com/
[3]
https://public-inbox.org/git/1462458182-4488-1-git-send-email-orgads@gmail.com/
[4]
https://public-inbox.org/git/CAGHpTB+35j0njmCZ0uCgBVroe=Ma7HLnn6fDty8yebKWgEmECg@mail.gmail.com/
