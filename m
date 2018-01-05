Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A681F404
	for <e@80x24.org>; Fri,  5 Jan 2018 04:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751556AbeAEEXO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 4 Jan 2018 23:23:14 -0500
Received: from huc12-ckmail02.hiroshima-u.ac.jp ([133.41.12.55]:6519 "HELO
        huc12-ckmail02.hiroshima-u.ac.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751417AbeAEEXN (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Jan 2018 23:23:13 -0500
Received: from huc12-ckmail02.hiroshima-u.ac.jp (localhost [127.0.0.1])
        by dummy.hiroshima-u.ac.jp (Postfix) with ESMTP id BB6EB167028;
        Fri,  5 Jan 2018 13:23:11 +0900 (JST)
Received: from huc12-smtp01.hiroshima-u.ac.jp (huc12-smtp01.hiroshima-u.ac.jp [133.41.12.52])
        by huc12-ckmail02.hiroshima-u.ac.jp (Postfix) with ESMTP id B0DDE9CACA;
        Fri,  5 Jan 2018 13:23:11 +0900 (JST)
Received: from [133.41.177.137] (177-137.cup.hiroshima-u.ac.jp [133.41.177.137])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by huc12-smtp01.hiroshima-u.ac.jp (Postfix) with ESMTPSA id A95BCD326F;
        Fri,  5 Jan 2018 13:23:11 +0900 (JST)
Message-ID: <5A4EFDAD.3050105@hiroshima-u.ac.jp>
Date:   Fri, 05 Jan 2018 13:23:09 +0900
From:   suzuki toshiya <mpsuzuki@hiroshima-u.ac.jp>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Junio C Hamano <gitster@pobox.com>
CC:     =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-archive: accept --owner and --group like GNU tar
References: <20171229140535.10746-1-mpsuzuki@hiroshima-u.ac.jp>        <df39f62558314cf6a9d9df3e23f31dd8@OS2PR01MB1147.jpnprd01.prod.outlook.com>        <5A4B2DA5.907@hiroshima-u.ac.jp>        <59a1fc058278463996ed68c970a5e08a@OS2PR01MB1147.jpnprd01.prod.outlook.com>        <955dae095d504b00b3e1c8a956ba852a@OS2PR01MB1147.jpnprd01.prod.outlook.com>        <5A4D9089.3050209@hiroshima-u.ac.jp>        <f7654cd9-2cd0-0775-3b10-8e3dc1a66dae@web.de> <2112f9c245d64f4e89361df7e9de9374@OS2PR01MB1147.jpnprd01.prod.outlook.com>
In-Reply-To: <2112f9c245d64f4e89361df7e9de9374@OS2PR01MB1147.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-MML: disable
X-TM-AS-Product-Ver: IMSS-7.1.0.1808-8.1.0.1062-23574.003
X-TM-AS-Result: No--4.115-10.0-31-10
X-imss-scan-details: No--4.115-10.0-31-10
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-MatchedRID: jOF9SGbtYWxITndh1lLRAe5i6weAmSDKp/xyq10Na6cbIszkLg3+Mbgh
        G4lQCbFwHqSOV2n35y9YsHa5gpYy3EkkO4zqprNOFzILMNp/GyU0WgowrloYhhUb9+x7ts8848f
        E6PIFskCUYPmtQW7/BS2reMp+L49//gYpKALyUUF0BEBFOTiHn/ltVCXwDZiOFJfW7wEu1kBG/j
        S5qDydr+fOVcxjDhcwOtNfvCUOMblEcGY6dokS79mzcdRxL+xwKrauXd3MZDVfM4b1zazFrc+mP
        PZs1sKD6AeoU376cUznd9TD9GJd86chzhn1wzmsc9/AZQaVBQJ9vz2XN6K5L7lhNU4DERjsERcY
        9up9xxHvxD//XJ0X0ffN81lg33CxSvnbzjzCsL0q4ZcnDVXPuhvD5I5lqJEn
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Junio,

Could you tell me your thought about the way for me to go?
Do you agree with his suggestion; "--uid etc is not the right
solution, --include-untracked is better and generic" ? Or,
should I work "--uid etc" further?

Regards,
mpsuzuki

Junio C Hamano wrote:
> René Scharfe <l.s.r@web.de> writes:
> 
>> I don't know if it's a good idea, but perhaps we don't even need a new
>> option.  We could change how pathspecs of untracked files are handled:
>> Instead of aborting we could include them in the archive.  (Sounds like
>> the simplest possible interface, but may have practical problems.)
> 
> One practical problem is that users who do this
> 
>     $ git archive HEAD Documentation/ | tar tf -
> 
> would be expecting (at least) two different things, depending on the
> situation they are in.
> 
> So at least you'd need an "--include-untracked" option, I guess.
> 

