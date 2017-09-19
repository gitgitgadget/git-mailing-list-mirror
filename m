Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C02320A2B
	for <e@80x24.org>; Tue, 19 Sep 2017 16:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbdISQIM (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 12:08:12 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:51342 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdISQIL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 12:08:11 -0400
Received: by mail-pg0-f44.google.com with SMTP id k193so46234pgc.8
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3hAIxjVnCdB4IGvVCsipgXLQh3hmg50tu/tUKIah4Us=;
        b=fg/1PgIvSfxNK6ll160jB8lC94lATbnSLiCkZHRZRvjjL3UgkiuU0vuhWkn/iX2OuR
         17ha+yuBNg1TvUOvMBjYc3U3QAht3EYs4a6gdp8jZAten6Q2EdOREK2FQNhRV93COcFP
         DWB6fUqR9F/O5lUNLQwuoT6gwXtsLUFkqR0VwivtphwVSaIx+n66QxCjE6yeG/lRfo3y
         4hkoEZYdPdYRHwkCegRmOdKGZxTWfvcpVXMP8K8xR+iWQqyR5MBiq5YMY4wa7GDg36GR
         40ZMJSNtzVbfWQwuifkAHMi8WGiY7yheEMnG9WX9+TRZ6tMrPNlyJnvhSgynZb6xHqJK
         W4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3hAIxjVnCdB4IGvVCsipgXLQh3hmg50tu/tUKIah4Us=;
        b=NzQf8hUwO+6PqlHTitm2rHiq1jbYIcxydfI7HsiDQdDr17yvDRdyTDtdp3L3cHQ3Eo
         y3gNxBOBA/OuxZrXPsupyMZkMqebD+cIhIWWclh/R5RVxfUoMR4vmzXfV1138pHwxXfk
         Z9lOys3Ye41VNPrCCLh3nbvbKpBrclaiECh+ICg41PoyI5SwZ2XMuZyIwVutxh4qLn1E
         Vr61TQnd+QpHyYavopeynmFFdaM5kJRNHeFQwm9UKBbRtpKVq4pjfmzWGO1s8vIk+sjA
         iOj64xK1fZuuNJCn/rjGuQgG0SHm2vFsQ2eoD33MJ1Uz5l8d5D/Aj6gbIE8LnvQfn3I9
         tlpA==
X-Gm-Message-State: AHPjjUjzG9rG7glwbXdybq5A1NqgESEAns7NerWuR7A/tATIthPXcT14
        m2a0S0i2gNOEaxQOwTFKwST2a4SK
X-Google-Smtp-Source: AOwi7QC+7zhC5xbIEfXdViawXXrSLWf59Y9H5j7bCHozMO75pJxHip2ADcpOeTbFMTk/Wyo22/K6uw==
X-Received: by 10.84.235.9 with SMTP id o9mr1728610plk.8.1505837290303;
        Tue, 19 Sep 2017 09:08:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:288c:7217:eb8c:bacc])
        by smtp.gmail.com with ESMTPSA id m15sm3544188pfh.35.2017.09.19.09.08.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 09:08:09 -0700 (PDT)
Date:   Tue, 19 Sep 2017 09:07:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
Message-ID: <20170919160753.GA75068@aiede.mtv.corp.google.com>
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
 <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com>
 <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709151816390.219280@virtualbox>
 <xmqqo9qbx14b.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709152214100.219280@virtualbox>
 <xmqq377nwtbe.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709181637420.219280@virtualbox>
 <xmqqbmm7s9ja.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1709191733450.219280@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1709191733450.219280@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> To relate that, you are using a plain text format that is not well defined
> and not structured, and certainly not machine-readable, for information
> that is crucial for project management.
>
> What you need is a tool to aggregate this information, to help working
> with it, to manage the project, and to be updated automatically. And to
> publish this information continuously, without costing you extra effort.
>
> I understand that you started before GitHub existed, and before GitHub was
> an option, the script-generated What's cooking mail was the best you could
> do.

I think you are subtly (but not directly, for some reason?) advocating
moving project management for the Git project to GitHub Issues.

For what it's worth:

 1. I would be happy to see Git adopt a bug tracker.  As we've
    discussed on the list before, I suspect the only way that this is
    going to happen is if some contributors start using a bug tracker
    and keep up with bugs there, without requiring everyone to use it.
    That is how the Linux Kernel project started using
    bugzilla.kernel.org, for example.

 2. GitHub Issues is one of my least favorite bug trackers, for what
    it's worth.  If some sub-project of Git chooses to use it, then
    that's great and I won't get in their way.  I'm just providing
    this single data point that approximately any other tracker
    (Bugzilla, JIRA, debbugs, patchwork) is something I'd be more
    likely to use.

 3. This advice might feel hopeless, because if the maintainer is not
    involved in the initial pilot, then how does the bug tracker get
    notified when a patch has been accepted?  But fortunately this is
    a problem other people have solved: e.g. most bug trackers have an
    API that can be used to automatically notify the bug when a patch
    with a certain subject line appears on a certain branch.

Thanks and hope that helps,
Jonathan
