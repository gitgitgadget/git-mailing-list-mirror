Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9DF71F453
	for <e@80x24.org>; Thu, 31 Jan 2019 02:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfAaCCi (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 21:02:38 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:34885 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfAaCCi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 21:02:38 -0500
Received: by mail-wr1-f48.google.com with SMTP id 96so1575730wrb.2
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 18:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LSdb/NRHPM559EbfxxOqe26Age3JULIndN9tgeFLP7k=;
        b=WfSLS52lwnlu25iyNYgcnQ5LiDL+uayIuna65XhJRCTaCkIwkBNzWEj6XFI58jhnfo
         Sy5kzH35GNW9Ca6uN2v8G7eH7v9ei4ZSiSKNzJegp+o7vyzsOrlX7Ib4utUH1knB20Ni
         +BaO5r38mnpPAFS060HGlmOprcVSiOJ+h3GCyMmDkt5QQtlEo55zuMHsLB7+hqWdZqZA
         ZNZJ7DQYaYwMa4R1ZYitnc1kNK6Jr11a02AWtseTrQDNDZLW+ghgrghf0m6JVM8MBRwA
         jkOcQZDX41vNyhGQZed72FjdAZS7qd+pkGQ3julDz0i6BGQAIKKhoZASqwOYEUsPvbxT
         xZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LSdb/NRHPM559EbfxxOqe26Age3JULIndN9tgeFLP7k=;
        b=mH0cBU5Eqn1xgwUMhH7F1Q5/32qm2HQnnklMRdze/WUYKO4rGn/xURv8DQq3Zfg5T+
         8jZH1O45sQq7kt2nZ5uK1uRvcOvF8q9p+uF80laT/wXB4os2lYLMCnAGwtEYmmwZq0hs
         MFMMrDlJgklnBcwlgFsTvt4uFVrrAJIPv+U5lCdTVKZKQBcvx8NkKJMvTG/z8b6lhM9d
         IAwlPN0WMYvHtki1PY7I6Jnxo4R28TvZPtCiviTlA3pRSgvCpVkZTrsaQfF/+ynzX46b
         WQsoF2u1WlZNH/BWia0pS4VXFEDRLs+5iRK8NG5i1WkrySnDRwTWJErInXd+uBhsDlfH
         xURw==
X-Gm-Message-State: AJcUukey/8PfghbiheQBhqlrbohZOPbwmBSF0irUqP5VoZQ1KZkfyXpd
        R6hKPKwSRtJHsUd3x0XQtLE=
X-Google-Smtp-Source: ALg8bN4YC6hgCVRNFdoVryPLIIF8mt8YCiBm/ygFbjX19unrpMYSpDGglhFMBMLA2zXpOLsd4FzXTQ==
X-Received: by 2002:adf:9591:: with SMTP id p17mr33641581wrp.224.1548900156692;
        Wed, 30 Jan 2019 18:02:36 -0800 (PST)
Received: from szeder.dev (x4db472ea.dyn.telefonica.de. [77.180.114.234])
        by smtp.gmail.com with ESMTPSA id m4sm1719304wmi.3.2019.01.30.18.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 18:02:35 -0800 (PST)
Date:   Thu, 31 Jan 2019 03:02:33 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: GSoC 2019 (was: Contributor Summit Topics and Logistics)
Message-ID: <20190131020233.GH13764@szeder.dev>
References: <20190122075027.GA29441@sigill.intra.peff.net>
 <20190122082647.GA31608@sigill.intra.peff.net>
 <CAP8UFD3Kt3dreMnfAdLiP2yc47kBLoVYCk-2yDw67OkujVY=Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD3Kt3dreMnfAdLiP2yc47kBLoVYCk-2yDw67OkujVY=Ew@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 10:17:59AM +0100, Christian Couder wrote:
> - microprojects idea for interested students (like
> https://git.github.io/SoC-2018-Microprojects/)

> Suggestions for microprojects or project ideas are welcome! Volunteers
> for mentoring or org admin are welcome too!

I think we should remove most (all?) CI-related microprojects.

  - The first three are about adding static analizers.  Now, while
    adding a new build job to run a static analyzer is easy enough,
    it's also next to useless or even downright harmful in itself.
    Static analyzers are inherently prone to false positives, and
    dealing with those is definitely beyond the scope of a
    microproject.  And adding a static analysis build job that always
    fails because of undealt with false positives, and thus makes the
    whole build failed will just make life harder for those who take
    the effort to look at CI results.

    Last year we had submissions for these micrprojcets, but in the
    end they were not picked up because of this.

  - One project suggest installing CVS, Subversion and Apache in the
    CI environmens to increase test coverage.  Well, Subversion and
    Apache are already installed, and have been for a long time
    (though $GIT_TEST_SVNSERVE is not enabled (don't know why) and one
    test script is skipped because "svn-info test (SVN version: 1.8.8
    not supported)".  That leaves only CVS, which is perhaps too small
    a microproject (perhaps even with old standards; our microprojects
    grew considerably over the years).

  - Finally, the last one is about building a webpage that analyses
    Travis CI test results and identifies flaky tests, and then goes
    on to suggest that "look at the randomly failing tests and try to
    figure out why they fail".  I've got my fair share in fixing flaky
    tests, and IMO doing so is definitely beyond the scope of a
    microproject.

Ok, after suggesting the removal of five microproject ideas, here is a
suggestion for a new one:

  Find a test script that verifies the presence/absence of
  files/directories with 'test -(e|f|d|...)' and replace them with the
  appropriate 'test_path_is_file', 'test_path_is_dir', etc. helper
  functions.

The good thing about this is that there are plenty of those test
scripts :)

