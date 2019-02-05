Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0791D1F453
	for <e@80x24.org>; Tue,  5 Feb 2019 20:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfBEUmM (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 15:42:12 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41075 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfBEUmM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 15:42:12 -0500
Received: by mail-wr1-f45.google.com with SMTP id x10so5169047wrs.8
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 12:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kP1YSqIeNztdqnWKbk0fzDvFe7+OhPrHpKkOoawRECY=;
        b=JKOFuZjyQcDSQXvKmVpTcgMJRVQbn+b1Uiya867/HXeD3L03GxorEJRzeU+n9zsUM2
         ISh3UkmMVx3Y2dj5GFI8tQ9j0ZjusGHl8F1gOubMwo8DrBPxOq/N/Yl5AFJzK5y+m/3I
         gU3k5mU48iVsaqGjh+n8nXvmYMzsCqIVxNn/p/Okigb0ZYiI+rNW88rgrA0yk9KYm6+j
         7kK+aDVALXhZfwfkvsmFjbYJ6usJWDusLw2U83tL/s/xl6uXzok+SrEvIe1XNSHXAxrP
         lohh6Yx7ly1v9sW9GnzYEQe8rbRKWU7hJLKAhGuprZqTEFGgjgjO/rdEpsEDjoexWxW3
         9Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kP1YSqIeNztdqnWKbk0fzDvFe7+OhPrHpKkOoawRECY=;
        b=iQtvBDx3LPYALPwkAQYzjV1WestpJaM30tHjurB27TdB/AppiCINyQrVArbhcIaww5
         VCcMSU7nSmt5j56oK8PpzFLnXK5OrugatvpNgKSHomCYEX449/QvRwN9oz9jE9F6XvOy
         SItnzCfyZ2+Ei8Av1GRCZlG9KMiuGrnfwItc9sXyQtbQGE2fHIDYLJR8fYO1XJqpbTkk
         oQ0LKuMlRSRt9is7pkWtVi+ds9owMoM+JBdjH87u2BTFphpysHxlIaMLnXyWwgxj7M2t
         RzUkPY47T9ILEoFaK3nLKgDz3x7cTe012NcHK1luZvK3uJ7EMFweF0Z8R0pD+b3sQ3QN
         0h/g==
X-Gm-Message-State: AHQUAuaRY64jL6ojTGCbHXbDcijFZO8YBujw3vY1zzVtDDA67C/vSX79
        ErMJuSnuyJnDts1xCOma2y4=
X-Google-Smtp-Source: AHgI3IZYrAu86dVSppvtLwcGi8hfAkT/xn3xTQ5tU4NT7L4mBTcQ+mGrQGMa1+MT6remFfdeza0i1Q==
X-Received: by 2002:adf:e38e:: with SMTP id e14mr5414161wrm.142.1549399330759;
        Tue, 05 Feb 2019 12:42:10 -0800 (PST)
Received: from localhost ([109.180.252.133])
        by smtp.gmail.com with ESMTPSA id h10sm22204272wmf.44.2019.02.05.12.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 12:42:09 -0800 (PST)
Date:   Tue, 5 Feb 2019 20:42:08 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2019, #05; Tue, 29)
Message-ID: <20190205204208.GC6085@hank.intra.tgummerer.com>
References: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
 <20190204211316.GA6085@hank.intra.tgummerer.com>
 <xmqqh8djtf6n.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8djtf6n.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/04, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > There was also some discussion around the naming of the option, but I
> > don't have a strong opinion on that, so I'm happy with keeping the
> > --[no-]overlay option.  I just wanted to bring it up again here in
> > case someone had a very strong opinion, and would prefer it being
> > changed before this goes into 2.21.  (Not sure if I'm too late for the
> > series going to master).
> 
> I do not mind leaving this topic out of 'master' for now, if that
> would help migrate people only once instead of twice.  I think the
> real UI improvement would come with the new pair of commands split
> out of here, "switch-branches" and "restore-files", which will not
> happen within the timeframe of the current cycle anyway.

Agreed, I don't mind having this topic wait a little longer until
"restore-files" actually becomes a thing.  Just keeping it in 'next'
for now sounds good to me.

> In any case, I think it is probably sensible to revert this step.
> Will queue; thanks.
