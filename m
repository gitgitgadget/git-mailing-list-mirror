Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02311C77B7D
	for <git@archiver.kernel.org>; Sat, 13 May 2023 14:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbjEMO6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 May 2023 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjEMO6g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2023 10:58:36 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618111FD6
        for <git@vger.kernel.org>; Sat, 13 May 2023 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
        s=2023022100; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID; bh=H1g/R+wzsZa+iZWYexR1N9jwreyrIFYwzh+T58tAsQo=; b=qrbXBw
        3PnNV/LpoCqRs0/+IHVYqStitGeenNLBtHxu5wUxBlVbiOugNiWcbPGN9dC2iVixjCG28uB+mnGOS
        MpdA4VRbfzcqgvQqIzdD4ytLWlggLrd1ceoKnNoIxpDd65Xm6kl9/gBtmk/GhJiqAwSyGfTxgZ3i1
        vTeakzP70YQ=;
Received: from 88-110-117-142.dynamic.dsl.as9105.com ([88.110.117.142] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pxqhb-0003U6-95;
        Sat, 13 May 2023 15:58:32 +0100
Message-ID: <2ca296d5-4871-5123-3fcd-88f94e86b0b7@iee.email>
Date:   Sat, 13 May 2023 15:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Can we clarify the purpose of `git diff -s`?
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <5bb24e0208dd4a8ca5f6697d578f3ae0@SAMBXP02.univ-lyon1.fr>
 <4f713a29-1a34-2f71-ee54-c01020be903a@univ-lyon1.fr>
 <xmqqo7mpqy6g.fsf@gitster.g> <87h6shif6q.fsf@osv.gnss.ru>
 <xmqqv8gxpd8r.fsf@gitster.g> <645ea15eca6fa_21989f294f5@chronos.notmuch>
 <xmqq1qjlp98j.fsf@gitster.g> <877ctdi5wp.fsf@osv.gnss.ru>
 <645ec6c64bbd7_21cbbf294bf@chronos.notmuch>
Content-Language: en-GB
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <645ec6c64bbd7_21cbbf294bf@chronos.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/05/2023 00:07, Felipe Contreras wrote:
> Also agree. I've never heard the word "squelch" outside of the git context, and
> I'm pretty sure my English vocabulary is not small. Multiple people have
> suggested "silent" and no one has suggested "squelch" (other than Junio).
Squelch is common in the right circles.

It is the term for cutting out the static electricity based background
audio noise from radio receivers. Back in the day, it was an adjustable
dial, so anyone who used a radio (including ex-military and their
family) would be familiar with the term.

It's not so common nowadays because there is auto-squelch and auto
tuning on most receivers, but it's still part of the lexicon ;-)

Philip
