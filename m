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
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D991F404
	for <e@80x24.org>; Wed, 28 Feb 2018 05:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbeB1FV6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 00:21:58 -0500
Received: from mail.javad.com ([54.86.164.124]:57160 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbeB1FV5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 00:21:57 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 4C6543E939;
        Wed, 28 Feb 2018 05:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795316;
        bh=MYmPgEIABcBV5UjJNQVTAQTnxPh4KPED/SpD/T7ppiU=; l=904;
        h=Received:From:To:Subject;
        b=mlFq5D8EWu9CPLZf+DLxkFdqeVdR+vHzKi3/LvdwGeBnM3h/JcSPv+iF/48KeIR9O
         IQoCO2GuxiwhnTZCAPA/ltTwtaNnymD2mH7dfcv/uK5ZW/vnnSpyzqcce4pDvgk4T0
         0Icmrz4kbCjJ7txsFU173+vhUdiFYEQKdsgjBqhY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795316;
        bh=MYmPgEIABcBV5UjJNQVTAQTnxPh4KPED/SpD/T7ppiU=; l=904;
        h=Received:From:To:Subject;
        b=mlFq5D8EWu9CPLZf+DLxkFdqeVdR+vHzKi3/LvdwGeBnM3h/JcSPv+iF/48KeIR9O
         IQoCO2GuxiwhnTZCAPA/ltTwtaNnymD2mH7dfcv/uK5ZW/vnnSpyzqcce4pDvgk4T0
         0Icmrz4kbCjJ7txsFU173+vhUdiFYEQKdsgjBqhY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795316;
        bh=MYmPgEIABcBV5UjJNQVTAQTnxPh4KPED/SpD/T7ppiU=; l=904;
        h=Received:From:To:Subject;
        b=mlFq5D8EWu9CPLZf+DLxkFdqeVdR+vHzKi3/LvdwGeBnM3h/JcSPv+iF/48KeIR9O
         IQoCO2GuxiwhnTZCAPA/ltTwtaNnymD2mH7dfcv/uK5ZW/vnnSpyzqcce4pDvgk4T0
         0Icmrz4kbCjJ7txsFU173+vhUdiFYEQKdsgjBqhY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795316;
        bh=MYmPgEIABcBV5UjJNQVTAQTnxPh4KPED/SpD/T7ppiU=; l=904;
        h=Received:From:To:Subject;
        b=mlFq5D8EWu9CPLZf+DLxkFdqeVdR+vHzKi3/LvdwGeBnM3h/JcSPv+iF/48KeIR9O
         IQoCO2GuxiwhnTZCAPA/ltTwtaNnymD2mH7dfcv/uK5ZW/vnnSpyzqcce4pDvgk4T0
         0Icmrz4kbCjJ7txsFU173+vhUdiFYEQKdsgjBqhY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795316;
        bh=MYmPgEIABcBV5UjJNQVTAQTnxPh4KPED/SpD/T7ppiU=; l=904;
        h=Received:From:To:Subject;
        b=mlFq5D8EWu9CPLZf+DLxkFdqeVdR+vHzKi3/LvdwGeBnM3h/JcSPv+iF/48KeIR9O
         IQoCO2GuxiwhnTZCAPA/ltTwtaNnymD2mH7dfcv/uK5ZW/vnnSpyzqcce4pDvgk4T0
         0Icmrz4kbCjJ7txsFU173+vhUdiFYEQKdsgjBqhY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519795316;
        bh=MYmPgEIABcBV5UjJNQVTAQTnxPh4KPED/SpD/T7ppiU=; l=904;
        h=Received:From:To:Subject;
        b=mlFq5D8EWu9CPLZf+DLxkFdqeVdR+vHzKi3/LvdwGeBnM3h/JcSPv+iF/48KeIR9O
         IQoCO2GuxiwhnTZCAPA/ltTwtaNnymD2mH7dfcv/uK5ZW/vnnSpyzqcce4pDvgk4T0
         0Icmrz4kbCjJ7txsFU173+vhUdiFYEQKdsgjBqhY=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1equBe-0001Oa-Kj; Wed, 28 Feb 2018 08:21:54 +0300
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
Date:   Wed, 28 Feb 2018 08:21:54 +0300
In-Reply-To: <8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com> (Igor
        Djordjevic's message of "Wed, 28 Feb 2018 02:33:56 +0100")
Message-ID: <871sh5ofil.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> On 28/02/2018 01:36, Jacob Keller wrote:
>> 
>> > > (3) ---X1---o---o---o---o---o---X2
>> > >        |\                       |\
>> > >        | A1---A2---A3---U1      | A1'--A2'--A3'--U1'
>> > >        |             \          |
>> > >        |              M         |
>> > >        |             /          |
>> > >        \-B1---B2---B3---U2      \-B1'--B2'--B3'--U2'
>> > >
>> >
>> > Meh, I hope I`m rushing it now, but for example, if we had decided to
>> > drop commit A2 during an interactive rebase (so losing A2' from
>> > diagram above), wouldn`t U2' still introduce those changes back, once
>> > U1' and U2' are merged, being incorrect/unwanted behavior...? :/
>> 
>> In that case, the method won't work well at all, so I think we need a
>> different approach.
>> 
>
> Hmm, still rushing it, but what about adding an additional step, 
> something like this:

I think it's unneeded, as it should work fine without it, see another
reply.

-- Sergey
