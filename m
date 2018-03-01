Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9401F404
	for <e@80x24.org>; Thu,  1 Mar 2018 05:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966039AbeCAF1H (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 00:27:07 -0500
Received: from mail.javad.com ([54.86.164.124]:40719 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965953AbeCAF1G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 00:27:06 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 1D0613E8C3;
        Thu,  1 Mar 2018 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882025;
        bh=V+S3MzEsNWDhdhfo3XkxB5KoKeTG+Ys9bNGsmvr8v+w=; l=501;
        h=Received:From:To:Subject;
        b=ZPJsijCBmMsh4NQC4OTIBIGiC894QLAXGOhyQRT/TGOoekWg9eJV74339UY7X4ikl
         KnCR/IYsclMrtPAYKXc3dpji2qt4/vK4X6+FkyLsvJujsIPs1MQ/Nhz1ExysVWFJoE
         w7hEf04F0JqGvemHkZk5UtpQPhS5K8qH0AWfILWE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882025;
        bh=V+S3MzEsNWDhdhfo3XkxB5KoKeTG+Ys9bNGsmvr8v+w=; l=501;
        h=Received:From:To:Subject;
        b=ZPJsijCBmMsh4NQC4OTIBIGiC894QLAXGOhyQRT/TGOoekWg9eJV74339UY7X4ikl
         KnCR/IYsclMrtPAYKXc3dpji2qt4/vK4X6+FkyLsvJujsIPs1MQ/Nhz1ExysVWFJoE
         w7hEf04F0JqGvemHkZk5UtpQPhS5K8qH0AWfILWE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882025;
        bh=V+S3MzEsNWDhdhfo3XkxB5KoKeTG+Ys9bNGsmvr8v+w=; l=501;
        h=Received:From:To:Subject;
        b=ZPJsijCBmMsh4NQC4OTIBIGiC894QLAXGOhyQRT/TGOoekWg9eJV74339UY7X4ikl
         KnCR/IYsclMrtPAYKXc3dpji2qt4/vK4X6+FkyLsvJujsIPs1MQ/Nhz1ExysVWFJoE
         w7hEf04F0JqGvemHkZk5UtpQPhS5K8qH0AWfILWE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882025;
        bh=V+S3MzEsNWDhdhfo3XkxB5KoKeTG+Ys9bNGsmvr8v+w=; l=501;
        h=Received:From:To:Subject;
        b=ZPJsijCBmMsh4NQC4OTIBIGiC894QLAXGOhyQRT/TGOoekWg9eJV74339UY7X4ikl
         KnCR/IYsclMrtPAYKXc3dpji2qt4/vK4X6+FkyLsvJujsIPs1MQ/Nhz1ExysVWFJoE
         w7hEf04F0JqGvemHkZk5UtpQPhS5K8qH0AWfILWE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882025;
        bh=V+S3MzEsNWDhdhfo3XkxB5KoKeTG+Ys9bNGsmvr8v+w=; l=501;
        h=Received:From:To:Subject;
        b=ZPJsijCBmMsh4NQC4OTIBIGiC894QLAXGOhyQRT/TGOoekWg9eJV74339UY7X4ikl
         KnCR/IYsclMrtPAYKXc3dpji2qt4/vK4X6+FkyLsvJujsIPs1MQ/Nhz1ExysVWFJoE
         w7hEf04F0JqGvemHkZk5UtpQPhS5K8qH0AWfILWE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519882025;
        bh=V+S3MzEsNWDhdhfo3XkxB5KoKeTG+Ys9bNGsmvr8v+w=; l=501;
        h=Received:From:To:Subject;
        b=ZPJsijCBmMsh4NQC4OTIBIGiC894QLAXGOhyQRT/TGOoekWg9eJV74339UY7X4ikl
         KnCR/IYsclMrtPAYKXc3dpji2qt4/vK4X6+FkyLsvJujsIPs1MQ/Nhz1ExysVWFJoE
         w7hEf04F0JqGvemHkZk5UtpQPhS5K8qH0AWfILWE=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1erGkB-0007Os-ER; Thu, 01 Mar 2018 08:27:03 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <CA+P7+xrzxYSE0OyL8uyF+ErwfWFEgcqnHmaciwWkK-76sQ6ktw@mail.gmail.com>
        <8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com>
        <871sh5ofil.fsf@javad.com>
        <c8c2e915-cb55-9881-e54d-2c84ad7e16bb@gmail.com>
Date:   Thu, 01 Mar 2018 08:27:03 +0300
In-Reply-To: <c8c2e915-cb55-9881-e54d-2c84ad7e16bb@gmail.com> (Igor
        Djordjevic's message of "Wed, 28 Feb 2018 20:09:23 +0100")
Message-ID: <87bmg8s6vs.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

[...]
>> > Hmm, still rushing it, but what about adding an additional step, 
>> > something like this:
>> 
>> I think it's unneeded, as it should work fine without it, see another
>> reply.
>
> Unfortunately, I have a broken test case saying different - it could 
> very well be a flawed test, too, but let`s elaborate in that 
> other sub-thread[1], indeed.

Yeah, I was too fast to reply and I was wrong, sorry about it.

-- Sergey
