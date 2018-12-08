Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D637420A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 00:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLHApI (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 19:45:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45682 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHApH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 19:45:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so2402420pgc.12
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 16:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6mds/sHFjFMC/AMtYAApx+Cv+KwhRKg+HN6Mt6Ammvw=;
        b=ksj4jTqtm8Rc6sySzT++6q2Mqnpknx+4QQ7ATh07srtdLxuUOkLm8BBQCXKL61A3OX
         Lu4GXJZotS/2o5e1PI/JDZgep9u1zpIlMZAVP2t/u16MEbFWOMFEg8gnUd4DIg68A7Q6
         JcfkUzFOrS0wFHWmtPT7mKgoEcKTxyeBDFW8+MMfentfX5Ju2+YxriH8OqPKt1ax/3JY
         bAElLectg1Mb9L1jHUn03OQqs0dPDbDBCcViMs+Pt5jYjZ8nRINatxT97IL2aLJZV+ug
         7AUp6Wz6/lJuNOyaBBkFFm1glfPCYwK3dPdoM/jDBf7wO6wE4S6mn8Wtb8m9fkAHzjkZ
         Jz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6mds/sHFjFMC/AMtYAApx+Cv+KwhRKg+HN6Mt6Ammvw=;
        b=ZtdgD9jTCs4pxW3YKRvn4asvl1W0ZxSkWVDp53ytY/WhCSrJxVM4vSqkzWtCsc3hXm
         WPLmHXeu5ngwfaHwYZAi8JQYTiG0vPOCJ9/7oTVKZeAIafdgDWA4tgrq49YSH2ptdOkN
         wx0zyhn0urP0tGCzIOsfoa9vlo7VSKtTCtjux6rxdJIC35CUroGtaH3v625J8LSs2IWj
         3K08QdWUHfex1c4ihJwyctNJ61e3qXLfle4kKXult+weevwvkScGnNGH0LVAX+odFhez
         lkwSih5oOO/OPoJ0+wjvkoieva2TgNqIqJbsV/V9HT1KNr1IVPKFfQKA9gl83bKPkKXI
         b2Og==
X-Gm-Message-State: AA+aEWaXT3FLkaVBjZan+He+agSGJn1XRyYgs95K5dlL0yAlMExQ1M3i
        ikpLz9FeotBncUhA/d3UBdBm5ah+
X-Google-Smtp-Source: AFSGD/X/xFJInRzcmeS2YYglPLTCSYSoxBxNN8O61hj+3LCmXhuQO6cHyxeQd/ann4Hm3Cj3/gHsEw==
X-Received: by 2002:a62:6204:: with SMTP id w4mr4332620pfb.5.1544229906476;
        Fri, 07 Dec 2018 16:45:06 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id z127sm6386134pfb.80.2018.12.07.16.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 16:45:06 -0800 (PST)
Date:   Fri, 7 Dec 2018 16:45:04 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Frank Dana <ferdnyc@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] docs/gitweb.conf: config variable typo
Message-ID: <20181208004504.GG73340@google.com>
References: <010201678b350faa-868bbac4-9242-427a-9d3b-fc6f00a95270-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010201678b350faa-868bbac4-9242-427a-9d3b-fc6f00a95270-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Frank Dana wrote:

> The documentation for the feature 'snapshot' claimed
> "This feature can be configured on a per-repository basis via
> repository's `gitweb.blame` configuration variable"
>
> Fixed to specify `gitweb.snapshot` as the variable name.
> ---
>  Documentation/gitweb.conf.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for fixing it.  May we forge your sign-off?  See
Documentation/SubmittingPatches section "Certify your work" for what
this means.

Sincerely,
Jonathan
