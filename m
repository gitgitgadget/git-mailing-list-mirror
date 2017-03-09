Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C76202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 21:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752717AbdCIVpu (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 16:45:50 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35225 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbdCIVpt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 16:45:49 -0500
Received: by mail-pf0-f177.google.com with SMTP id j5so33451499pfb.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 13:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mPgGJnhxgOz/Ymn4HXwiAzA8L8IVGhcSpdnK7uF9R0M=;
        b=iLZfPwexd8fY/eMJUwbXERXAb2j2+r9+ian2x9C0tdgrN53AyRyLmfZyy8tLc0Aj4I
         Mj5Ktvak72v5jISoo7Wu26T3hD8ZCcoqPfz3Yc0u0QyeOBKHvgcYAuZDNTb5b8U1SBnX
         nw79u8i6G+MtzqxQ9tkV8Xz5ZKqILnplo51/ou2Osy8s1UoH1lzmB6bwZpS3XjpN8fjV
         5AbXA8T7TMjl8uT+W+De9tiG0k0bjT1NQN2GB6LAJPHEKDgUymP2XMeWWypHUXqhCOm1
         edhCBQl6lfJYQlsVQnbZoi0Hmrq9V7c3wzgFkzLj1LHQJYzQzNPFrFwOOjxkKuOMGlaW
         JUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mPgGJnhxgOz/Ymn4HXwiAzA8L8IVGhcSpdnK7uF9R0M=;
        b=Q2kITDh/PjWBnvWc+GIXZxQQivVB8umTVnjKbS0RWE0aDAUtrFVM+Rw1yKWO46iOpU
         1ACmm7jilxaKtc19tamyc4kp8AHp/AuU1BekWZ+PeNqsF1fYysirRzcvIYaBP7oK+nm+
         TvXUxVxIFrJpJU760Y2SpX6atjW+qg12g1ypEmmmWwQdpZHJAgWoTKWABMueHKPY4kxz
         86q251w5wNDBNiiLH8CiMzf2R8t9rhbHz+uJmFcTnNvTt8UzsPu+eWRGDxEdLv94JAfe
         6qgwlG/VI1zgSAmWb/U2HKswQJEgulWsz7qdte1WXhfy/uNW1zmRSCVPMyY2u4c567oe
         0hbA==
X-Gm-Message-State: AMke39nDwC817GXtimJe3TMUujyTNWVcZ1R7ZyhU1nn3lKdOJ1w7o59Dk/2z8/zyfqhZBepp
X-Received: by 10.84.236.70 with SMTP id h6mr20381942pln.173.1489095948242;
        Thu, 09 Mar 2017 13:45:48 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id e70sm14268343pfh.84.2017.03.09.13.45.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 13:45:46 -0800 (PST)
Date:   Thu, 9 Mar 2017 13:45:45 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Aalex Gabi <aalexgabi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Git attributes are read from head branch instead of given branch
 when using git archive
Message-ID: <20170309214545.GA52558@google.com>
References: <CABRdPwCA6UR0kkZ2T8W4OYZ36oBwF9hw+SpJHXDE15CHyFiA8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABRdPwCA6UR0kkZ2T8W4OYZ36oBwF9hw+SpJHXDE15CHyFiA8A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Aalex Gabi wrote:
> Hello,
> 
> git archive --remote="URL" branchname > branchname.tar.gz is not
> reading .gitattributes file from the given branch but from HEAD. More
> specifically export-ignore lines in the target branch are ignored.
> 
> The remote is using git protocol and it's served by Gitlab. I use git
> version 2.11.0.
> 
> Is this a git issue? In that case is this a bug or a known limitation?
> 
> Best regards,
> Aalex Gabi

Could you provide a little more context with the problem you are having?
When you say HEAD are you referring to the server's HEAD?

When testing this locally (with a relative URL) I can't seem to
reproduce what you are describing.  If you could provide a way to
reproduce this I would be able to more easily diagnose the problem.

-- 
Brandon Williams
