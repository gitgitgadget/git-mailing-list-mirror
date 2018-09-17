Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3BB41F404
	for <e@80x24.org>; Mon, 17 Sep 2018 13:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbeIQT0O (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:26:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40604 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeIQT0O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:26:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so17441279wrw.7
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qyJOZjvQptFZFk1cjAfu8iCqKS66Ho+rnTdpdTixFs8=;
        b=IkEQLTK2RWcnAflPbdemc+ME4nCvlwv6mDXz4Fb2Yu7RbgaXk8OGGhlkLNa3mGx8tZ
         n3fQsGtnnTK0BRsFH5U5MMxGgimVKv6rSeeepv5sY6Kuk54MY5h0DlSumEkvGXVOaC9z
         kFmLBpj5lQjweAVOcnWOs1WYP+RnuAsc3gRNE7UVhTwTIxOkASD2es7rOuZWPEEFDw4T
         rT+FpNoDoyJqrTNVpEQHXTBdocHlyjBw+xAgSclE7jo9BW/vQl+op4eu1+av9CXQ4Gvl
         yNbai5eUDBbNDalZXdHpTPTnjO9m17JDBBBxZwyCYu6pZSAN2oY2O4IWzt2qRnUo5OmY
         RJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qyJOZjvQptFZFk1cjAfu8iCqKS66Ho+rnTdpdTixFs8=;
        b=N5O1iHKLZtLh/0EviFSlgswP3AgcRUqX+T+R0qepdBjHq0/EkzIS/mVqhar0E93/rF
         S2BFjtaoD8+RfmK0LccobX4NbbNiCaVTqx6gTCN3NDqsnqDC/E/AESOPa9MzN2tVRFIa
         hFrongG5Maks3w96pkkcd5uPiw9X15cRkSwB2fMuhszkagr0DeYmbFYC0VN2KxxqO5e/
         eNr74gr+R+N+vBvTLl4o/OJpQe0PRdYpFzDMDzweazMM51tXTPy+fdiZYel9NsaGuI6S
         h3r4N26R/CXaX1VBT1qSQukCO5AIdC10j1/35BrswJblQv9WmQJxVPsKgb3tguvTkK03
         AAOA==
X-Gm-Message-State: APzg51BH3G2I5EyXMiiSJLfbqtasDS81YLp7+bY7VBx7R+wkwv3G+5Ru
        YDH8zGqWiNikL7q9Q/8f5Tc=
X-Google-Smtp-Source: ANB0VdaUULUtyVdSQ53Q9O0PU5WS8viG9NzBcHiM4Bh8PDSGLS4biXppTbSxoaoLePay0nWULBs9CA==
X-Received: by 2002:adf:eaca:: with SMTP id o10-v6mr17260753wrn.98.1537192724577;
        Mon, 17 Sep 2018 06:58:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q5-v6sm15338115wmd.29.2018.09.17.06.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 06:58:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
        git@sfconservancy.org
Subject: Re: Git trademark status and policy
References: <20170202022655.2jwvudhvo4hmueaw@sigill.intra.peff.net>
        <20180916101520.GC18517@gmail.com>
        <20180917032101.GD22024@sigill.intra.peff.net>
Date:   Mon, 17 Sep 2018 06:58:43 -0700
In-Reply-To: <20180917032101.GD22024@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 16 Sep 2018 23:21:01 -0400")
Message-ID: <xmqqd0tc9qek.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> (Also, to be clear, this is all _only_ about "Git Cola". The "git-cola"
> command is explicitly OK in the policy because that's how commands
> work).

These match my understanding.  Thanks for spelling them out.  That
project is an example of being a good ecosystem citizen whose name
we were happy to grand-father while discussing the trademark policy.

I can undertand the sentiment that we may not want to appear drawing
lines among friends, but ultimately the policy is about protecting
our friends from non-friends, so whether we like it or not, we may
have to be more explicit about who's grandfathered and who's not
than before.
