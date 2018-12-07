Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A99CA20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 00:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGAZj (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 19:25:39 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:36594 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeLGAZj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 19:25:39 -0500
Received: by mail-pl1-f179.google.com with SMTP id g9so952843plo.3
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 16:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jYz7FW18xnKZDsDzLxNfyrj3OQnLxZhbAS7x9Zl4apI=;
        b=D7pV2+XFAYBdt8DwAAoXCK3HLArBsmbqvnjPU/HMTZciSmw6WCUIU18uO+ZgMXHOwB
         LKY/2Skjkt9q4Gk8eIDvpV1BartbaW6wyfC69zmhe14mIQqwQqKYkN4Q0XU/ND+fvMQ+
         XRFyVBoSMHKDP04tT49Rs8HNkxtDHbEGFuVbMkOrw6hYw0NCCAGfA4bEOO24ZX1xKkwL
         BRQEgY2oc1T0qoxVoeZLT4oPN44pgN3p3GsjNjzu8oCck31cfBJvhUDEvkGctS7hlvmv
         RZqPzJoBE2UWf98Rw7ouIPoleqm845ozkq98RyabNdurXEu0lH5qgN9N/aKjr5B/T73J
         PxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=jYz7FW18xnKZDsDzLxNfyrj3OQnLxZhbAS7x9Zl4apI=;
        b=Uzrfwme8hoZtLYGA/vHRUtAD82XsgU9ze/jwN1KopA/yoxYOuB19nXQIzP1Nqd5aX0
         J0PQhMDUtnMCP2q/pwQ0yKBhZ/k7ZjhDG5LukGTgQ+L0O0I5sV+YIh2d4JrDXfwvyn1m
         S8+NKIW4/q7PqKTQEewBrS+uqxzpR++gaY1A3u1qE4n7d8iwKAMzBD/zNQSKmijbgsjQ
         otia/P1JVAYXI5j+XbJzmZChkDTgYwWzlZ+Nl0aM1zcLzGg/vXW/NTUzXiolc88qZevN
         2B2SZlAyvBOSX/9bBNpTfykebQO8fkbwtBtHzzbggsuhxYrxENgDX/vdjYbb1lRFHXvd
         BE5Q==
X-Gm-Message-State: AA+aEWa5encmkg967Uf1fiyuQ6UYtgpfur3uhHCAhlxYItU8QVn6W3An
        zH/s/bNeKbyim+d033B1OjcBPg==
X-Google-Smtp-Source: AFSGD/VATxpQbOPLXSXe18HMkeYj/1ezAchq4Wx9lMAgGzieLEClGhNNVrVVIXnYMLr8HQgjTmcElg==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr92646plt.98.1544142337860;
        Thu, 06 Dec 2018 16:25:37 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id w185sm1836967pfb.135.2018.12.06.16.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 16:25:37 -0800 (PST)
Date:   Thu, 6 Dec 2018 16:25:31 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Subject: Re: [PATCHv2 0/9] Resending sb/submodule-recursive-fetch-gets-the-tip
Message-ID: <20181207002531.GA37614@google.com>
Mail-Followup-To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com
References: <20181129002756.167615-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129002756.167615-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.11.28 16:27, Stefan Beller wrote:
> This is a resend of sb/submodule-recursive-fetch-gets-the-tip,
> with all feedback addressed. As it took some time, I'll send it
> without range-diff, but would ask for full review.
> 
> I plan on resending after the next release as this got delayed quite a bit,
> which is why I also rebased it to master.
> 
> Thanks,
> Stefan

I am not very familiar with most of the submodule code, but for what
it's worth, this entire series looks good to me. I'll note that most of
the commits caused some style complaints, but I'll leave it up to your
judgement as to whether they're valid or not.

Reviewed-by: Josh Steadmon <steadmon@google.com>
