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
	by dcvr.yhbt.net (Postfix) with ESMTP id ECBB81F404
	for <e@80x24.org>; Wed, 28 Feb 2018 04:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeB1Exk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 23:53:40 -0500
Received: from mail.javad.com ([54.86.164.124]:53144 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbeB1Exj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 23:53:39 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 0A6003E898;
        Wed, 28 Feb 2018 04:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519793618;
        bh=/hqnhDfpklOP9jzy7uRj6pzEvwZ/NxqAOamAuK+2yqA=; l=649;
        h=Received:From:To:Subject;
        b=OpbK1ibJRlik7tJ0jMw0vPKxDpvedBRMIeeHK7ikkVAZ+pWTRdu8er9E3iCaqDZjA
         VlLKZqQVbMu4TfCXMcPYzycTF+UJicBie6SFHNmGYqoqsnmgG4FMQQ36HxDGDC6rZH
         XqyymmyR7DYiofgYPs5ds6KU4eQSfdjCGeTGicKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519793618;
        bh=/hqnhDfpklOP9jzy7uRj6pzEvwZ/NxqAOamAuK+2yqA=; l=649;
        h=Received:From:To:Subject;
        b=OpbK1ibJRlik7tJ0jMw0vPKxDpvedBRMIeeHK7ikkVAZ+pWTRdu8er9E3iCaqDZjA
         VlLKZqQVbMu4TfCXMcPYzycTF+UJicBie6SFHNmGYqoqsnmgG4FMQQ36HxDGDC6rZH
         XqyymmyR7DYiofgYPs5ds6KU4eQSfdjCGeTGicKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519793618;
        bh=/hqnhDfpklOP9jzy7uRj6pzEvwZ/NxqAOamAuK+2yqA=; l=649;
        h=Received:From:To:Subject;
        b=OpbK1ibJRlik7tJ0jMw0vPKxDpvedBRMIeeHK7ikkVAZ+pWTRdu8er9E3iCaqDZjA
         VlLKZqQVbMu4TfCXMcPYzycTF+UJicBie6SFHNmGYqoqsnmgG4FMQQ36HxDGDC6rZH
         XqyymmyR7DYiofgYPs5ds6KU4eQSfdjCGeTGicKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519793618;
        bh=/hqnhDfpklOP9jzy7uRj6pzEvwZ/NxqAOamAuK+2yqA=; l=649;
        h=Received:From:To:Subject;
        b=OpbK1ibJRlik7tJ0jMw0vPKxDpvedBRMIeeHK7ikkVAZ+pWTRdu8er9E3iCaqDZjA
         VlLKZqQVbMu4TfCXMcPYzycTF+UJicBie6SFHNmGYqoqsnmgG4FMQQ36HxDGDC6rZH
         XqyymmyR7DYiofgYPs5ds6KU4eQSfdjCGeTGicKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519793618;
        bh=/hqnhDfpklOP9jzy7uRj6pzEvwZ/NxqAOamAuK+2yqA=; l=649;
        h=Received:From:To:Subject;
        b=OpbK1ibJRlik7tJ0jMw0vPKxDpvedBRMIeeHK7ikkVAZ+pWTRdu8er9E3iCaqDZjA
         VlLKZqQVbMu4TfCXMcPYzycTF+UJicBie6SFHNmGYqoqsnmgG4FMQQ36HxDGDC6rZH
         XqyymmyR7DYiofgYPs5ds6KU4eQSfdjCGeTGicKo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519793618;
        bh=/hqnhDfpklOP9jzy7uRj6pzEvwZ/NxqAOamAuK+2yqA=; l=649;
        h=Received:From:To:Subject;
        b=OpbK1ibJRlik7tJ0jMw0vPKxDpvedBRMIeeHK7ikkVAZ+pWTRdu8er9E3iCaqDZjA
         VlLKZqQVbMu4TfCXMcPYzycTF+UJicBie6SFHNmGYqoqsnmgG4FMQQ36HxDGDC6rZH
         XqyymmyR7DYiofgYPs5ds6KU4eQSfdjCGeTGicKo=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1eqtkF-0001MP-Vp; Wed, 28 Feb 2018 07:53:36 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87zi3u4pd0.fsf@javad.com>
        <xmqqbmgaqp02.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 28 Feb 2018 07:53:35 +0300
In-Reply-To: <xmqqbmgaqp02.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 27 Feb 2018 10:14:05 -0800")
Message-ID: <87lgfdogts.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> You've already bit this poor thingy to death. Please rather try your
>> teeth on the proposed Trivial Merge (TM) method.
>
> Whatever you do, do *NOT* call any part of your proposal "trivial
> merge", unless you are actually using the term to mean what Git
> calls "trivial merge".  The phrase has an established meaning in Git
> and your attempt to abuse it to mean something entirely different is
> adding unnecessary hindrance for other people to understand what you
> want to perform.

Yeah, got it. It's confusing indeed.

-- Sergey





