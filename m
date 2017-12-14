Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5E61F404
	for <e@80x24.org>; Thu, 14 Dec 2017 19:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbdLNTGB convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 14 Dec 2017 14:06:01 -0500
Received: from aibo.runbox.com ([91.220.196.211]:47176 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753905AbdLNTGB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 14:06:01 -0500
Received: from [10.9.9.211] (helo=mailfront11.runbox.com)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <dwheeler@dwheeler.com>)
        id 1ePYpR-0002lU-8I; Thu, 14 Dec 2017 20:05:57 +0100
Received: from [198.97.200.97] (helo=[172.16.31.97])
        by mailfront11.runbox.com with esmtpsa  (uid:258406 )  (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        id 1ePYp8-0000Yn-5s; Thu, 14 Dec 2017 20:05:38 +0100
Date:   Thu, 14 Dec 2017 14:05:21 -0500
In-Reply-To: <xmqqk1xpta93.fsf@gitster.mtv.corp.google.com>
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox> <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com> <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com> <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com> <xmqq6099uqq9.fsf@gitster.mtv.corp.google.com> <CAGZ79kZeMVLesunBzW5hhN-snL8fBXdjPgy=Tt8JCDmhDePDZA@mail.gmail.com> <xmqqk1xpta93.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
CC:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        git <git@vger.kernel.org>
From:   "David A. Wheeler" <dwheeler@dwheeler.com>
Message-ID: <6382776C-175A-4E27-8D7C-385FFF167535@dwheeler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 14, 2017 1:50:00 PM EST, Junio C Hamano <gitster@pobox.com> wrote:
>I agree with that.  I do not consider the proposed change "good".

Why is "index" better? It is a confusing name, one that has many other unrelated meanings.  In particular, many projects managed by git also have an index, but few have a staging area.

Also, the phrase "staging area" is already in use, so this is not a new term (e.g., git-staging).


--- David A.Wheeler
