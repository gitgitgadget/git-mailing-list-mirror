Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6B220323
	for <e@80x24.org>; Thu, 16 Mar 2017 21:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753724AbdCPVEL convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 16 Mar 2017 17:04:11 -0400
Received: from limerock03.mail.cornell.edu ([128.84.13.243]:46094 "EHLO
        limerock03.mail.cornell.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753647AbdCPVEJ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Mar 2017 17:04:09 -0400
X-CornellRouted: This message has been Routed already.
Received: from exchange.cornell.edu (sf-e2013-01.exchange.cornell.edu [10.22.40.48])
        by limerock03.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v2GL46x9002297
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 17:04:07 -0400
Received: from sf-e2013-07.exchange.cornell.edu (10.22.40.54) by
 sf-e2013-01.exchange.cornell.edu (10.22.40.48) with Microsoft SMTP Server
 (TLS) id 15.0.1210.3; Thu, 16 Mar 2017 17:03:50 -0400
Received: from mail-qk0-f198.google.com (209.85.220.198) by
 exchange.cornell.edu (10.22.40.54) with Microsoft SMTP Server (TLS) id
 15.0.1210.3 via Frontend Transport; Thu, 16 Mar 2017 17:03:50 -0400
Received: by mail-qk0-f198.google.com with SMTP id c85so54167273qkg.0
        for <git@vger.kernel.org>; Thu, 16 Mar 2017 14:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=BCCOrJ5sjordBcm5eUNMBfLqu5dnzwJjsAL1Pw7iHss=;
        b=iTn4KPtjwgQipR2ucpQInbf7AQgRa8/vLFwjayqHBnMAfDnk/X4B8ZKkGjykmvfY5f
         b3TZQghIrAYk/lGQXc7gPJVD2ZtNBPXoygWFocSdrgOqD2OOR+5Eq2YBmtuB1BQQb+0b
         zhSrUaBRUfpTkTAMziCQd/lPFI5gcmKYlQYDww6EomFM1HrVPbbXWCe6blQ160B1MK3C
         lC66GOMkXIotZpFJB/hmbxHJyqWTXVS/40XathjV+2UN+YJOyjA6lOM0SXh9lWRqwZdH
         f39E3fqWg+nEg2tgFYGBfoT0OD6ZJ6QHZZLyLru/hmvs3jh6Cv2FoNJZusS9M5pjyFrd
         u6pw==
X-Gm-Message-State: AFeK/H0tDf/NXipHHSGSIziwyzr7HyOYfM8vP4nJgPKHiCLw4eJqYy6YZuLeQ9rQUii0AhD1VofEiisLEhN+AlVXkB3x8581XoFlTjdoEhZHLHORB8OA6ZeMsI/+NRKMwqimckf79QUeSVB3nsU=
X-Received: by 10.237.50.6 with SMTP id y6mr10387752qtd.115.1489698229936;
        Thu, 16 Mar 2017 14:03:49 -0700 (PDT)
X-Received: by 10.237.50.6 with SMTP id y6mr10387728qtd.115.1489698229691;
        Thu, 16 Mar 2017 14:03:49 -0700 (PDT)
Received: from dhcp-rhodes-560.eduroam.cornell.edu (nat-128-84-124-0-560.cit.cornell.edu. [128.84.126.48])
        by smtp.gmail.com with ESMTPSA id m12sm4476988qtf.25.2017.03.16.14.03.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 14:03:49 -0700 (PDT)
From:   Devin Lehmacher <djl329@cornell.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [GSoC][PATCH v4 4/4] credential-cache: add tests for XDG
 functionality
Message-ID: <4652AE57-B470-4987-BD88-AA8AD491F25F@cornell.edu>
Date:   Thu, 16 Mar 2017 17:03:47 -0400
CC:     <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Devin Lehmacher <lehmacdj@gmail.com>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3259)
Received-SPF: Neutral (sf-e2013-01.exchange.cornell.edu: 209.85.220.198 is
 neither permitted nor denied by domain of djl329@cornell.edu)
X-ORG-HybridRouting: 3dada18cee8f0ba28557c02b4629b43b
X-ORG-RouteOnPrem: False
X-ORG-MsgSource: cmail
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > > +test_expect_success 'credential-cache --socket option overrides default location' '
> > > + test_when_finished "rm -rf \"$HOME\"/dir/" &&
> > > + check approve "cache --socket \"$HOME/dir/socket\"" <<-\EOF &&
> > > + protocol=https
> > > + host=example.com
> > > + username=store-user
> > > + password=store-pass
> > > + EOF
> > > + test -S "$HOME/dir/socket" &&
> > > + git credential-cache exit
> > > +'
>
> This is almost right, except:
>
>   - the "exit" needs to be told which socket to use
>
>   - we should do the "exit" even when the test fails early (so in
>     test_when_finished)
>
>   - the test_when_finished block will interpolate $HOME when setting up
>     the block, which will break if it contains double-quotes or other
>     special characters. It should use \$HOME.
>
>     I suspect the "check" invocation needs to do so as well, though it
>     is even trickier (we shove it into a single-quoted "-c" argument).
>
>     I think you could get by in both cases with relative paths.

Using a relative path won't work since `git credential-cache --socket`
only accepts absolute paths. It shouldn't be too hard to escape the
string though.

-Devin
