Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33A32013A
	for <e@80x24.org>; Mon, 13 Feb 2017 03:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbdBMDJT (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 22:09:19 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:50502 "EHLO
        homiemail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751334AbdBMDJS (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 12 Feb 2017 22:09:18 -0500
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id C75F8314C066;
        Sun, 12 Feb 2017 19:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=auVQ1
        G4xVaDyUUMjGFv97KjPTGs=; b=SQG1buru7DPGzkDmKcG0UbZfsELPAA5oJuK3W
        0hEyk/02AVAeYVkboZ29Lv0BKG+ULvyft9Jhu6XYnPhMurpSL209b09zzvNRhWQj
        BKnME9CGGwYXizFx8qNpaOX2irUej4S4YckQuRlBvB0eFqn/rcYCxIXAuoLNhya9
        6aDKq8=
Received: from corey (207-38-252-131.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.252.131])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id 8E5EA314C062;
        Sun, 12 Feb 2017 19:09:16 -0800 (PST)
Message-ID: <1486955355.1929.14.camel@novalis.org>
Subject: Re: [PATCH v2 0/9] Store submodules in a hash, not a linked list
From:   David Turner <novalis@novalis.org>
To:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Date:   Sun, 12 Feb 2017 22:09:15 -0500
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.4-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Fri, 2017-02-10 at 12:16 +0100, Michael Haggerty wrote:
> This is v2 of the patch series, considerably reorganized but not that
> different codewise. Thanks to Stefan, Junio, and Peff for their
> feedback about v1 [1]. I think I have addressed all of your comments.

LGTM.

