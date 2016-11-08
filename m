Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE262022A
	for <e@80x24.org>; Tue,  8 Nov 2016 19:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753200AbcKHT1o (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 14:27:44 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33342 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbcKHT1n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 14:27:43 -0500
Received: by mail-qk0-f170.google.com with SMTP id x190so227932342qkb.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 11:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YLoHzIDNkHrx+53jJ5U40Pqqh4usX3qIN9206szzOrg=;
        b=CZ4nNJ1HR6eRr3GIWE1cSINMlvXCR0yiwwUyw64d4UoaDOC3xtYtqbIZ4bR24TJ4u5
         hJCtlhIfFwKvZGqVxNCD/El96z0dDT1Bxcy9mgkz4sOfIZa0+FxJKploB1hODfaxMutr
         w/GiQDHqRIaVXwanZrJDnzGGx/n69f5wkWXvM1vGbSbWDvOTN1S8k4/EGkCPqKpY4WnM
         GTNPjndDNBGEqfLUZycTGdu9l5eWgj/DG0zgTri9YYKGX7UgjQPMGoTCoYgXADdMQ+v4
         6NQ9abjGUku3p9zU+7gz844/GZRJQy0tS+n6cbYU7mme2lC17JyExKi5xkyfx2TTcee5
         G2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YLoHzIDNkHrx+53jJ5U40Pqqh4usX3qIN9206szzOrg=;
        b=bVUqyQ7q0Hs80ubOUE+Y2jazsf8D45xO6V+6CsZGg0W58dwSd5nwcFIElcrCCEI6Cs
         BqevoGixAzG1XSY4dKtBoapvkbmr+Sz58hTeBFC3GM0bNM05OpMQv6aYhELSPSq3FmVu
         JzSIvLBodtOBAP2dfukzABM/woy8QlE7rqPoGuwnX0SbnMU7Au+1paI4U2S/wPq7/KgZ
         imf+qXaoPGq5CPc8wqehBMYZ00SkG9yBuhmp9Bm7czUiaiMfO3e1pajkn03YSs0TCI9Q
         dENHjv+aqkuiSOOgjfxxDVOmYqdFolNx8Ma8k3lRwttMYJOZGRLI11DncxnZhBMqfmvQ
         6lfQ==
X-Gm-Message-State: ABUngvdSy2l0sv1QR/RdK+mlF+Y4/HX6be5+fZ3DViZ8RJNLLT1bQ+kxu25hm6AGEVeyCTx/wEKAoNIPVzaZGdsg
X-Received: by 10.55.36.149 with SMTP id k21mr9962674qkk.252.1478633262499;
 Tue, 08 Nov 2016 11:27:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.34.175 with HTTP; Tue, 8 Nov 2016 11:27:41 -0800 (PST)
In-Reply-To: <20161108053333.jta7bmqsyvy2ijoh@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203417.izcgwt4yz3yspdnm@sigill.intra.peff.net> <CAGyf7-HWAMF8S+Bw3wcwJCS1Subc28KHjpSCc1__0qn-GSMyvA@mail.gmail.com>
 <20161108003034.apydvv3bav3s7ehq@sigill.intra.peff.net> <CAGyf7-FYvUgvOZm0xvFAJx=8hSc4ji=YQ5dUm3B1unU_WOcjeQ@mail.gmail.com>
 <20161108053333.jta7bmqsyvy2ijoh@sigill.intra.peff.net>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 8 Nov 2016 11:27:41 -0800
Message-ID: <CAGyf7-HVUN-kHhmccoYUVVDE_xJt1UsiE8bxZiADsW5GFGr+OA@mail.gmail.com>
Subject: Re: [PATCH 07/18] link_alt_odb_entry: handle normalize_path errors
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
>> Is there anything I can do to help? I'm happy to test out changes.
>
> The patch at the end of his mail obviously passes the newly-added tests
> for me, but please confirm that it fixes your test suite.
>
> I gather your suite is about noticing behavior changes between different
> versions. For cases where we know there is an obvious right behavior, it
> would be nice if you could contribute them as patches to git's test
> suite. This case was overlooked because there was no test coverage at
> all.
>
> Barring that, running your suite and giving easily-reproducible problem
> reports is valuable. The earlier the better. So I am happy to see this
> on -rc0, and not on the final release. Periodically running it on
> "master" during the development cycle would have caught it even sooner.

I've applied your patch to the tip of the 2.11.0-rc0 tag (just to make
sure I don't accidentally pick up anything else on master; I'll test
that separately) and my full test suite passes without issue.

I'm going to investigate whether I can setup a version of this build
that runs "periodically" (I'm not sure what that period will be)
against git/git master. I've got a lot of the infrastructure in place,
but I'm going to need to automate a few things to make it really
viable.

As for contributing extensions to the test suite, that's a good idea.
I need to fast track getting a development environment setup.
