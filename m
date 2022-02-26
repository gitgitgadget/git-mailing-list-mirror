Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3DC433F5
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 08:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiBZIz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 03:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiBZIzz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 03:55:55 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FB51DA01B
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 00:55:20 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,139,1643670000"; 
   d="scan'208";a="7029256"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 09:55:18 +0100
Date:   Sat, 26 Feb 2022 09:55:17 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
cc:     =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] add usage-strings ci check and amend remaining usage
 strings
In-Reply-To: <20220226042214.1413-1-chakrabortyabhradeep79@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2202260954341.3112@hadrien>
References: <220225.86zgme7vxo.gmgdl@evledraar.gmail.com> <20220226042214.1413-1-chakrabortyabhradeep79@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1816964097-1645865718=:3112"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1816964097-1645865718=:3112
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hello,

Since it seems that Coccinelle is not useful for your problem, could you
remove me from the CC list on this discussion?

thanks,
julia

On Sat, 26 Feb 2022, Abhradeep Chakraborty wrote:

>
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>
> > A. I think you're right about the t0012-help.sh output being bad,
> >    but that's rather easily fixed with something like the [1] below.
>
> Do you think the fix you suggested should be a part of this Patch series
> or a dedicated patch request is needed for this?
>
> > C. The case of 42 tests failing because of this could be addressed by just having
> >    t0012-help.sh do these checks if we wanted, although in that case we'd need to
> >    make sure we deal with other test blind spots. I.e. the
> >    "GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP" suggestion I had.
>
> Pardon me, I am having problem to understand the
> `"GIT_TEST_PARSE_OPTIONS_DUMP_FIELD_HELP" suggestion I had.` part
> here. Could you please explain a little bit?
>
> Thanks :)
>
--8323329-1816964097-1645865718=:3112--
