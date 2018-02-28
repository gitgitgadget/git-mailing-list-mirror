Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49DD41F404
	for <e@80x24.org>; Wed, 28 Feb 2018 05:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeB1FyS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 00:54:18 -0500
Received: from mail.javad.com ([54.86.164.124]:45536 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbeB1FyR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 00:54:17 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 1786C407C5;
        Wed, 28 Feb 2018 05:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519797256;
        bh=E1/5hIi7WpatxMdSvZAp6INcu3j3O+fM5y2nrhG3GPI=; l=1086;
        h=Received:From:To:Subject;
        b=AdTZ/O72IrFywLm/TdaLbH9c+5B53TS4ISD0IpKny+zgEgqbZ71dp0tM6HUUx+aDN
         ki52UTj825uBIWqUO6A4c9oG87KHaMmJd7aCVlevp+/xbi8DxNfB92fFbYrYZYBKDD
         eOz2df8JqPpjQLi2J+Sjzn4CDePwKMSXCyZDKwqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519797256;
        bh=E1/5hIi7WpatxMdSvZAp6INcu3j3O+fM5y2nrhG3GPI=; l=1086;
        h=Received:From:To:Subject;
        b=AdTZ/O72IrFywLm/TdaLbH9c+5B53TS4ISD0IpKny+zgEgqbZ71dp0tM6HUUx+aDN
         ki52UTj825uBIWqUO6A4c9oG87KHaMmJd7aCVlevp+/xbi8DxNfB92fFbYrYZYBKDD
         eOz2df8JqPpjQLi2J+Sjzn4CDePwKMSXCyZDKwqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519797256;
        bh=E1/5hIi7WpatxMdSvZAp6INcu3j3O+fM5y2nrhG3GPI=; l=1086;
        h=Received:From:To:Subject;
        b=AdTZ/O72IrFywLm/TdaLbH9c+5B53TS4ISD0IpKny+zgEgqbZ71dp0tM6HUUx+aDN
         ki52UTj825uBIWqUO6A4c9oG87KHaMmJd7aCVlevp+/xbi8DxNfB92fFbYrYZYBKDD
         eOz2df8JqPpjQLi2J+Sjzn4CDePwKMSXCyZDKwqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519797256;
        bh=E1/5hIi7WpatxMdSvZAp6INcu3j3O+fM5y2nrhG3GPI=; l=1086;
        h=Received:From:To:Subject;
        b=AdTZ/O72IrFywLm/TdaLbH9c+5B53TS4ISD0IpKny+zgEgqbZ71dp0tM6HUUx+aDN
         ki52UTj825uBIWqUO6A4c9oG87KHaMmJd7aCVlevp+/xbi8DxNfB92fFbYrYZYBKDD
         eOz2df8JqPpjQLi2J+Sjzn4CDePwKMSXCyZDKwqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519797256;
        bh=E1/5hIi7WpatxMdSvZAp6INcu3j3O+fM5y2nrhG3GPI=; l=1086;
        h=Received:From:To:Subject;
        b=AdTZ/O72IrFywLm/TdaLbH9c+5B53TS4ISD0IpKny+zgEgqbZ71dp0tM6HUUx+aDN
         ki52UTj825uBIWqUO6A4c9oG87KHaMmJd7aCVlevp+/xbi8DxNfB92fFbYrYZYBKDD
         eOz2df8JqPpjQLi2J+Sjzn4CDePwKMSXCyZDKwqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519797256;
        bh=E1/5hIi7WpatxMdSvZAp6INcu3j3O+fM5y2nrhG3GPI=; l=1086;
        h=Received:From:To:Subject;
        b=AdTZ/O72IrFywLm/TdaLbH9c+5B53TS4ISD0IpKny+zgEgqbZ71dp0tM6HUUx+aDN
         ki52UTj825uBIWqUO6A4c9oG87KHaMmJd7aCVlevp+/xbi8DxNfB92fFbYrYZYBKDD
         eOz2df8JqPpjQLi2J+Sjzn4CDePwKMSXCyZDKwqk=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1equgw-0001Rl-Bt; Wed, 28 Feb 2018 08:54:14 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87zi3u4pd0.fsf@javad.com>
        <xmqqbmgaqp02.fsf@gitster-ct.c.googlers.com>
        <CA+P7+xpNhEF0=QoR71v5Y=nc39OL4XKX36xXYjP1Kn_+DUCf_Q@mail.gmail.com>
Date:   Wed, 28 Feb 2018 08:54:14 +0300
In-Reply-To: <CA+P7+xpNhEF0=QoR71v5Y=nc39OL4XKX36xXYjP1Kn_+DUCf_Q@mail.gmail.com>
        (Jacob Keller's message of "Tue, 27 Feb 2018 16:30:24 -0800")
Message-ID: <87o9k9mzg9.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Feb 27, 2018 at 10:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> You've already bit this poor thingy to death. Please rather try your
>>> teeth on the proposed Trivial Merge (TM) method.
>>
>> Whatever you do, do *NOT* call any part of your proposal "trivial
>> merge", unless you are actually using the term to mean what Git
>> calls "trivial merge".  The phrase has an established meaning in Git
>> and your attempt to abuse it to mean something entirely different is
>> adding unnecessary hindrance for other people to understand what you
>> want to perform.
>
> Agreed, I think we need better terminology here, the current words for
> (TM) are definitely *not* trivial merges. Same for "angel merge", I
> don't think that term really works well either.

Agreed.

How do we call a merge that introduces no differences on either side of
the merge then? Is there some English for even more trivial than what
Git calls "trivial merge"?

-- Sergey
