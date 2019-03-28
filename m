Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8709A20248
	for <e@80x24.org>; Thu, 28 Mar 2019 17:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfC1RIz (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 13:08:55 -0400
Received: from n1nlsmtp03.shr.prod.ams1.secureserver.net ([188.121.43.193]:51472
        "EHLO n1nlsmtp03.shr.prod.ams1.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbfC1RIy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 28 Mar 2019 13:08:54 -0400
Received: from n3plvcpnl110358.prod.ams3.secureserver.net ([160.153.140.31])
        by : HOSTING RELAY : with ESMTP
        id 9YVLhMNTvVoev9YVLhSpr9; Thu, 28 Mar 2019 10:07:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=m-mooga.com
        ; s=default; h=Content-transfer-encoding:Content-type:Mime-version:
        In-Reply-To:References:Message-ID:CC:To:From:Subject:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MGFW621Xox6Ti8vwSfZzquJGOlsh/GRoekeR1Q8Px98=; b=0PDDGCMeNLirXgluUXR11dWjTU
        wFexEyA+RNgP+FDUn50zJjNI/BSGN/AvHBDrqGiEN+GMaFsQNFQvvth0Gsdtpv46InMpJQg0/r6Tx
        Valr9LaNwQlZA6pEDZFX1tGXMGMVx56xD+RkuZW4bgcvHL5CtB1K+7c9AThvugJbzSJNpkZsGThy2
        hNDBqtHphkhZcrWMyzWxcGaroZFQF01Qgbo5FiJn2f8C8rAddFAoou2xUWib44GEFU0oZ6ykbnoia
        O3egH+xDgm6YAseYbHKRX8IxSnyWKcl6YQw+vvNIDBAOvEV0gKF2PvXiHpgiyNEOuWmagaA72wswi
        0UVCelAg==;
Received: from p5097f7ce.dip0.t-ipconnect.de ([80.151.247.206]:37295 helo=[192.168.5.47])
        by n3plvcpnl110358.prod.ams3.secureserver.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <contact@m-mooga.com>)
        id 1h9YVK-005zZl-Fw; Thu, 28 Mar 2019 10:07:50 -0700
User-Agent: Microsoft-MacOutlook/10.17.1.190326
Date:   Thu, 28 Mar 2019 18:07:32 +0100
Subject: Re: [GSoC][PATCH] microporject test_path_is_*
From:   Mooga <contact@m-mooga.com>
To:     Elijah Newren <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <1B12FDC7-20CD-4044-AA88-AE9A4E942531@m-mooga.com>
Thread-Topic: [GSoC][PATCH] microporject test_path_is_*
References: <1A5DE2FC-7D94-4785-A915-EA2A71C6C377@m-mooga.com>
 <CABPp-BE9vNhnN6XdcxnePnXkek0bNogAiA_cKJqZ1-ct=QA2pw@mail.gmail.com>
 <BF34A383-7714-40CC-B5EF-4FD20E7AC839@m-mooga.com>
 <CABPp-BGiP8BZwWQMbYhVQjqq8jZx+bbUTfgLaC6ZyukpLErZBw@mail.gmail.com>
In-Reply-To: <CABPp-BGiP8BZwWQMbYhVQjqq8jZx+bbUTfgLaC6ZyukpLErZBw@mail.gmail.com>
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
X-CMAE-Envelope: MS4wfHNOhSgV1f2nQOuDZwGFfJcE0XBRS50CkZH7EGE4THraBFkOqX5NCPqllt30xJNWgwyWJiFBTTKtGk7b6fo3sGrg7Co8AJ9Akhs3UhaFHSgW+iNEnMFB
 DIO5Fh6r8dv+Avbt3zFMHpdYXfpAlnj/y0m3NYBnUFt4KGD/fVKvJU+XBij7TI3Cybz9+mqmVNHrTEDyhYzYHHtTFHdGlMHk91M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have done what is https://gitgitgadget.github.io/ but the problem is
my pull request not being successful even what I have changed is " test_pat=
h_is_dir " in test file "t2400", it returns

PowerShell exited with code '1'.
Publishing build artifacts failed with an error: Not found PathtoPublish: D=
:\a\1\s\t\failed-test-artifacts

I have contributed before in open source community and I just need a quick =
review to continue the proposal

=EF=BB=BFOn 28.03.19, 17:03, "Elijah Newren" <git-owner@vger.kernel.org on behalf=
 of newren@gmail.com> wrote:

    On Wed, Mar 27, 2019 at 1:31 PM Mooga <contact@m-mooga.com> wrote:
    >
    > Hi Eliah,
    > thanks for the advice, but still after I read the  SubmittingPatches =
, and see around the Submitting patches process still confussing for me , th=
ere's a better way  for explanation as an example
    >
    >
    > Regards
   =20
    On this list, please respond to emails interleaved or below the
    original email; we discourage top-posting.
   =20
    What part of the process is confusing?  Without knowing that, we're
    likely to just repeat the document as it stands.  Also, have you taken
    a look at https://gitgitgadget.github.io/ (which is a new thing
    designed to make submitting patches to git.git easier)?
   =20
    Hope that helps,
    Elijah
   =20


