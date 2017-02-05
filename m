Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A151FAFC
	for <e@80x24.org>; Sun,  5 Feb 2017 10:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbdBEKWv (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 05:22:51 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36114 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751774AbdBEKWu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 05:22:50 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so6299272pgf.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 02:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/kX9W3RXeCDNhYVYq0rcf64P6ePu/0gJCA1wzX5hivQ=;
        b=HxBQfli3hxiUgNv6sG3dvWEdmwMDQF4L/e/thCK8oPlQqFu4oO5m+O38tF7H2GWFc/
         htwOyyVrIx6lgGDaws0yOuMrjSh4480ksqis43RE4B8r+pzBUas3941zYaipJ0tDGAPx
         ZIQhkjydWVwUZQgZ8K5sPiJ66HmJNpdRXfv2stylV36sNfnitPQ1ABsaGKefiGlKAd1L
         1BtvNqU5aAoGYnpEuPtaiQsnDd67F0YJMQYqaOROML/iyEegnJlfNp7SM9NmHg8/MwZa
         9Tgi5Mu5lLjlEr+J9DjYIR0Af6cwMZNDAjWT6o5De9DvCV5Y7uTBfehMLYL2r9g7CxVN
         NNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/kX9W3RXeCDNhYVYq0rcf64P6ePu/0gJCA1wzX5hivQ=;
        b=ZXcczpQznSveR621C7c+LBJ6gyP0RkSegFM8cMb7RaITNbWFWzBJtgvs+jiJ8kipi+
         BdpJTs72t+QXxVMRtt5F82tbhAjfKxr9LX4l2bghPXBddxqz2wxUuRvS3GMAD1LhtBf1
         IDVjDBvzNfkFDxq+YIpWQ3sUCflVu9LlKovxhK9PEAPpjIl9HdSWFeFgprlFx6uOLNRn
         sEcM6QHOml0ByJlNukiEp6bdJZewXj9Xfcjmr+M4ko/yOilP6P1zVIXrfxd+VThp0eYM
         bEnHoIDfpPkQ9FjXbQ6Kmnv77hozrGSidhgtu5+aI8RkiU+IIwVFUSakHE/Q+0F6PxO2
         VcRg==
X-Gm-Message-State: AIkVDXIIJlNR4PGBQOZ9Kr7yzVFHhMxhyMVBW/HMWnoEqE9VxsXWzXDS3WTosWoSsrr1vg==
X-Received: by 10.98.15.143 with SMTP id 15mr7108360pfp.100.1486290169851;
        Sun, 05 Feb 2017 02:22:49 -0800 (PST)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id t6sm81197149pgt.8.2017.02.05.02.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 02:22:48 -0800 (PST)
Date:   Sun, 5 Feb 2017 02:22:46 -0800
From:   David Aguilar <davvid@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] Remove --no-gui option from difftool usage string
Message-ID: <20170205102246.a3wwipbnmqrxxbio@gmail.com>
References: <20170204025617.GA9221@arch-attack.localdomain>
 <CA+P7+xoXWP=Cuqw3Pa1sFCChiw6wbNTEpvNm3WDuBHQPc_OjnA@mail.gmail.com>
 <20170204062351.GA11277@arch-attack.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170204062351.GA11277@arch-attack.localdomain>
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2017 at 10:23:51PM -0800, Denton Liu wrote:
> On Fri, Feb 03, 2017 at 09:58:09PM -0800, Jacob Keller wrote:
> > On Fri, Feb 3, 2017 at 6:56 PM, Denton Liu <liu.denton@gmail.com> wrote:
> > > The --no-gui option not documented in the manpage, nor is it actually
> > > used in the source code. This change removes it from the usage help
> > > that's printed.
> > >
> > > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > > ---
> > >  git-difftool.perl | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/git-difftool.perl b/git-difftool.perl
> > > index a5790d03a..657d5622d 100755
> > > --- a/git-difftool.perl
> > > +++ b/git-difftool.perl
> > > @@ -29,8 +29,8 @@ sub usage
> > >         print << 'USAGE';
> > >  usage: git difftool [-t|--tool=<tool>] [--tool-help]
> > >                      [-x|--extcmd=<cmd>]
> > > -                    [-g|--gui] [--no-gui]
> > > -                    [--prompt] [-y|--no-prompt]
> > > +                    [-g|--gui] [--prompt]
> > > +                    [-y|--no-prompt]
> > >                      [-d|--dir-diff]
> > >                      ['git diff' options]
> > >  USAGE
> > > --
> > > 2.11.0
> > >
> > 
> > Aren't "--no-foo" options automatically created for booleans when
> > using our option parsing code?
> > 
> > Thanks,
> > Jake
> 
> Sorry, I guess I didn't notice that. Would it make sense to document it
> in the manpage then?

The general "--no-*" convention is mentioned in "git help cli",
but the manpages and usage strings across all commands are
inconsistent about mentioning the "--no-*" variants; some do,
some don't.

IMO it probably wouldn't hurt to document --no-gui in the manpage.

cheers,
-- 
David
