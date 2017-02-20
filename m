Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6D4201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 08:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbdBTIGm (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 03:06:42 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:35022 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdBTIGl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 03:06:41 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7303F201B0;
        Mon, 20 Feb 2017 08:06:39 +0000 (UTC)
Date:   Mon, 20 Feb 2017 08:06:39 +0000
From:   Eric Wong <e@80x24.org>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: missing handling of "No newline at end of file" in git am
Message-ID: <20170220080639.GA3802@starla>
References: <20170214201104.GA26407@aepfle.de>
 <xmqqh93w8q0r.fsf@gitster.mtv.corp.google.com>
 <20170214215103.7d5e5f4c@probook.ubnt.lan>
 <20170215114430.GD16249@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170215114430.GD16249@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olaf Hering <olaf@aepfle.de> wrote:
> On Tue, Feb 14, Olaf Hering wrote:
> 
> > How would I debug it?
> 
> One line is supposed to be longer than 998 chars, but something along
> the way truncated it and corrupted the patch.

998 sounds like the SMTP limit.

Perhaps git format-patch should emit binary diffs in that case?
I doubt any human would bother reading excessively long lines as
text...
