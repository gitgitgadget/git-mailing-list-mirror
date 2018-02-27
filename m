Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1042B1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 05:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeB0FBw (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 00:01:52 -0500
Received: from mail.javad.com ([54.86.164.124]:55461 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbeB0FBv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 00:01:51 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 4D6EF407CA;
        Tue, 27 Feb 2018 05:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519707710;
        bh=5+NW7EKmZoIA2TLkikZN9jbdrCxEjyoQNh07vBvqVvM=; l=1132;
        h=Received:From:To:Subject;
        b=OCV/wkL3b9A8fh3+jVBZHPcwa04QRhJOfmA4UYbMtzlmcXW4mNxuPm2FvbYmJ1DHv
         UwJP/+tocLgrr3pAozSTq3H2/Bz2phNLs34Toj3ASIuNhYaq4QaF7D75JgX5jvE5Je
         yU6LJCFSVNd34ps4AlowWAjrP1NzOWnAK9Ne5Cb4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519707710;
        bh=5+NW7EKmZoIA2TLkikZN9jbdrCxEjyoQNh07vBvqVvM=; l=1132;
        h=Received:From:To:Subject;
        b=OCV/wkL3b9A8fh3+jVBZHPcwa04QRhJOfmA4UYbMtzlmcXW4mNxuPm2FvbYmJ1DHv
         UwJP/+tocLgrr3pAozSTq3H2/Bz2phNLs34Toj3ASIuNhYaq4QaF7D75JgX5jvE5Je
         yU6LJCFSVNd34ps4AlowWAjrP1NzOWnAK9Ne5Cb4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519707710;
        bh=5+NW7EKmZoIA2TLkikZN9jbdrCxEjyoQNh07vBvqVvM=; l=1132;
        h=Received:From:To:Subject;
        b=OCV/wkL3b9A8fh3+jVBZHPcwa04QRhJOfmA4UYbMtzlmcXW4mNxuPm2FvbYmJ1DHv
         UwJP/+tocLgrr3pAozSTq3H2/Bz2phNLs34Toj3ASIuNhYaq4QaF7D75JgX5jvE5Je
         yU6LJCFSVNd34ps4AlowWAjrP1NzOWnAK9Ne5Cb4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519707710;
        bh=5+NW7EKmZoIA2TLkikZN9jbdrCxEjyoQNh07vBvqVvM=; l=1132;
        h=Received:From:To:Subject;
        b=OCV/wkL3b9A8fh3+jVBZHPcwa04QRhJOfmA4UYbMtzlmcXW4mNxuPm2FvbYmJ1DHv
         UwJP/+tocLgrr3pAozSTq3H2/Bz2phNLs34Toj3ASIuNhYaq4QaF7D75JgX5jvE5Je
         yU6LJCFSVNd34ps4AlowWAjrP1NzOWnAK9Ne5Cb4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519707710;
        bh=5+NW7EKmZoIA2TLkikZN9jbdrCxEjyoQNh07vBvqVvM=; l=1132;
        h=Received:From:To:Subject;
        b=OCV/wkL3b9A8fh3+jVBZHPcwa04QRhJOfmA4UYbMtzlmcXW4mNxuPm2FvbYmJ1DHv
         UwJP/+tocLgrr3pAozSTq3H2/Bz2phNLs34Toj3ASIuNhYaq4QaF7D75JgX5jvE5Je
         yU6LJCFSVNd34ps4AlowWAjrP1NzOWnAK9Ne5Cb4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519707710;
        bh=5+NW7EKmZoIA2TLkikZN9jbdrCxEjyoQNh07vBvqVvM=; l=1132;
        h=Received:From:To:Subject;
        b=OCV/wkL3b9A8fh3+jVBZHPcwa04QRhJOfmA4UYbMtzlmcXW4mNxuPm2FvbYmJ1DHv
         UwJP/+tocLgrr3pAozSTq3H2/Bz2phNLs34Toj3ASIuNhYaq4QaF7D75JgX5jvE5Je
         yU6LJCFSVNd34ps4AlowWAjrP1NzOWnAK9Ne5Cb4=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1eqXOe-0007ZL-9j; Tue, 27 Feb 2018 08:01:48 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 27 Feb 2018 08:01:48 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Tue, 27 Feb 2018 01:07:01 +0100
        (STD)")
Message-ID: <87tvu36n5v.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> Hi Buga,
>
> On Tue, 20 Feb 2018, Igor Djordjevic wrote:
>
>> I`m really interested in this topic, which seems to (try to) address the
>> only "bad feeling" I had with rebasing merges - being afraid of silently
>> losing amendments by actually trying to "replay" the merge (where
>> additional and possibly important context is missing), instead of really
>> "rebasing" it (somehow).

[...]

> In short: while I am sympathetic to the desire to keep things simple,
> the idea to somehow side-step replaying the original merge seems to be
> *prone* to be flawed.

The proposed (TM) solution does replay the original merge.

> Any system that cannot accommodate dropped/changed/added commits on
> either side of a merge is likely to be too limited to be useful.

I believe the proposed (TM) solution handles all that nicely. It does
accommodate dropped/changed/added commits on either side of a merge,
symmetrically, and never silently drops user modifications.

If you think (TM) is flawed, please give us a test-case.

-- Sergey
