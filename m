Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F72E7545C
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjJCSYo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjJCSYn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:24:43 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920983
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:24:39 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id C302024287;
        Tue,  3 Oct 2023 14:24:37 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qnk4T-JaC-00; Tue, 03 Oct 2023 20:24:37 +0200
Date:   Tue, 3 Oct 2023 20:24:37 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
Message-ID: <ZRxcZbH2u5Oa9WCi@ugly>
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
 <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de>
 <ZQlspgfu7yDW0oTN@ugly>
 <f778bc6f-dbe1-4df6-95ff-c9e9f36a3cc9@web.de>
 <ZQwdsfh1GQX0IOQs@ugly>
 <d9defed8-4e7e-4b84-be3d-57155d973320@web.de>
 <ZRvhEWHWn4nDynD0@ugly>
 <88cb2db8-e5cb-470a-8060-7a1b898c91f9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88cb2db8-e5cb-470a-8060-7a1b898c91f9@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 07:54:28PM +0200, René Scharfe wrote:
>C++ is not relevant for Git, but C23 is going to to stop supporting
>binary representations other than two's complement as well.
>
it is relevant insofar as that every platform that comes with a recent 
c++ compiler uses two's complement. this then applies to any language, 
regardless of standard.

>Still I don't feel comfortable overriding compiler warnings for
>something pedestrian as a command line parser.  No idea what other
>assumptions are made in compilers around enums.
>
i'm not sure what you're really worried about. if there was an actual 
problem, we'd have noticed by now. as far as i'm concerned, the question 
is only how to codify the status quo in the most elegant way. putting a 
typecast into a macro certainly qualifies in my book.

regards
