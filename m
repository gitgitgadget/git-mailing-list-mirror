Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20AC1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 23:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfJHXBf (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 19:01:35 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44636 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJHXBf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 19:01:35 -0400
Received: by mail-wr1-f47.google.com with SMTP id z9so124481wrl.11
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 16:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0r/M7DZi0Ny3eU1osbJqRSg+OlNrKN1zzlScpTtMkjs=;
        b=HHtjJpBzL5ZoW4ax51q39BwFkcAsYooT1anhiCDVTIHQkx5FPb6hBN/cqZaWE6VHMs
         +7o78AJkQJ/WHJ3FJMY05dCNp1Az8tHZsrJ7/B2guUd04xUTJPc5mH5nmSkWQZjs8/MY
         K4OPzm3SsNOUkFBmxwr7BolNFDdOtTo9f4l+fAkwhMzMnzDkXpED/CG6yeZ3JIoukYTM
         MiYFUqfCidX5nRCtB4pOjgzPRxR7/IMy9NW5+qqs4pnOzS44qvAV/lAw6ju9352WIfVu
         Y+zOBPGBJjWabRctqmMgij6POHwOKK0xYth3iXSEgDb8xGbhUS8NeMKgFbSqG8rupBNF
         e8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0r/M7DZi0Ny3eU1osbJqRSg+OlNrKN1zzlScpTtMkjs=;
        b=YPhDFjUoB+PHc4jstA28uEKL1NBsrH0YCvks7msibmiJfiXAmlm/4ZjzDL+7pN1vZi
         jpC7hPhSKMjFjY+hZKaOCXatpk4TvWFzV658hNBEAt8Z7Pcn1Kcd2ZWZazjDmgII5MAX
         xm4Og7rWHilyN2NG+U7O+Q+bpiNxA54tOT0mQZaTPIL55iYte3s3sSSpARaCZtMfJAO1
         ph7WssmHRoW5P4eFyN1V5gcP3xUFyiNttXNRFo00dyOTJWQFVdgCECt7tUqKBLXRfGLq
         twj09IRDLNCff4eguMWsPH1j83PlP/Jhe6rn2SsoKEq9945bA8+EJL2Iw1VVoJmQ11iC
         AGGw==
X-Gm-Message-State: APjAAAXQNMb8u+Vu7cRkg+wBcLC0u8MGdmvotlrUXp+KD6CjVFcF9id8
        Hf/uN2Oz2fNaEfLXOqefcTg=
X-Google-Smtp-Source: APXvYqwIvTqDDJE6bL6GB4TCYRgcca7rqiXHjuMuYGIMO5K5BB8UxDEnPYnDIuhYh4BvDSQ8aghJUA==
X-Received: by 2002:adf:94e5:: with SMTP id 92mr232068wrr.5.1570575693039;
        Tue, 08 Oct 2019 16:01:33 -0700 (PDT)
Received: from szeder.dev (x4dbe0d12.dyn.telefonica.de. [77.190.13.18])
        by smtp.gmail.com with ESMTPSA id o22sm601482wra.96.2019.10.08.16.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 16:01:32 -0700 (PDT)
Date:   Wed, 9 Oct 2019 01:01:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Uwe Brauer <oub@mat.ucm.es>
Cc:     git <git@vger.kernel.org>
Subject: Re: I just pulled, and git log --graph does not show all
Message-ID: <20191008230130.GE29845@szeder.dev>
References: <87sgomyows.fsf@mat.ucm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87sgomyows.fsf@mat.ucm.es>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 24, 2019 at 12:22:27PM +0200, Uwe Brauer wrote:
> I am confused, I just pulled 
> but git log --graph --decorate
> did not show all commits, 
> 
> Only 
> 
> git log --graph --decorate --all
> 
>  and from the emails I received the commits shown by --all
> 
> Should be on a new branch.
> 
> I confess I am a mercurial user not a git user, 
> 
> What is the reason for this behavior.
> 
> How can I now merge the new branch into master?

I hear you: I had a brief encounter with Mercurial not that long ago, 
and there were several things that didn't work the way I expected (or 
rather: the way I got used to with Git).  The subtle and sometimes
not-so-subtle differences between the concepts and philosophy of the
two systems might very well explain why Git didn't work the way you
expected.

However, it's impossible to give any explanation or advice without
knowing more about the situation, e.g. at least the exact commands
that you run and what they outputted, if you still have them or at
least if you can still reproduce the issue. (with potentially
sensitive URLs and/or branchnames redacted, if necessary).

