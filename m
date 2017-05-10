Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0B91FF34
	for <e@80x24.org>; Wed, 10 May 2017 10:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbdEJKns (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 06:43:48 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33807 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbdEJKnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 06:43:47 -0400
Received: by mail-pf0-f174.google.com with SMTP id e64so14083681pfd.1
        for <git@vger.kernel.org>; Wed, 10 May 2017 03:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=R1SF9uCMwo9RwW0YJ9U7lLgMuIBuwH3ORoQ2YQrOZyg=;
        b=LAvOa7i/iPOizLR/7Jj7so/CJdkOERbN6mD4Pvm9+MmKtmUYMmj4TGJIgY2NM5HhwD
         AlY38oSRDr8xS0J+4hWOBEaun3mIeZfNFWUFPGfoxdb/ojzcdO7EJ5iSYu9tPnzZd8VF
         gqv2DUaucreRmc//Q9KWgQ0BSIwkIgLf/G9No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=R1SF9uCMwo9RwW0YJ9U7lLgMuIBuwH3ORoQ2YQrOZyg=;
        b=gQXklmwjq/aXJTbjrNm2rxoA9BEtZviV//uRZU7vPbbHCRpGsqi6F3nve29yYumJQA
         DeTHJVKqkpPoo8AOTSA8JHAnUkUNGzHQZdmmumKW7X07Vml1vsLT5VmUHzZnYBzPOMlv
         jV45hgq3wJukKl35Qkn4HilBb8GTFDBM99AK77xK+M76q7q331k/wwOBTajhhOXCRKmZ
         57iVWVs5bweDIFwuD+pW0Fp6FT+JjMUYtoIoKfqHmZgENVUnH/8reQCOEUMw/p14RezC
         3STl5XIF0P8spkVsVeblJb2qnAJK6x1sJTlqjbrEsD9Btbrqtr1r+WJ/OVNOO3PjW0Ln
         0w3g==
X-Gm-Message-State: AODbwcBTG4br2oCQE8PapntdqmjYof8uAAPP1ehYSzYgWnKZy4AZBkz4
        CA/ugkDrqsFyajQXWGxdGg==
X-Received: by 10.84.216.77 with SMTP id f13mr7105020plj.130.1494413026548;
        Wed, 10 May 2017 03:43:46 -0700 (PDT)
Received: from localhost ([122.172.108.155])
        by smtp.gmail.com with ESMTPSA id z125sm4635208pfb.64.2017.05.10.03.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 May 2017 03:43:45 -0700 (PDT)
Date:   Wed, 10 May 2017 16:13:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [Query] Override sendemail.tocmd
Message-ID: <20170510104343.GE17481@vireshk-i7>
References: <CAKohpok0=0__AcNZAfziTMYVDhGka3o0hzEN6HHZc=YUr7hWYQ@mail.gmail.com>
 <CACBZZX4pz26SCZBbivDneRX6hRPxpuPHXpOQKnn1zJL6xWj_Eg@mail.gmail.com>
 <20170510103400.GD17481@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170510103400.GD17481@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10-05-17, 16:04, Viresh Kumar wrote:
> On 10-05-17, 12:18, Ævar Arnfjörð Bjarmason wrote:
> > On Wed, May 10, 2017 at 9:23 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > Hi,
> > >
> > > I have a use case and wanted help from you guys..
> > >
> > > I have set the sendemail.tocmd option in my kernel's .git/config
> > > file and that works very well. But sometimes I want to avoid that
> > > (for example sending the patch to someone without the list and
> > > maintainers).
> > >
> > > The suppress-cc=all option works quite well to avoid almost
> > > everything (including running --cc-cmd), but it doesn't suppress
> > > --to-cmd.
> > >
> > > Are there any specific reasons why it is being done that way?
> > >
> > > Currently I need to go edit my .git/config file and remove tocmd
> > > before sending any such patches and it sucks :)
> > 
> > Does something like this work:
> > 
> >     git -c sendemail.tocmd=/bin/false send-email ...
> > 
> > ?
> 
> That failed. I tried with 2.12 version first and then on the next branch with
> version: 2.13.0.303.g4ebf3021692d
> 
> $ git -c sendemail.tocmd=/bin/false send-email --to vingu 0001-abc.patch
> 0001-abc.patch
> (mbox) Adding cc: Viresh Kumar <viresh.kumar@linaro.org> from line 'From: Viresh Kumar <viresh.kumar@linaro.org>'
> (body) Adding cc: Viresh Kumar <viresh.kumar@linaro.org> from line 'Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>'
> (to-cmd) failed to close pipe to '/bin/false' at /usr/libexec/git-core/git-send-email line 1687.

And even if this worked, I believe that the right solution would be to fix
suppress-cc to include tocmd also. That's the whole purpose of suppress-cc
option.

-- 
viresh
