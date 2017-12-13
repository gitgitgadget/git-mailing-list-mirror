Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9890F1F406
	for <e@80x24.org>; Wed, 13 Dec 2017 05:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbdLMFqc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 13 Dec 2017 00:46:32 -0500
Received: from aibo.runbox.com ([91.220.196.211]:49090 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbdLMFqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 00:46:31 -0500
Received: from [10.9.9.212] (helo=mailfront12.runbox.com)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <dwheeler@dwheeler.com>)
        id 1eOzsE-0002xZ-5p; Wed, 13 Dec 2017 06:46:30 +0100
Received: from pool-100-36-125-105.washdc.fios.verizon.net ([100.36.125.105] helo=[192.168.1.151])
        by mailfront12.runbox.com with esmtpsa  (uid:258406 )  (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        id 1eOzs7-00056m-Iy; Wed, 13 Dec 2017 06:46:23 +0100
Date:   Wed, 13 Dec 2017 00:46:12 -0500
In-Reply-To: <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox> <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
To:     Jacob Keller <jacob.keller@gmail.com>
CC:     git <git@vger.kernel.org>
From:   "David A. Wheeler" <dwheeler@dwheeler.com>
Message-ID: <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 13, 2017 12:40:12 AM EST, Jacob Keller <jacob.keller@gmail.com> wrote:
>I know we've used various terms for this concept across a lot of the
>documentation. However, I was under the impression that we most
>explicitly used "index" rather than "staging area".

I think "staging area" is the better term. It focuses on its purpose, and it is also less confusing ("index" and "cache" have other meanings in many of the repos managed by git).


--- David A.Wheeler
