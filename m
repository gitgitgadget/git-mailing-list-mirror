Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B9C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 23:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiAUXon convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 21 Jan 2022 18:44:43 -0500
Received: from elephants.elehost.com ([216.66.27.132]:36454 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiAUXon (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 18:44:43 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 20LNidD1001275
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Jan 2022 18:44:39 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>, "David Aguilar" <davvid@gmail.com>,
        "Taylor Blau" <me@ttaylorr.com>,
        =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
References: <patch-v2-1.1-444eacf30be-20220119T094428Z-avarab@gmail.com>        <patch-v3-1.1-e9cb8763fd4-20220120T011414Z-avarab@gmail.com> <xmqqr190ekrh.fsf@gitster.g>
In-Reply-To: <xmqqr190ekrh.fsf@gitster.g>
Subject: RE: [PATCH v3] cache.h: auto-detect if zlib has uncompress2()
Date:   Fri, 21 Jan 2022 18:44:33 -0500
Organization: Nexbridge Inc.
Message-ID: <000a01d80f20$dadd0e80$90972b80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHYDx3icnCiWwZU4UqBkvC8zL59gKxuIxTQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 21, 2022 6:23 PM, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > As noted in the updated commit message this approach of having an
> > object just for this fallback function comes at the cost of some
> > complexity, but now the compat object lives neatly in its own object.
> 
> I do not see any change in this patch adding costly complexity, but I notice lack of
> one possible trick that might become problem with some compilers and linkers
> when their zlib has uncompress2() function.  Let's have this graduate very early in
> the next cycle, to see if anybody on a rarer system sees a complaint due to having
> to deal with a totally empty object file.
> 
> Will queue.

On behalf of the "rarer systems", I will certainly be putting this through the regression suite.
With thanks,
--Randall

