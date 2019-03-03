Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13526202AA
	for <e@80x24.org>; Sun,  3 Mar 2019 16:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfCCQTu (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 11:19:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50946 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfCCQTt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 11:19:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id x7so2372895wmj.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/PVRShG2JgGrEgRJR5wGitd3McX6YAP4K/Q1DKGHTVM=;
        b=iNaloXcCc6+9YBGx2HMSR8LAHSFJco8jbiWud0wNGqchA10FoZsQZMmOVR8PyfKfMd
         Gt5Au4kqHTm0iBlPh/iv9Z8P16x8G2aK+N6hoobakJw6LlLsx8PFvFgwdbtUbx9rrmr9
         /PRf3EX9/XUpVSYTIwZv/O6MtbtYW4tzpHvMjTt52y6YhkH2vnkuQAapYtssAWyMExr0
         mNDXp12a6MWK2K+5NIV+aC5eksLAtJ/fx0BSIA/ZQAiUhl6cqMZ13G4m6TUw6z4nbf2J
         Bif7sjrrVuDbktN0W+Egw9Z7iTUbFMSbONm4u5NLfefUbOl36QEWyz3bZDO44JAkJKaj
         TToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/PVRShG2JgGrEgRJR5wGitd3McX6YAP4K/Q1DKGHTVM=;
        b=pd6xBpcLiCJT9NL1wrXUTFDSigYYtrKsnNaycaesa4Uhq8V0VnSrU2cP+BLm8gRSvU
         AQCxtKIaDTcxxyIha8XgVQuNGYZSaIuUS7Aa0kYz7VHRKN6nruVmiQ7NCvZFhrQJNbUK
         38JuVSOngprD+b7N9kAF6NQAeK1IBy64s5ChLowSrPSy1TOWHec8+itk32voIZBtF3P1
         tVkVqYcqk3CoPq9e/W/CEQW0glGw6+QwlqlcsArunn2zHcDQs98ItJGEzpVcHnSzN+IG
         gZhpqRhjVofE+O/TsPG1cjzWo6AoEMzPbu4z75sE4Ekv6rfLHXRw9XyLir4IQon18e2s
         05lQ==
X-Gm-Message-State: AHQUAuYXwcySMinm5btT2B9JAzVd/F813XYlUsk0lxJTW2U3GYHtqlZN
        Gqm1XfwKsYMpMmlKWk5GnFs=
X-Google-Smtp-Source: AHgI3Ibqq0LeWqBTMRMKL3cpZxxICsFjZbeVwgTisUzAqHKrYjpR8b64/+s2onjR7s09N42odCRDsg==
X-Received: by 2002:a1c:a004:: with SMTP id j4mr8379372wme.143.1551629987889;
        Sun, 03 Mar 2019 08:19:47 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id n189sm3977619wmb.28.2019.03.03.08.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 08:19:46 -0800 (PST)
Date:   Sun, 3 Mar 2019 16:19:46 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        christian.couder@gmail.com, git@vger.kernel.org
Subject: Re: Clearing logic
Message-ID: <20190303161946.GX6085@hank.intra.tgummerer.com>
References: <xmqqo96syte0.fsf@gitster-ct.c.googlers.com>
 <20190303140709.5561-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303140709.5561-1-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Rohit Ashiwal wrote:
> On 2019-03-03 13:33 UTC Junio C Hamano <gitster@pobox.com> wrote:
> 
> > test -s <path> makes sure <path> is file; if it is not a file, then
> > it won't yield true.
> 
> > On 2019-03-03 13:20 UTC Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
> > > test_path_is_file "$1" &&
> > > 	if ! test -s "$1"
> 
> According to the conditional if the path is not a file then we will get
> the error "file does not exist" and then we will shortcircuit without checking
> the second conditional, on the other hand, if path is a file then we will
> again check if it has a size greater than zero, then error will be different
> (if any).

I do agree that the better error message is probably worth the
additional 'test_path_is_file' before the 'test -s'.  Although it may
be better to only make that distinction in the 'if' (and then maybe
just using 'test -f', which would explain better why we have an
additional call.

Either way it would be nice to describe that reasoning in the commit
message, as it's not 100% clear from the code what is going on here,
which also lead to Junio's question.

> Regards
> Rohit
> 
