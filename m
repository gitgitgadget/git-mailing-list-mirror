Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B0451FAFC
	for <e@80x24.org>; Sat,  4 Feb 2017 06:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753809AbdBDGX4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 01:23:56 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35999 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753800AbdBDGXz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 01:23:55 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so2997151pfo.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 22:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G83n9oqbhLQqBhILjBoIz36k+BaI1Y3PSpZkzzcjCMo=;
        b=H/3UnsM0wwvVL/oZPSNFv/lHFtcD5YZ+6uYWcOiK0GLQvMMtelO5yINwD0iYaBxk6g
         hmlXVhtMnZo3ZHtmRx9J9bmDAXkKZgh1iOTX29FiWGC0SobaO+O6AVAD5IThW7eADqpk
         co2lDCzAw67O72CvhcKkqvMP4qXm6EXIWjxQXDBtPiJ1KIl7zW22ul4T8c0y3W1xAiAJ
         hqPP4auNZ0PERG2NGtWYkiPN5eujKigDl70MMjLTsl5GTIS7UBiHp4mXxvNof10xsEdM
         Nx7dhll/em2Uuqt3njnglMaQCMLHSvcYFRXoKShnqSzUwyLWQ0FORTsFlOPqD487YLm7
         40ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G83n9oqbhLQqBhILjBoIz36k+BaI1Y3PSpZkzzcjCMo=;
        b=B3hjvwb8T8l+GRIOqVsZP4QKsqoq8yijzcS1NgWSQKkiHu1mbd/BkklrrX9HB2H43o
         QfXlOHB8t0D2agaw5kNHOS2RWy9Iwta7TsutH1zt1X4+NmOiIZKmXGdgFizFWHgBwLkE
         Q8di6+9KK22Z7Z2wCBLXy03DbmNCpSUfRIkatXBxeNqLV3ejqm40Eel5UrtuavaIWL6k
         ssoLVAOGTyczqZG/Ye3XJ7xnCL1cit19P9joZgYg8LIUcQpJuWXrhXNNJtUvcZCj7Lw5
         K6igbr/pODGB+qlUVXijCXPDNXA5etbjt6ALrROB04LSq5gWKZj7Hu3iI0rS8jnlPx2E
         J1mg==
X-Gm-Message-State: AIkVDXJt3RXSWTUPGJtgevbGOZmYO1pd0C8hK3SminrB+sp/9lJ7Fq2QtJda1uaoHIsvWg==
X-Received: by 10.98.30.4 with SMTP id e4mr991280pfe.19.1486189434562;
        Fri, 03 Feb 2017 22:23:54 -0800 (PST)
Received: from arch-attack.localdomain (c-50-152-192-15.hsd1.ca.comcast.net. [50.152.192.15])
        by smtp.gmail.com with ESMTPSA id q19sm71706517pfl.21.2017.02.03.22.23.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Feb 2017 22:23:53 -0800 (PST)
Date:   Fri, 3 Feb 2017 22:23:51 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] Remove --no-gui option from difftool usage string
Message-ID: <20170204062351.GA11277@arch-attack.localdomain>
References: <20170204025617.GA9221@arch-attack.localdomain>
 <CA+P7+xoXWP=Cuqw3Pa1sFCChiw6wbNTEpvNm3WDuBHQPc_OjnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+P7+xoXWP=Cuqw3Pa1sFCChiw6wbNTEpvNm3WDuBHQPc_OjnA@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2017 at 09:58:09PM -0800, Jacob Keller wrote:
> On Fri, Feb 3, 2017 at 6:56 PM, Denton Liu <liu.denton@gmail.com> wrote:
> > The --no-gui option not documented in the manpage, nor is it actually
> > used in the source code. This change removes it from the usage help
> > that's printed.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  git-difftool.perl | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-difftool.perl b/git-difftool.perl
> > index a5790d03a..657d5622d 100755
> > --- a/git-difftool.perl
> > +++ b/git-difftool.perl
> > @@ -29,8 +29,8 @@ sub usage
> >         print << 'USAGE';
> >  usage: git difftool [-t|--tool=<tool>] [--tool-help]
> >                      [-x|--extcmd=<cmd>]
> > -                    [-g|--gui] [--no-gui]
> > -                    [--prompt] [-y|--no-prompt]
> > +                    [-g|--gui] [--prompt]
> > +                    [-y|--no-prompt]
> >                      [-d|--dir-diff]
> >                      ['git diff' options]
> >  USAGE
> > --
> > 2.11.0
> >
> 
> Aren't "--no-foo" options automatically created for booleans when
> using our option parsing code?
> 
> Thanks,
> Jake

Sorry, I guess I didn't notice that. Would it make sense to document it
in the manpage then?

--
Denton Liu
