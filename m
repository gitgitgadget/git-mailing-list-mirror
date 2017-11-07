Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2694F20281
	for <e@80x24.org>; Tue,  7 Nov 2017 07:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755960AbdKGHqa (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 02:46:30 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:52348 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755341AbdKGHq3 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2017 02:46:29 -0500
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-web-01.w4a.fr)
        by mut-mta1-se01b-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1eByaW-000NKL-Pe; Tue, 07 Nov 2017 08:46:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-01.w4a.fr (Postfix) with ESMTP id 6C6391C1BEC;
        Tue,  7 Nov 2017 08:43:34 +0100 (CET)
Received: from zose-mta-hub-out-web-01.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-01.w4a.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HSl-xBteRPJV; Tue,  7 Nov 2017 08:43:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-01.w4a.fr (Postfix) with ESMTP id C9C4D1C1BFA;
        Tue,  7 Nov 2017 08:43:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-web-01.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-01.w4a.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Kveel0FJwDrS; Tue,  7 Nov 2017 08:43:33 +0100 (CET)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by zose-mta-hub-out-web-01.w4a.fr (Postfix) with ESMTP id B37811C1BEC;
        Tue,  7 Nov 2017 08:43:33 +0100 (CET)
Date:   Tue, 7 Nov 2017 08:46:22 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <158227903.238854.1510040782947.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <xmqqh8ug3xnq.fsf@gitster.mtv.corp.google.com>
References: <87vaix731f.fsf@curie.anarc.at> <q7h9o9opyllo.fsf@orange.lip.ens-lyon.fr> <xmqqh8ug3xnq.fsf@gitster.mtv.corp.google.com>
Subject: Re: future of the mediawiki extension?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.7.6_GA_1776 (ZimbraWebClient - FF56 (Linux)/8.7.6_GA_1776)
Thread-Topic: future of the mediawiki extension?
Thread-Index: lmOjY+cTZrHXf2/auIjWwu4DtC6gcg==
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.14)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5gKJsusU9QE+OeSCPwhYo4vj1g3/PwYZaTCzSym8uE9HzZVFz83oxfZw
 gF51d29GBPAkKzKn8KKR+UkX2hNuFnGGDezsDliyQek9DPjUEYe8t8C9mOBdONdnsxgsk1D2p0xz
 WtzhzyBN1YerwuYDObHmGhzfQQd/+ERpqFpTRpkREjv5y2rnmjelpd3x9GEx5ZnKFuvyAkdfwy1u
 mvgKKTs4fKUuiw0//V1gitb2uGgmfCUjjViAv8TVvNLK7a6WuO0Eidzv7xUmtfqhhPMNuJ6rVfyb
 bVdIi4I10mtMCtuhUAsAEp7he0osUq/5XwU41W6noxJ1R+JPOFQkdVRSeviFcFhO9Ph08zfxywcA
 n5TefPIhX8qVP08ys/I/rdWjsbfvXhSC6LmBRcNHjwXR9mIDuONzMRaL3IMJceeVmuMY+GQ66azi
 oBnt+leQ7P/PJXsa6kI3nyUAc5M3bR7tdxzGLxsTFnT1LoeNMOi6+XYAhFUzRbSScvHdASYFh+p0
 2dqoJxKV5sDANUfywIGK+xoamUdylUIKhf3z2GAHxH7IEyMvAaTgeppldXdmgNheT/zZuKV7bhhI
 SyCeq42d3n97954VyRD0Rk7XKbVteTmNUq1s7ujLAhTBbgjB+bVHnEWs8Qn0wY3unR8jmSQqEyl+
 f0531F3vI5/gHngSB9kHMxpBHvBo9FmImCHhS15U2/Z/iBkIA9EaXBYLrnMiqc3ri9CpzVfoKELd
 zQ6gRENfMfm2hDHkR+8M+G+5sXVO0nL/Y72q89sKGK7s/1oP7NZPYuXyLSgrjLvmIVBvINgsNQs7
 R2TcKDcGsKZkKJWspsOpyKA69LF1Ge2GaGfxmfrOOu3PgMpcSTmRL7Lqr9O/C+ZF275+pg/S1hHt
 JCWUqylLPYnCOJnLyxCukf480PTElXFEC/Z6FtDtg8bDChIkBaBldjaj1+vhII7uaMy67ZK+8i+n
 0KYJ0NLwWPW/Aqv7tBpNIaqvfByt1A4sG74ZSGhKuPazVyS28Zfdod+irA==
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Junio C Hamano" <gitster@pobox.com> wrote:

> I think the plan was to make code drop from time to time at major
> release points of git-multimail, but I do not think we've seen many
> updates recently.

I realize I didn't answer this point. The reason you didn't see any
update recently is just that there haven't been any release and
actually not much development for a while on git-multimail.

I still have a list of "would be nice to have" features, but it seems
users are essentially happy with git-multimail as it is (or at least,
aren't unhappy enough to send patches or discuss interesting issues),
I haven't received any bug report or pull-requests for a long time.

But I still do maintain git-multimail and I will continue updating it
in git.git.

-- 
Matthieu Moy
https://matthieu-moy.fr/
