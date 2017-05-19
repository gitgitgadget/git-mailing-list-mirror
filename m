Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5072023D
	for <e@80x24.org>; Fri, 19 May 2017 18:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756353AbdESSa7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 14:30:59 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37035 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756172AbdESSa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 14:30:56 -0400
Received: by mail-it0-f51.google.com with SMTP id g126so51489708ith.0;
        Fri, 19 May 2017 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XzAzCg//SlabUDp8mDKfzZHIFxGGyAdHhf+JPQS51Ds=;
        b=KidWy1QhqwGaVUP4MI0Hak3JGR2G1BpDxsdfOBsl3eW4P6xNs9N/LKDoG4gEQmXBiv
         9Qlb5NzuNx+9Bo6RyguBXiUf1VSmPS3naOfug08pW1ZQhA0YU4oNNLgNRI8r/N1hcRp+
         JIJyJek4fZzw9tQ+HO343Bf7p1irHX9iX1gnaBZUn+v/6TV2B8CELDKYt6971677TIDN
         vr4iF4QXqSFAdzXicGlJVtjWTc2IrIK5LWUrYbP8q0DXZsXqqRn2CFaGEfYUFLEWeIQw
         YDXsJHoADk/pRoxjoPjU1YEcXxeuyUg+Txxq93NLeg0/a7kZXoHmncjpwqdYLE9ILg0s
         V43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XzAzCg//SlabUDp8mDKfzZHIFxGGyAdHhf+JPQS51Ds=;
        b=kMGRcQKLJDoVYPBmANjDzCyRSn2j3gYfGNskfKWKG0IhaVP1P9XT7lkPxzi9j3S9SY
         wy47kFntqxsBihmpxJ1cS0j3JswH9HxlUJPQVmzl3B6myhUVbFZ6W7NfTVOgUltvG7ql
         NBCkDZWM0wy1EOBGAZK1tvHACKrbNxK2NDZEvqWxW2WFIx4WxKe3JiIb9yV7uLbCH/QE
         cmz4L9g21OjBotucTUI3Fl1YHf8b1tnSyHm3t7xksJPUsA0g2YcJzQhyT3zb5dyvVl1j
         knNaTQNfSg9ThctEWvjxiLG4fU8nwzGDKY4Aukhedjah95XAHgFp7dUwfESRbEpRsuI5
         +IWA==
X-Gm-Message-State: AODbwcBqUDOKK4JgMQB9oOLi8YXe4XVqulTSFxOvXwUdt0ImVFyG2Dnu
        +x7HXK9Ddmbw3I3X1mcXpdETDDLcEop0
X-Received: by 10.36.108.76 with SMTP id w73mr30176965itb.91.1495218655451;
 Fri, 19 May 2017 11:30:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.204.3 with HTTP; Fri, 19 May 2017 11:30:55 -0700 (PDT)
In-Reply-To: <20170519092202.6b0f9a57@canb.auug.org.au>
References: <20170519092202.6b0f9a57@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2017 11:30:55 -0700
X-Google-Sender-Auth: QmbUTeqOn_m8ZrefhRN-lr2nbYU
Message-ID: <CA+55aFwaxsNZ0ACQkASdDTbSrdcHMJpFPtswK485tEWRBVVYrA@mail.gmail.com>
Subject: Re: git merges of tags
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2017 at 4:23 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Just a reminder that if you are merging Linus' tree (or any tree
> really) via a tag, git was changed some time ago so that merging a tag
> will not do a fast forward (there is a good reason for this - I just
> can't recall it ATM).

The reason is that when you merge a signed tag, git squirrels away t
he signature into the merge commit, so that you can see and verify the
signage later (use "git log --show-signatures" to see the signatures
on the commits).

If you fast-forward, there isn't any new commit to add the signing data to.

> To do the fast forward, try "git merge <tag>^{}" ...

A slightly simpler syntax might be just "tag^0", but yes, the "^{}"
thing peels off any tags.

>   (unfortunately
> doing "git merge --ff <tag>" also does not do a fast forward - it also
> doesn't fail, it unexpectedly just creates a merge commit :-().

"--ff" is the default behavior, and means "allow fast forward", but
note that it is about "allowing", not "forcing".

You can use "--ff-only" to say that you will _only_ accept a
fast-forward, and git will error out  if it needs to create a merge.

                  Linus
