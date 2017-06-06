Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78869209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 12:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdFFM5y (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 08:57:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36348 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdFFM5w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 08:57:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id k15so34800691wmh.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UQcghjZrC1S2D11lEFyhhoGmC97j1/3Uq5HljXb5Ilc=;
        b=KcAF9EhP42r82ZIY9fKOKZfBzBpzKZwheXd4fB3x8Ooy607Kk7hWgK7csi37JcnwD2
         ODbcB3Efgqf19MSKJetRPDjiqKUavBgk4MRGQxK1UoLgyBtoUGnm9xD3Ok4c+hF8j943
         3+tdKUf016qoOf7l0BDd/bqB38s56qVz4u23A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UQcghjZrC1S2D11lEFyhhoGmC97j1/3Uq5HljXb5Ilc=;
        b=OL+KPeIIR42WMD5HTZ6kVQiHEcz9gpMk2oPxWaXjLo5hcwF8rIy0HjUtFo0kVpohhX
         FCZBAiRxBokkqp1DftbIWX3FHq+ZwDbvoRY5wb3WKm+HaCiaLuO657gn48R7Xa6Luh/D
         M7aV01k2drPUsnh2KC2UNLqylinssNpBc4z5vTJ1pGtRUXt8zYSOXVmG0Pf2WNDCOZPD
         n1D6iTIZdVb7YQe/gfVUlgXp2PYyozBukg6PEZVNhPh8Xdq3mLy2J7EV8ED0yqXlSKmX
         IhAjgI0Evf63XYJbPGefRM4Fio7MTkYsS/yETRR1sc1vKMBy+wOZJoLLxVHNyA4VHzV+
         wuHg==
X-Gm-Message-State: AODbwcCln5x++X274YztI9HZKWa5n0es1rX+Z9UMkgcjxRjljmnUsAVJ
        nQPjd+xY4aIcjDYf
X-Received: by 10.28.43.130 with SMTP id r124mr11374651wmr.83.1496753866351;
        Tue, 06 Jun 2017 05:57:46 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id w17sm6311476wra.34.2017.06.06.05.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 05:57:45 -0700 (PDT)
Date:   Tue, 6 Jun 2017 13:57:43 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Genz <liebundartig@freenet.de>
Subject: Re: [PATCH] docs: suggest "Helped-by" rather than "Thanks-to"
Message-ID: <20170606125743.GE25777@dinwoodie.org>
References: <20170605105341.35096-1-adam@dinwoodie.org>
 <CAGZ79kYZ2yTHxxRUjFZpFWsOWwmh6RBXRd0_a1K9kMTo4exD6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYZ2yTHxxRUjFZpFWsOWwmh6RBXRd0_a1K9kMTo4exD6A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 11:42:31AM -0700, Stefan Beller wrote:
> So I was wondering if there is a command that shows all trailers?
> Similar to a "shortlog -sne" I would want to have a list of all trailers.
> This is because there might be an even more popular trailer than
> "Helped-by", but we would not know when using the hack above.
> 
> While I do not think so, it would sure be interesting to have a list
> of all these trailers available.

I just did a quick search with the following knocked-together command:

    git log --remotes --format=format:%B | sed -rn 's/^([A-Za-z0-9-]+): .* <.*@.*>.*/\1/p' | sort | uniq -c | sort -nr

The top 10 such tags according to this (which is coincidentally the same
list as the list of all tags used more than 100 times), with
frequencies, are:

  61535 Signed-off-by
   1641 Acked-by
    984 Reviewed-by
    673 Helped-by
    497 Reported-by
    180 Cc
    174 Suggested-by
    159 Tested-by
    158 Mentored-by
    128 Noticed-by

As you might expect, there are a number of entertaining ones that have
only been used once or twice, such as "Looks-fine-to-me-by",
"Worriedly-Acked-by", "More-Spots-Found-By", "Looks-right-to-me-by",
"Hopefully-signed-off-by"...
