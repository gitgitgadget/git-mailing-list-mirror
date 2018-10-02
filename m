Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C581F453
	for <e@80x24.org>; Tue,  2 Oct 2018 01:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJBIEI (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 04:04:08 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:52236 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeJBIEH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 04:04:07 -0400
Received: by mail-it1-f180.google.com with SMTP id 134-v6so1087194itz.2
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/v+a8RztrSJ/mv0bgDc+KElVeuPufgAs9f6hJ0uENrY=;
        b=F3ZjHKhqHfMFNbBw8lJbeP2aKqFRRAjHWcatWZqmjktQRyJuZfvmV9bPhtk/AZY4MQ
         pSWTjB85J7+xQTWOLDa+W4iyjoSszQV0MNGHvIFBFz+cZ2+ICS6PAJ94Bi70JKAl627J
         nIXGP3OxfWAv6thK36ZIFlJHOIHZ4AabrV1Cn/wm+94h66tNRS/ifxzw/6jp5HeBS4vj
         p7366NKgKhh5toJuEJ4LjmbxzprDq+I4jGMWseRs6WCIsbW9wG+mhixpdNv0O29Q6swz
         5KZEhjZ9ySCfro7ni2FVWvGnv3gnsAtC5NGwWpUmX5vgK/7aZIoyoP+sAfnkIpjYof9q
         RbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/v+a8RztrSJ/mv0bgDc+KElVeuPufgAs9f6hJ0uENrY=;
        b=SzjXQzo/IL7FFILRok4iP9kmXEWNUzWJU7x03zF2cs4/8Qxzy75CpBOYm2hOKLzlgF
         SD3i86ek8TCcNTGoLXzM89m9jLIj3lgh7a8VHhnlXsNu08/eyCTB6ujJ/PZhWHdfU4Yq
         s8J6vfb0FDDLkaB1+Ehnqqdb1fgEz/gxgtt+eDgUhKM1B0Akpp6S2IcyyqOKFVXKWbJ4
         zZ8dky5HD7AO2V8K6qhiUaMuzmKIwSMhotPPQP3lMsj3TFHukVExXat2jtGNwrX3LvO8
         /0hrxGpGubfjk1faCPW+yHmfWxBs7pLFLuxxNDEyXL7KrmkYZ8587EfLPPQf4WJdKWdd
         oQKQ==
X-Gm-Message-State: ABuFfoiY+gnlxMA35nNCqki2WZLSGiz9Asq9f7J/GJjGWEIgTr/a2vPn
        nOpD6Gwm5+CuyUKTnIxi4EWTQ/zFRQ0=
X-Google-Smtp-Source: ACcGV61Pl0v+UuAwHwSbRLVq8ZsyFFZGv2ux9ey2EcHabOAjd1RNwzpyDoReS0SgpsncheMvZZWp+A==
X-Received: by 2002:a63:a745:: with SMTP id w5-v6mr12288615pgo.374.1538443409505;
        Mon, 01 Oct 2018 18:23:29 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id h7-v6sm7414775pfd.35.2018.10.01.18.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:23:27 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 1 Oct 2018 18:23:26 -0700
To:     Stefan Xenos <sxenos@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Evolve
Message-ID: <20181002012326.GA96979@syl>
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Sat, Sep 29, 2018 at 04:00:04PM -0700, Stefan Xenos wrote:
> Hello, List!
>
> I'm interested in porting something like Mercurial's evolve command to
> Git.

Welcome to Git :-). I think that the discussion in this thread is good,
but it's not why I'm replying. I have also wanted a Mercurial feature in
Git, but a different one than yours.

Specifically, I've wanted the 'hg absorb' command. My understanding of
the commands functionality is that it builds a sort of flamegraph-esque
view of the blame, and then cascades downwards parts of a change. I am
sure that I'm not doing the command justice, so I'll defer to [1] where
it is explained in more detail.

The benefit of this command is that it gives you a way to--without
ambiguity--absorb changes into earlier commits, and in fact, the
earliest commit that they make sense to belong to.

This would simplify my workflow greatly when re-rolling patches, as I
often want to rewrite a part of an earlier commit. This is certainly
possible by a number of different `git rebase` invocations (e.g., (1)
create fixup commits, and then re-order them, or (2) mark points in your
history as 'edit', and rewrite them in a detached state, and I'm sure
many more).

I'm curious if you or anyone else has thought about how this might work
in Git.

Thanks,
Taylor

[1]: http://files.lihdd.net/hgabsorb-note.pdf
