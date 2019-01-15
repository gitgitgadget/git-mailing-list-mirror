Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03461F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 22:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391245AbfAOWtG (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 17:49:06 -0500
Received: from mail-pf1-f170.google.com ([209.85.210.170]:43812 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387714AbfAOWtF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 17:49:05 -0500
Received: by mail-pf1-f170.google.com with SMTP id w73so1999788pfk.10
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h4XwkV0J0mdzuoODb4m5bI6PLPxORcwHtmQufUag9a0=;
        b=iyt3VSTQU+wcMW8i7udkt/Sfvws/PG6ZmDKGiJUVWcu8tKcrFRGiEKvaFK6ruRn1Sv
         TkhMQRFCJMzrDsMGOYExZIelHpSPuRuMEwNSyYIhX7YqEm3jTntHx2JK5740rYte6sYg
         p3Aib+8XVJJIUZJB/ZKTWtlr3fWQYkKXWDJfRWe6bw5UIvKE4SY2ivP5Ad0dYUsQwcAf
         Rwh7+l5OZMuiwrWqL18BEH4uI6fmsnUWhEOHa2iBZsCsgdXf+4CPrBU/uY2TvOA4ooti
         c+MrXOYP+TntCUguqBKpIFNHpp4VoTu3XIhcgQVsonofzrGKFKIaxCxLhAooR4+lmuh4
         sWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4XwkV0J0mdzuoODb4m5bI6PLPxORcwHtmQufUag9a0=;
        b=qaXXViRFHdohUhGShRa6F5OFRB5dIG+fC00YKtYD6Go8gvWMiSjDEnb/r5HNWPdNA3
         IDvn+w7tbI3N5iZodyYc5JX/N2xfba9V3Mt1FwPbeGHrkUvg4H3vcxq1HVR7Ey/nyRrd
         /xgNSNKWc0UZfDB0HsMgHVMa+ZYrEC7N1/Dry8bxDYmH3p1GoaPtjofc0PGbmfH5uj6D
         UcHmWO/biqpYtHJ7Ep+eLYjaP7MCA4SF1K5JeJtbEULB0hIYdw3uO7RAjVLiclg5qvfK
         dOYai24PT0Yc+4J13mZbZ55WsyQ2Iw2zawDR8z40VxXfxq9J+RmOef3fOuwNOns92zEL
         HtVA==
X-Gm-Message-State: AJcUukehsJJfGQmjMSH2sPaUT1sipQgQsavXnbaeKMzt9hztWaaui7fV
        jfUFQnBkRB7NcRBZSn5RPi8=
X-Google-Smtp-Source: ALg8bN4Tn+NTuRZnta3mLiANphShK2ldyfhldLBuU6/MEnKd8Kl34odj07CBinRHvnUmxTjATcU6vg==
X-Received: by 2002:a63:6150:: with SMTP id v77mr5820567pgb.266.1547592544163;
        Tue, 15 Jan 2019 14:49:04 -0800 (PST)
Received: from archbookpro.localdomain ([4.14.104.186])
        by smtp.gmail.com with ESMTPSA id l11sm5195410pff.65.2019.01.15.14.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 14:49:03 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:49:01 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #02; Tue, 15)
Message-ID: <20190115224901.GA22644@archbookpro.localdomain>
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 15, 2019 at 02:31:06PM -0800, Junio C Hamano wrote:
> * dl/merge-cleanup-scissors-fix (2018-11-21) 2 commits
>  - merge: add scissors line on merge conflict
>  - t7600: clean up 'merge --squash c3 with c7' test
> 
>  The list of conflicted paths shown in the editor while concluding a
>  conflicted merge was shown above the scissors line when the
>  clean-up mode is set to "scissors", even though it was commented
>  out just like the list of updated paths and other information to
>  help the user explain the merge better.
> 
>  Ready?

The current patch should be kicked out in favour of the new revision,
v5 [1]. It hasn't been reviewed yet, though, so I expect some revisions
before it's finalised.

> * dl/remote-save-to-push (2018-12-11) 1 commit
>  - remote: add --save-to-push option to git remote set-url
> 
>  "git remote set-url" learned a new option that moves existing value
>  of the URL field to pushURL field of the remote before replacing
>  the URL field with a new value.
> 
>  I am personally not yet quite convinced if this is worth pursuing.

After our discussion here[2], I resubmitted a new patch describing the
use-case of the feature. I was just wondering you're still "not quite
convinced" or if the description was just outdated.

Thanks!

-Denton

[1]: https://public-inbox.org/git/cover.1545745331.git.liu.denton@gmail.com/
[2]: https://public-inbox.org/git/xmqqtvjlisnu.fsf@gitster-ct.c.googlers.com/
