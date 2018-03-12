Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5707F1F404
	for <e@80x24.org>; Mon, 12 Mar 2018 13:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeCLNHu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 09:07:50 -0400
Received: from mail.javad.com ([54.86.164.124]:46357 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeCLNHt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 09:07:49 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 11CA33E896;
        Mon, 12 Mar 2018 13:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520860068;
        bh=/lqiWe8Q0uClhXPbG6ZuTU0NzyJlkk0cXHdTbbv2yFM=; l=746;
        h=Received:From:To:Subject;
        b=ApkcAtI6ajyrx7pJKJCD8+BJfwveM/jVU2fECPsT+09N1SOricAaqexr5xGBMDME7
         ceEqK9rLGY4RNu+emeK/sYZcjcYYmZ3JZvEzJKnXQFCbx/zog1deLu39TgOiGRNojq
         O7Wt03ZiJHHrgAa4cmy37JcaakjXVuQ+FY4DOupc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520860068;
        bh=/lqiWe8Q0uClhXPbG6ZuTU0NzyJlkk0cXHdTbbv2yFM=; l=746;
        h=Received:From:To:Subject;
        b=ApkcAtI6ajyrx7pJKJCD8+BJfwveM/jVU2fECPsT+09N1SOricAaqexr5xGBMDME7
         ceEqK9rLGY4RNu+emeK/sYZcjcYYmZ3JZvEzJKnXQFCbx/zog1deLu39TgOiGRNojq
         O7Wt03ZiJHHrgAa4cmy37JcaakjXVuQ+FY4DOupc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520860068;
        bh=/lqiWe8Q0uClhXPbG6ZuTU0NzyJlkk0cXHdTbbv2yFM=; l=746;
        h=Received:From:To:Subject;
        b=ApkcAtI6ajyrx7pJKJCD8+BJfwveM/jVU2fECPsT+09N1SOricAaqexr5xGBMDME7
         ceEqK9rLGY4RNu+emeK/sYZcjcYYmZ3JZvEzJKnXQFCbx/zog1deLu39TgOiGRNojq
         O7Wt03ZiJHHrgAa4cmy37JcaakjXVuQ+FY4DOupc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520860068;
        bh=/lqiWe8Q0uClhXPbG6ZuTU0NzyJlkk0cXHdTbbv2yFM=; l=746;
        h=Received:From:To:Subject;
        b=ApkcAtI6ajyrx7pJKJCD8+BJfwveM/jVU2fECPsT+09N1SOricAaqexr5xGBMDME7
         ceEqK9rLGY4RNu+emeK/sYZcjcYYmZ3JZvEzJKnXQFCbx/zog1deLu39TgOiGRNojq
         O7Wt03ZiJHHrgAa4cmy37JcaakjXVuQ+FY4DOupc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520860068;
        bh=/lqiWe8Q0uClhXPbG6ZuTU0NzyJlkk0cXHdTbbv2yFM=; l=746;
        h=Received:From:To:Subject;
        b=ApkcAtI6ajyrx7pJKJCD8+BJfwveM/jVU2fECPsT+09N1SOricAaqexr5xGBMDME7
         ceEqK9rLGY4RNu+emeK/sYZcjcYYmZ3JZvEzJKnXQFCbx/zog1deLu39TgOiGRNojq
         O7Wt03ZiJHHrgAa4cmy37JcaakjXVuQ+FY4DOupc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520860068;
        bh=/lqiWe8Q0uClhXPbG6ZuTU0NzyJlkk0cXHdTbbv2yFM=; l=746;
        h=Received:From:To:Subject;
        b=ApkcAtI6ajyrx7pJKJCD8+BJfwveM/jVU2fECPsT+09N1SOricAaqexr5xGBMDME7
         ceEqK9rLGY4RNu+emeK/sYZcjcYYmZ3JZvEzJKnXQFCbx/zog1deLu39TgOiGRNojq
         O7Wt03ZiJHHrgAa4cmy37JcaakjXVuQ+FY4DOupc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520860068;
        bh=/lqiWe8Q0uClhXPbG6ZuTU0NzyJlkk0cXHdTbbv2yFM=; l=746;
        h=Received:From:To:Subject;
        b=ApkcAtI6ajyrx7pJKJCD8+BJfwveM/jVU2fECPsT+09N1SOricAaqexr5xGBMDME7
         ceEqK9rLGY4RNu+emeK/sYZcjcYYmZ3JZvEzJKnXQFCbx/zog1deLu39TgOiGRNojq
         O7Wt03ZiJHHrgAa4cmy37JcaakjXVuQ+FY4DOupc=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1evNB4-0001Lz-Dy; Mon, 12 Mar 2018 16:07:46 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae8yq15.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
        <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com>
        <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com>
        <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com>
        <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com>
Date:   Mon, 12 Mar 2018 16:07:46 +0300
In-Reply-To: <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com> (Igor
        Djordjevic's message of "Sun, 11 Mar 2018 21:53:17 +0100")
Message-ID: <87a7vdh271.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> Hi Dscho,

[...]

> I think the root of misunderstanding might be coming from the fact
> that Sergey was mainly describing a general concept (without a
> strictly defined implementation strategy, not being restricted to a
> specific one), where Phillip came up with a solution that eventually
> seems to use the same concept (as those transformations above should
> show), but simplifying it further inside a concrete implementation.

As a side-note, starting from sound general concept leaves a hope to
end-up with something like Git, while starting from an implementation,
however nice it is, gives a danger of ending-up with something like Bzr.

-- Sergey
