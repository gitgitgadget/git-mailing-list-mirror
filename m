Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 950521F731
	for <e@80x24.org>; Tue,  6 Aug 2019 02:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfHFCBf (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 22:01:35 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:45164 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbfHFCBf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 22:01:35 -0400
Received: by mail-pf1-f180.google.com with SMTP id r1so40574820pfq.12
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 19:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=yVALIvcLtThshk58K33hTE465MMzK7CEk9eHPSVZGGA=;
        b=hHXRAQu8HpKjakX7/68nohtph/5TjpGAH4JF7GuTe1KZyqy+ErlPBr53kUTZKn9y7q
         wgKNx/bVS7Be9usnhoPzd9UWkHuHqLlCkt2Fzdakc82JjtoCotgjqvukCqA8Dy0TJiU5
         odh+VUr7vpJGsswv7ZRDfm6eRnNso+i8lJtn9m/Ze9y1zEzffTQFskLlRnAaRVREDe4v
         ORabrmN9O+CpuZzqVu95oWn0hDdKZC3acPn0Qucpdw5Mn4H+NU1fAqFpRWc5B8SYTq5f
         lnGCnt/USUiatzmXy093ItWwmGVFRWlOWTp4v7igd5B4hl8enlAg/h8zfy5SmbR3D76p
         Gc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yVALIvcLtThshk58K33hTE465MMzK7CEk9eHPSVZGGA=;
        b=miSotQnDvpylQKJVX+tFmPQsXttTIJ2UTHEIEjvAqHiQYaeeLBJbIOBl2DV9GxxD3N
         cmq2QW7zU+2Cuhg3xuJsWAIJVHn3GHvm7gDqGFbRe4akO81iCVl0305h7dJSN24PeRga
         o9fa4lGv5ne4c6g+m4KmcmUQ5970Itb8TO9Xr/SeKDs2/8bXxJesQ6cuFcUN9LM1YFVN
         s9I8YhCfWvm9GvXpDKbigXuW1poWjemXrqmlQG5t1/FaxvT/VY+h4zZlzjrC2BfgjAC2
         gZdYk1BgOjlQIXbVkSo7Pab7Zs663XcziY6TIDRuZqf2TvvWfGD5ZZWHqdGALh/utDjm
         CYXg==
X-Gm-Message-State: APjAAAVRWN6BAglquQL5JMxfIJZPGOGI4o86Ln1UCP+clGLxVXgk+R00
        Lf7q5avjsFjeiQs5sxkfrU0=
X-Google-Smtp-Source: APXvYqyyVTp78am29VjOdmaJQiOMfXp/wjLXD4NGZqlvKg/ipn9Kc0vYTDCKFSDn1d5WFfMsFiMmXg==
X-Received: by 2002:a62:1ac8:: with SMTP id a191mr1063657pfa.164.1565056894565;
        Mon, 05 Aug 2019 19:01:34 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id e11sm100723636pfm.35.2019.08.05.19.01.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 19:01:33 -0700 (PDT)
Date:   Mon, 5 Aug 2019 19:01:32 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Lukas Gross <lukasgross@u.northwestern.edu>
Cc:     git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
Message-ID: <20190806020132.GB61803@google.com>
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
 <20190806013030.GA61803@google.com>
 <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(administrivia: please don't top-post)
Lukas Gross wrote:

> I had intended to stage commits but forgot to do so. Git responded
> with a normal commit creation message, so I pushed to the remote to
> begin a CI build. When the build failed for the same reason, I
> realized I had forgotten to stage the changes. An additional line in
> the response to the effect of “Warning: did you mean to amend with no
> changes?” would be very helpful to shorten this feedback loop.

Ah, I see.  You passed --no-edit so you didn't see the usual --dry-run
style output that "git commit" shows.  You forgot to run "git add"
before amending, and this is what you'd like commit to assist you
with.

That said, this is sometimes an operation people perform
intentionally.

Ideas:

* Can the documentation do a better job of steering people away
  from --no-edit?  The hints shown when "git commit --amend" (and
  --no-amend, for that matter) open a text editor tend to be very
  helpful for understanding what is going to happen.  If any
  documentation is leading people to forgo that tool, we should fix
  it.

* Should "git commit --no-edit" say a little more about what it did,
  since it knows that the user didn't get to see the text editor?

* Should we have a special option (e.g. "git commit --amend
  --refresh") for a no-op amend?  That ways, when a user doesn't pass
  that option, it would be more clear that it is a mistake, allowing
  a warning or even an error.

Of these three, the first seems most compelling to me.  Others may
have other ideas.

Thoughts?

Thanks,
Jonathan
