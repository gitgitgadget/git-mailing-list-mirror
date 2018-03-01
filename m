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
	by dcvr.yhbt.net (Postfix) with ESMTP id D68A21F404
	for <e@80x24.org>; Thu,  1 Mar 2018 05:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966028AbeCAFT7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 00:19:59 -0500
Received: from mail.javad.com ([54.86.164.124]:53330 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965949AbeCAFT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 00:19:57 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 035E53E8C3;
        Thu,  1 Mar 2018 05:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519881596;
        bh=bEibQAjQZsq1VyaGGhCUBqH1/4N87ut6mHBK2tTl0Eo=; l=1582;
        h=Received:From:To:Subject;
        b=dBBqCbIFKxC/TCA647QY+JIwJDM8ZHaEyilhaPiHSqaEjUAsyj3Abk2cdE5RCn92n
         pjchnZAAxYBcO3OsiqJxYg9LPWomuNd4ATikfYMH1BWhyZMUc6fa36bV20pvcQPQYy
         W7nlWGI4fxlrNtDYL0Io/2IiPe2Kr53trQ+ChJ8Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519881596;
        bh=bEibQAjQZsq1VyaGGhCUBqH1/4N87ut6mHBK2tTl0Eo=; l=1582;
        h=Received:From:To:Subject;
        b=dBBqCbIFKxC/TCA647QY+JIwJDM8ZHaEyilhaPiHSqaEjUAsyj3Abk2cdE5RCn92n
         pjchnZAAxYBcO3OsiqJxYg9LPWomuNd4ATikfYMH1BWhyZMUc6fa36bV20pvcQPQYy
         W7nlWGI4fxlrNtDYL0Io/2IiPe2Kr53trQ+ChJ8Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519881596;
        bh=bEibQAjQZsq1VyaGGhCUBqH1/4N87ut6mHBK2tTl0Eo=; l=1582;
        h=Received:From:To:Subject;
        b=dBBqCbIFKxC/TCA647QY+JIwJDM8ZHaEyilhaPiHSqaEjUAsyj3Abk2cdE5RCn92n
         pjchnZAAxYBcO3OsiqJxYg9LPWomuNd4ATikfYMH1BWhyZMUc6fa36bV20pvcQPQYy
         W7nlWGI4fxlrNtDYL0Io/2IiPe2Kr53trQ+ChJ8Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519881596;
        bh=bEibQAjQZsq1VyaGGhCUBqH1/4N87ut6mHBK2tTl0Eo=; l=1582;
        h=Received:From:To:Subject;
        b=dBBqCbIFKxC/TCA647QY+JIwJDM8ZHaEyilhaPiHSqaEjUAsyj3Abk2cdE5RCn92n
         pjchnZAAxYBcO3OsiqJxYg9LPWomuNd4ATikfYMH1BWhyZMUc6fa36bV20pvcQPQYy
         W7nlWGI4fxlrNtDYL0Io/2IiPe2Kr53trQ+ChJ8Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519881596;
        bh=bEibQAjQZsq1VyaGGhCUBqH1/4N87ut6mHBK2tTl0Eo=; l=1582;
        h=Received:From:To:Subject;
        b=dBBqCbIFKxC/TCA647QY+JIwJDM8ZHaEyilhaPiHSqaEjUAsyj3Abk2cdE5RCn92n
         pjchnZAAxYBcO3OsiqJxYg9LPWomuNd4ATikfYMH1BWhyZMUc6fa36bV20pvcQPQYy
         W7nlWGI4fxlrNtDYL0Io/2IiPe2Kr53trQ+ChJ8Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1519881596;
        bh=bEibQAjQZsq1VyaGGhCUBqH1/4N87ut6mHBK2tTl0Eo=; l=1582;
        h=Received:From:To:Subject;
        b=dBBqCbIFKxC/TCA647QY+JIwJDM8ZHaEyilhaPiHSqaEjUAsyj3Abk2cdE5RCn92n
         pjchnZAAxYBcO3OsiqJxYg9LPWomuNd4ATikfYMH1BWhyZMUc6fa36bV20pvcQPQYy
         W7nlWGI4fxlrNtDYL0Io/2IiPe2Kr53trQ+ChJ8Y=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1erGdG-0007OP-CU; Thu, 01 Mar 2018 08:19:54 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
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
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <7c34a060-3013-6404-fe8e-c3ad015803a7@gmail.com>
Date:   Thu, 01 Mar 2018 08:19:54 +0300
In-Reply-To: <7c34a060-3013-6404-fe8e-c3ad015803a7@gmail.com> (Igor
        Djordjevic's message of "Wed, 28 Feb 2018 23:17:28 +0100")
Message-ID: <87d10os77p.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> On 28/02/2018 21:25, Igor Djordjevic wrote:
>> 
>> But U1' and U2' are really to be expected to stay the same in 
>> non-interactive rebase case only...
>
> Just to rephrase to "could be expected" here, meaning still not 
> necessarily in this case, either - I`ve just witnessed 
> non-interactive rebase Johannes previously described[1], merge with 
> `-s ours` (dropping B* patches), plus B1 cherry-picked between 
> X1..X2, eventually coming up with different U1' and U2', too (which 
> would produce a wrong end result, if continued).

Even non-interactive rebase may bring arbitrary asymmetric changes on
both sides of the merge, especially likely when resolving conflicts
needs to take place. OTOH, interactive history editing session could
have merges that we don't intend to edit at all. Overall, neither
non-interactive case is in fact much simpler, nor interactive case is so
much different.

> But I guess this should go to the "complex history" pile, good thing 
> still being that diff safety check between U1' and U2' works as 
> expected, thus automatic merge rebase can be aborted and command 
> given back to the user for closer inspection.

Exactly. This fact hopefully won't stop us from looking for more
suitable automated handling of the general case though. It should still
be our goal to reduce the number of such aborts and to suggest better
merge result for amendment when we are still aborting.

Your proposal hopefully is such a valuable improvement.

-- Sergey
