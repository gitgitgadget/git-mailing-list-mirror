Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA06320954
	for <e@80x24.org>; Sun, 26 Nov 2017 01:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbdKZB5j (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 20:57:39 -0500
Received: from p3plsmtpa08-01.prod.phx3.secureserver.net ([173.201.193.102]:42090
        "EHLO p3plsmtpa08-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751832AbdKZB5j (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2017 20:57:39 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with SMTP
        id Im5HeetPQMKYRIm5Keu16P; Sat, 25 Nov 2017 18:50:20 -0700
Date:   Sun, 26 Nov 2017 03:50:15 +0200
From:   Max Kirillov <max@max630.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] http-backend: respect CONTENT_LENGTH as specified by
 rfc3875
Message-ID: <20171126015015.GC26158@jessie.local>
References: <20171123234511.574-1-max@max630.net>
 <xmqqvai0nrv9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvai0nrv9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfBTKAVBPjvIdWm/Oaca3C1Yrz5t0I1wpu520m9lylAaAONCPRgt/njmPy6SfssE75SfexzxA5l8Vf9U+cInO4Ghic4VfjNRFC6IV/vT1iqhdBnC/pFl1
 Tpa0Fso+Pq9gb5h3LsGtt3uGQzmLtEZZmtAviMV9gJfzy7ysyE4Fq/N9jFcKMC2eL+NFtfPoamVArg0VcSQity3DYeEhCc4jEeSZsfXJA3y7nDJziZ921TXL
 JlTaQQQPvHMgts3dno6nk/I5FFZVWqb0FSk6k0gLr0bW3RopWj2/UV9AolME2mbV12BA1P6inNLnHk5e4X0TgoWulCGF7a22JRh1/o2YVUQJEPacT/i0Ywf2
 j2npLywI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 24, 2017 at 02:54:50PM +0900, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
>> I hope I marked it correctly in the trailers.
> 
> It is probably more conventional to do it like so:
> 
>     From: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
>     Date: <original date of Florian's patch series>
> 
>     Signed-off-by: Florian Manschwetus <manschwetus@cs-software-gmbh.de>
>     [mk: fixed trivial build failures and stuff]
>     Signed-off-by: Max Kirillov <max@max630.net>

Thanks. Have done so
