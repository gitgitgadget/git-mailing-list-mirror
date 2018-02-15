Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 884CD1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751648AbeBOFcr (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:32:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:53356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750896AbeBOFcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:32:46 -0500
Received: (qmail 1255 invoked by uid 109); 15 Feb 2018 05:32:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:32:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7228 invoked by uid 111); 15 Feb 2018 05:33:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:33:31 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:32:44 -0500
Date:   Thu, 15 Feb 2018 00:32:44 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 07/23] cat-file: start migrating formatting to
 ref-filter
Message-ID: <20180215053244.GG18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4348-10a54126-e31d-448d-93a3-55fd89c248c4-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f4348-10a54126-e31d-448d-93a3-55fd89c248c4-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Move mark_atom_in_object_info() from cat-file to ref-filter and
> start using it in verify_ref_format().
> It also means that we start reusing verify_ref_format() in cat-file.
> 
> Start from simple moving of mark_atom_in_object_info(),
> it would be removed later by integrating all needed processes into
> ref-filter logic.

I see where you're going here, but it feels like there's a lot of
boilerplate to move this thing whole, when we plan to get rid of it in
the long run. After all, we _already_ support most of these placeholders
in ref-filter. I'll keep reading...

-Peff
