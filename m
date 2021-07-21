Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E043FC12002
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 09:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FCA61181
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 09:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhGUIx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 04:53:56 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:29433 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236848AbhGUIrx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 04:47:53 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1m68Vw-0006Nu-6D; Wed, 21 Jul 2021 10:27:41 +0100
Subject: Re: [PATCH v6 3/3] bundle doc: elaborate on rev<->ref restriction
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover-0.3-00000000000-20210702T112254Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210720T141611Z-avarab@gmail.com>
 <patch-3.3-6d66d4480ff-20210720T141611Z-avarab@gmail.com>
 <xmqqo8awhh5z.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <68ea4cc0-b9d3-a7fb-7c22-fa828f9dc52f@iee.email>
Date:   Wed, 21 Jul 2021 10:27:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqo8awhh5z.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/07/2021 21:19, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> +Revisions must accompanied by reference names to be packaged in a
>> +bundle, since the header of the bundle is in a format similar to 'git
>> +show-ref'.
> This may be an improvement in the way how the description refers to
> "show-ref", but we do not have to say anything about "show-ref" ;-)
>
> The reason we should give readers why they must give refs while
> creating a bundle, I think, is because the only way to access the
> contents of the bundle is to fetch refs from it, and the refs given
> to the command when the bundle was created becomes the refs that can
> be fetched from the bundle.
>
> Thanks.
>
Should the `list-heads` option be mentioned for investigating existing
bundles?
--
Philip
