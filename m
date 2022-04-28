Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40A5C433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 18:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350984AbiD1SYg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 14:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350977AbiD1SYe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 14:24:34 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4236256C34
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:21:18 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id r8so3792638qvx.10
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P8cgOQvbmQhQY2WtXJ/hl7WcKU1MKDbAthFVKdOEMLc=;
        b=Msfv6IN0YGCNgNSOfUuAurYHqL4l9nzEyxbmWzWp8cUIqOABs0OsmwNa2w3cudI5wV
         Bls9frrbHF6BN1mekqqd6f/mPtUdeMb0Gom7GsINijn4wfct93J1gagvSpzzQJ8zqj2w
         wMLO+qvzTy2rX3bavHfd9xF4+BD4N1vTaI9riQFRPkyYHltZNwJgc39O1FMq+v0+cVEy
         SkN8h1wx1i6koRR+HqQnWVvANha0HMc0p+Iq1QQYJ3VSXD8YvtYAmLVOUBeCS0+3JqZ6
         Q31rUMOOMMvYbcM3kV0NYjsCyk/MukzW+9oTXmW1BaWd6ETfbaC0kdwHPFFo4o/XJJ8/
         65kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P8cgOQvbmQhQY2WtXJ/hl7WcKU1MKDbAthFVKdOEMLc=;
        b=gEyTCnZz/V292pTA95NEMWjGQRopVvljzQi8HovMRdMGZw485EnYCXt5mxsCK7On/P
         zANcwIcbL7MGo+kztHBldd2p5tZDCC7oc86LkuAvOcnPh+6z4cCBrzi2KoBIRO9ym3Ht
         hgz7cXmya8WgTzrRm1JSlI5fwZdr47TeLW6XKbzeBi/CSw+OzFUngCtXcUa26nnYE+yZ
         +e5LuczPmv9bbAj/tqTdU7NrXMnHru2AXNnnBxUoAvS4NbRdUmlnYp3QWxFw3/Vb+B2e
         tJERbD13CtT8nH2awUEYC1LiYran0tR19kSwPhnLuf7lutcKG0dJyaUE9fonvYyjsEpn
         FYug==
X-Gm-Message-State: AOAM531GEf79Jf+S8NRdAAVGbntwqhHkm9ld5GApgAAU6FfzSW4jugVW
        6Q+jzL7pgFvGE+xY6yDU+3Y=
X-Google-Smtp-Source: ABdhPJxljN1yU/DC4ltmZtkQ0VK/ExPkJp+v1+ftW9ZMyRKkDnNrcLEm/PYI2zbS1jXSF/x5MhgZyA==
X-Received: by 2002:a05:6214:766:b0:456:5223:7bdc with SMTP id f6-20020a056214076600b0045652237bdcmr6682872qvz.14.1651170077386;
        Thu, 28 Apr 2022 11:21:17 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id bm15-20020a05620a198f00b0069fb41d38e7sm293028qkb.127.2022.04.28.11.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 11:21:17 -0700 (PDT)
Subject: Re: [PATCH 2/3] MyFirstContribution: also explain cover letter in
 GitGitGadget section
To:     Victoria Dye <vdye@github.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1226.git.1651086288.gitgitgadget@gmail.com>
 <afb80b8e9ee022cba9373f2191ee1619e5897b09.1651086288.git.gitgitgadget@gmail.com>
 <ed4a0e46-a45c-0b05-fc35-f82e377ea231@github.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <c7030c98-bd65-7d0e-89ac-ae291e22b10d@gmail.com>
Date:   Thu, 28 Apr 2022 14:21:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ed4a0e46-a45c-0b05-fc35-f82e377ea231@github.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

Le 2022-04-27 à 16:43, Victoria Dye a écrit :
> Philippe Blain via GitGitGadget wrote:

>> +----
>> +Adding the 'psuh' command
> 
> Typically I see patch series titles follow the same "imperative mood" as
> commit titles/messages (see 'Documentation/SubmittingPatches.txt'). I'm not
> sure whether that's a rule written down somewhere or just convention, but
> for the sake of consistency you might want to do something like:
> 
> 	"Add the 'psuh' command"
> 

I fully agree. I just copied the existing patch series title from 
the git-send-email section further down. I think it would make sense
to change this to also using the imperative mood just like commit messages
in a preparatory commit. I'll do that.

>> +----
>> +
>> +Your PR's description will used as the body of the cover letter.
> 
> Including the line "Your PR's description..." is somewhat confusing to me as
> a first-time reader, since I was interpreting this section to be the
> *verbatim* text of the pull request title & description. If this *is* meant
> to be that description, then the note about the PR description can be
> removed. That point is also mentioned above, so it's probably not needed
> here anyway.

I'm not exactly sure what you mean. I meant that the description of the PR
will be used as the body of the cover letter...

Thanks for having a look!

Philippe.
