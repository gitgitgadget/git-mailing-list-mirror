Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 416081F859
	for <e@80x24.org>; Sun,  4 Sep 2016 19:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbcIDTnd (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 15:43:33 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:45575 "EHLO
        homiemail-a39.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753449AbcIDTnc (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 15:43:32 -0400
Received: from homiemail-a39.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTP id 62276150074;
        Sun,  4 Sep 2016 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=tWqtP
        2AkFpfTRqSoAROeEBH+AgA=; b=WHVzEXvPQfe1Qiij7HMEtZgDgNcMFn+GDI1o8
        QizftE9Nybcz98hm8p2lS7gDJXuXJe/CQxc1xPsu8hD3VPJlJpm+dcV/J/XifeTh
        DarXqr//RKkuIS2hcMl/TOs1kPIeqiXIMSCchpQ5UhjaDF8nLqjAQ/zaz1xN6HkR
        uTBW9w=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a39.g.dreamhost.com (Postfix) with ESMTPSA id 449B315006D;
        Sun,  4 Sep 2016 12:43:26 -0700 (PDT)
Message-ID: <1473018200.6035.18.camel@frank>
Subject: Re: [PATCH v2 04/38] refs: add a backend method structure
From:   David Turner <novalis@novalis.org>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Ronnie Sahlberg <sahlberg@google.com>,
        David Turner <dturner@twopensource.com>
Date:   Sun, 04 Sep 2016 15:43:20 -0400
In-Reply-To: <4da46c8dfa4b7ec13927ca8597b64ffff7de4430.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
         <4da46c8dfa4b7ec13927ca8597b64ffff7de4430.1473003902.git.mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-09-04 at 18:08 +0200, Michael Haggerty wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Add a `struct ref_storage_be` to represent types of reference stores. In
> OO notation, this is the class, and will soon hold some class
> methods (e.g., a factory to create new ref_store instances) and will
> also serve as the vtable for ref_store instances of that type.
> 
> As yet, the backends cannot do anything.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>


nit: duplicate Sign-off from Junio.



