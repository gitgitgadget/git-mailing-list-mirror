Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C3820248
	for <e@80x24.org>; Wed, 27 Mar 2019 20:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfC0UbQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 16:31:16 -0400
Received: from n1nlsmtp01.shr.prod.ams1.secureserver.net ([188.121.43.201]:51670
        "EHLO n1nlsmtp01.shr.prod.ams1.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbfC0UbQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Mar 2019 16:31:16 -0400
Received: from n3plvcpnl110358.prod.ams3.secureserver.net ([160.153.140.31])
        by : HOSTING RELAY : with ESMTP
        id 9FBehwArOqBN89FBehvFnd; Wed, 27 Mar 2019 13:30:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m-mooga.com
        ; s=default; h=Content-transfer-encoding:Content-type:Mime-version:
        In-Reply-To:References:Message-ID:CC:To:From:Subject:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FJqfnE/rk7RsbfacT5hcYCLEXIxb45kYphSFlSeAg54=; b=YnKrocaMz6ytVvlnVbbYfszoFD
        1UvWF8KCyMoeRa8nluSZSU/WlRpGPXFA0eRidKMVC4MaMOXkGPYQNnQoYWQMqhqv2h0okrokevi+I
        vCOob+lybWFxRQbena8Fb/5f16zkyRbqYBrxn3TjZcMclEOBytLyVlFZplWCou0HNR+ag6LjifoQb
        blAVAu/L8aEdTLzJLGELIb3Kk0md88Dv6NEOFkEHAI81xMwok/u8iMBfC0spQCdxdK2g+D9p7r3aW
        4j7rFjubqBedhzmlfWbdRcbWQhqvP/JzNSMJZ6XspZvg8f7e8IqQzi5xLCYDYJFijJ2sNNsmHrUxi
        TQQCmLMQ==;
Received: from ip5f5be6e2.dynamic.kabel-deutschland.de ([95.91.230.226]:37244 helo=[192.168.178.31])
        by n3plvcpnl110358.prod.ams3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <contact@m-mooga.com>)
        id 1h9FBe-005WxV-9g; Wed, 27 Mar 2019 13:30:14 -0700
User-Agent: Microsoft-MacOutlook/10.17.0.190309
Date:   Wed, 27 Mar 2019 21:29:54 +0100
Subject: Re: [GSoC][PATCH] microporject test_path_is_*
From:   Mooga <contact@m-mooga.com>
To:     Elijah Newren <newren@gmail.com>
CC:     <git@vger.kernel.org>
Message-ID: <BF34A383-7714-40CC-B5EF-4FD20E7AC839@m-mooga.com>
Thread-Topic: [GSoC][PATCH] microporject test_path_is_*
References: <1A5DE2FC-7D94-4785-A915-EA2A71C6C377@m-mooga.com>
 <CABPp-BE9vNhnN6XdcxnePnXkek0bNogAiA_cKJqZ1-ct=QA2pw@mail.gmail.com>
In-Reply-To: <CABPp-BE9vNhnN6XdcxnePnXkek0bNogAiA_cKJqZ1-ct=QA2pw@mail.gmail.com>
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - n3plvcpnl110358.prod.ams3.secureserver.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m-mooga.com
X-Get-Message-Sender-Via: n3plvcpnl110358.prod.ams3.secureserver.net: authenticated_id: contact@m-mooga.com
X-Authenticated-Sender: n3plvcpnl110358.prod.ams3.secureserver.net: contact@m-mooga.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CMAE-Envelope: MS4wfJlU7X6EXl4BBFcuLELGmMqR6RiTKTGAbzhCzPy5Xgpcq29dmcdRjstSct/T/7dB8fzmtpuN+td68YmbQzQBo9eEL89oxOD98s6pWjRxP1HqW96ZMUA3
 l6q3UIBcedD7rTYu3l+Tufn1zX81I+NZv0oxy380LFdE+2sdisr5e6wSrBGeozwAOQFcNqxf6bx4rhXxLKtxuzuAaIXzLJweu3U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eliah,=20
thanks for the advice, but still after I read the  SubmittingPatches , and =
see around the Submitting patches process still confussing for me , there's =
a better way  for explanation as an example =20


Regards

=EF=BB=BFOn 27.03.19, 18:06, "Elijah Newren" <git-owner@vger.kernel.org on behalf=
 of newren@gmail.com> wrote:

    Hi Mooga,
   =20
    On Wed, Mar 27, 2019 at 5:27 AM Mooga <contact@m-mooga.com> wrote:
    >
    >
    > So for example  that is git diff
    >
    > diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
    > index 286bba35d8..fc82965a0f 100755
    > --- a/t/t2400-worktree-add.sh
    > +++ b/t/t2400-worktree-add.sh
    > @@ -66,7 +66,7 @@ test_expect_success '"add" worktree' '
    > test_expect_success '"add" worktree with lock' '
    >         git rev-parse HEAD >expect &&
    >         git worktree add --detach --lock here-with-lock master &&
    > -       test -f .git/worktrees/here-with-lock/locked
    > +       test_path_is_file .git/worktrees/here-with-lock/locked
    >
    > I would like to hear feedback if I should commit
   =20
    As you noticed from the other thread, there are folks who are now
    unsure whether this microproject suggestion is a good idea anymore.
    Personally, I like the test_path_is_* slightly better, but the real
    issue is that we didn't have that discussion before starting the GSoC
    process and putting it up as a suggestion on the microprojects page.
    I think the main purpose is getting people familiar with creating and
    submitting patches, so I'd go ahead and make this change as well as
    others needed in that file and submit it.  Maybe the patch doesn't get
    applied but if you've created a correct commit and submitted it as a
    patch to the mailing list, I'd still count it as a successful
    microproject.
   =20


