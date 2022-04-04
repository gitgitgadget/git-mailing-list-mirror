Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7BFC433EF
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 23:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiDDXSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbiDDXSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 19:18:16 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D113E1DA59
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 16:09:10 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9so7990691ilu.9
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 16:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WqwW6BOU2CdvmIJgp87cP4meg06yqHfUbimSwjtCifg=;
        b=Glln1dsPphoUi3E6DFQf2vD1y6opUtvTuEfShN7ZGvm0Q1Gat2oOfDxmylNkTnDrdv
         SrdUGmS6AHIJ/LUOMiLzOwIY/vksxUKvmT+6MHnzLwmEeS4Tdj+wksjAp+BsqdsNqvts
         fkJHVOwXI3tlO3/Ov2yAxEfv6Lyu1A7FQBDA6JmOszh+2AXkrnTq6xNqCjEBAGFdGf1q
         QuYt/ZeNC3U6rAGRbPfx0nQfow8Rtl7C0fgc6LTZCakI8I0dfitvnOXUdAYrzpYET96F
         6c/66ELToZaNP3ci/yqRWwd8FgjZv5xcYKndexhWRdkhOG+pURrFoMutKvuJwHCSFWTM
         Y52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqwW6BOU2CdvmIJgp87cP4meg06yqHfUbimSwjtCifg=;
        b=ZDzG8FC3kzYk8ahgPVI2IZorQZS7A9FSkOf4LgLUWZtq76yQ36d4NZGSPCbIU9Z8b0
         h3vPAJvAeWzaW9jrPLDUPvaf/COki3FMLmFH72nxZCexN8/ms5d0EmAMeKwz0bZMrpyG
         vNrlF0QeEuwX8i51fkMqv9SS0+BkeDt1ONKLpd2k5YzV5FSU+enGmNCWLcPydviRWy73
         N8leQ/XFVGmlgzAn2W/alzOoHo1TkUyfSXUu422Ym2aYYu9OkzVReZnALvaOPdAPVV6Y
         TQqyMkrl9SVN2p1jXUD9zF+fKCS/iG/Wp1N3uVfLwtQpmdW2wFrULsQNrvmZ0PLH16iR
         15QA==
X-Gm-Message-State: AOAM531KU1JpIkI3x8OmeMdPGKGOdvMqOr3QabhnExENmta60w2uTTqA
        v08oj/16RlNckBMd5WR1ywdYCg==
X-Google-Smtp-Source: ABdhPJybQyUM/TMRuuaJcH8Mg7dNVcWMbQt3L2ajWjDrrFhMH32LYKhBtq2ozDbAFd1DfgsuCLJ57Q==
X-Received: by 2002:a92:ca4d:0:b0:2ca:3f5b:4d71 with SMTP id q13-20020a92ca4d000000b002ca3f5b4d71mr328457ilo.91.1649113750180;
        Mon, 04 Apr 2022 16:09:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b24-20020a5d8d98000000b006409ad493fbsm7296302ioj.21.2022.04.04.16.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 16:09:09 -0700 (PDT)
Date:   Mon, 4 Apr 2022 19:09:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Dan Moore <dan@fusionauth.io>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] git-scm.com Heroku credits update
Message-ID: <Ykt6lPF0JC1Mg2Tx@nand.local>
References: <YkcmtqcFaO7v1jW5@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkcmtqcFaO7v1jW5@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 01, 2022 at 12:22:14PM -0400, Taylor Blau wrote:
> To that end, we have a few options about what to do with the website in
> the future:

Dan Moore (cc'd) has graciously offered the support of his company
FusionAuth [1] to help assist with our hosting costs. From Dan:

    [M]y company has benefited tremendously from git and would be happy
    to foot the monthly cost if you are looking for sponsors.

External support would go a long way towards keeping our existing funds
available for things like sponsoring travel and lodging for Git Merge
attendees who could not otherwise make it in person.

Dan: thank you very much for your gracious offer. Does anybody have
objections to having some external support? I think the only change to
the site would be adding an entry to the "Sponsors" section of the about
page [2].

Thanks,
Taylor

[1]: https://fusionauth.io/
[2]: https://git-scm.com/site
