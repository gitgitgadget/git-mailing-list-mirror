Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44CA71FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 21:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdJEVcU (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 17:32:20 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:45766 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdJEVcS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 17:32:18 -0400
Received: by mail-qk0-f176.google.com with SMTP id f199so2984346qke.2
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dd/mQg+kq3Xe9tSyN+I/BSBsmfqF6dsd9bYG1pthpIA=;
        b=VEfjACPYd/2dX/bK7NlWm+PQZNY5JLxlMvvvGN3rWBZuToPWLYcyrmlyEtDmf/AC47
         NkHijKjL/DQHKMha99niNGgamwzr4yEc++klj/fTuaQR+zAgYB4TBgVxjNHiNVzb9Dxe
         6Lnm1oXYHisWylj4iA5GAao8Ykn+SZR/+evwYw+THeFXhjWt4RxDXmQdT7C5KwKCOXFW
         jtd/oJaoq4DrD39rW7BFldg6JrtglaqyNim4fa7Xv+c00ejWDQUFXP21IxK6t/G80cp/
         ZOg6AQXHGrcz352/TrQkKybex+vNXX4Wh9ZOmI0/bvxjdpVqVlaMXDVnb4Wg7FVB3C4f
         pxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dd/mQg+kq3Xe9tSyN+I/BSBsmfqF6dsd9bYG1pthpIA=;
        b=hGMpIz2/NwzAGYyJQTTjvtYHvlT6/wvD4e8AVN1vP/e+Wm99V303YIg9FRSioiNSZi
         PsHceRNYusl9MgyahAMrx7Usl6DvlO8C3EUjsw7iP+8+QMfPlftNqzkUjabKLpQALPK+
         FM2W/iPWHe+RGV5dTU42CJEA8Ia/4y/gEkonUqkDNLW7ZKwYQkpatFmOGXNzEyw/W+NM
         R4k+a8I9+mBTd7j+84aMyViJNjgaSEQtBwdTeVKBANxWfiwLW6bobA8TT+ULVX17JVQg
         rUGx2+R7VRrwaC1hH3lKMwLcEq2vExYppabL0Kp2HxE6O8ih4TaTBG4nN++gZsoTNKQq
         6A0Q==
X-Gm-Message-State: AMCzsaWvSbAIJK9bo7qpSt0fywqyBwBlMvth3KAuCMtc/IVyT3XQ/jtx
        IC5Ou9maxMQYx7zehCtAa/BSbbqqKjsiO62wvAH3aN9R
X-Google-Smtp-Source: AOwi7QD4oKLXEBZy73wK1IlNXVCn/b4uZQr5vD+VjRYutP82CklZJQACyRzenXjH4dXLTJ++gFjp18RK7j54JYdqTTA=
X-Received: by 10.233.239.140 with SMTP id d134mr9347630qkg.308.1507239137524;
 Thu, 05 Oct 2017 14:32:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Thu, 5 Oct 2017 14:32:16 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1710051724350.2478@localhost.localdomain>
References: <alpine.LFD.2.21.1710051724350.2478@localhost.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 5 Oct 2017 14:32:16 -0700
Message-ID: <CAGZ79kZof3SWE_Pyb1ADVtkfD2+9ukV+nNBgwxt6xa52Vrmk6A@mail.gmail.com>
Subject: Re: is it "core.excludesfile" or "core.excludesFile"?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 5, 2017 at 2:25 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>   more pedantic nitpickery, but the git source/docs seems to bounce
> all over the place as to which of those forms is the right one.
> opinions?

In the code we use all lowercase to compare (any input is converted to
lowercase);
in the docs we try to come up with a sufficient cameLcase to not
confuse the user.
In tests, I don't know?
