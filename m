Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E60C433DB
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 17:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C73F061966
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 17:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhC1RPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 13:15:34 -0400
Received: from avasout06.plus.net ([212.159.14.18]:33495 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhC1RPY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 13:15:24 -0400
Received: from satellite ([147.147.167.73])
        by smtp with ESMTPA
        id QZ0RlG479HBkXQZ0Ul44Ch; Sun, 28 Mar 2021 18:15:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1616951723; bh=ftuEv1q/AeZpyRFQZLFROgX4ZwRkAXSehkTY5uRew1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YfVg/o6hsnz5Vag0O2p6o65skbMnB6B8/zTbduVMLzWAjIJWuGtqgW78lFaSFPUsC
         KX3OiURxFV9K7reL06KnrSMCJzVoy0Rvvbd1VidA8tVISk48BjC6NEwAxcgs7Grv06
         C+8silOkzJL2djyn6jz/eEOSDIfTU3VedFYOQrd7Tqy2Gz/RIkGMLtajSt3qa0D7vk
         xrELXEkf7lOaS8rExEdj1ufNuPolH+Zrj0qGq/USfhUbswN0VirDjVZDuUOqq0xMqU
         4Vmw5NYEDo3Q7CNsIE6JMLTFAuPxQYUm/VKJxrbYswevTgvrwu2ml2zzFPSJ70vtrJ
         BrwP+Tfzae/hA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fI+iIaSe c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=8nJEP1OIZ-IA:10 a=oinIv3hAYFYkefFDG_QA:9 a=wPNLvfGTeEIA:10
 a=fCgQI5UlmZDRPDxm0A3o:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-AUTH: ramsayjones@:2500
Date:   Sun, 28 Mar 2021 18:15:19 +0100
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v6 02/19] fsck.h: use designed initializers for
 FSCK_OPTIONS_{DEFAULT,STRICT}
Message-ID: <YGC5pzAOycCePCU6@satellite>
References: <20210317182054.5986-1-avarab@gmail.com>
 <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
 <patch-02.20-b17c982293e-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-02.20-b17c982293e-20210328T130947Z-avarab@gmail.com>
X-CMAE-Envelope: MS4wfLv2/xCz1IOyc8ClLIjuLGoN8FV3VcCNxcelO6d5u4jQuEpE56U6UyXMOkErOwh3AmGx7EHVPkqsAREJkR+Zzlzq6LscwfhAV+G2HE/XBXRctl+LF3hL
 jynTrVuv1w/5Ni7GrElvcNTOyniiE9vK4KewCylgpYpBOGweQomtTA0iVIkUjR+8+A9x3Vw0B7vsmA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 28, 2021 at 03:15:34PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Refactor the definitions of FSCK_OPTIONS_{DEFAULT,STRICT} to use
> designated initializers. This allows us to omit those fields that
> aren't initialized to zero or NULL.

s/aren't/are/

[I apologize in advance - I am using mutt for the first time to reply
to a ML post and I don't know if I should be using L-ist-reply or a
g-roup-reply! :D ]

ATB,
Ramsay Jones

