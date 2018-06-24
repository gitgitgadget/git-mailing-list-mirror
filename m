Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40E61F516
	for <e@80x24.org>; Sun, 24 Jun 2018 11:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbeFXLkC convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 24 Jun 2018 07:40:02 -0400
Received: from bbox.sascha.silbe.org ([46.38.230.149]:58149 "EHLO
        bbox.sascha.silbe.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeFXLkB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jun 2018 07:40:01 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jun 2018 07:40:01 EDT
Received: from mimosa.sascha.silbe.org (unknown [46.189.28.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "", Issuer "stunnel Pseudo-CA" (verified OK))
        by bbox.sascha.silbe.org (Postfix) with ESMTPS id E2903BEF36
        for <git@vger.kernel.org>; Sun, 24 Jun 2018 13:30:35 +0200 (CEST)
Received: (nullmailer pid 29541 invoked by uid 8193);
        Sun, 24 Jun 2018 11:26:33 -0000
To:     Bryan Turner <bturner@atlassian.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
Cc:     sunshine@sunshineco.com
Subject: Re: [PATCH v2] Documentation: declare "core.ignorecase" as internal variable
In-Reply-To: <aa841316-5fc0-b69b-a3d0-15911b0776f4@syntevo.com>
References: <7f6b2a42-334d-9443-7b89-625069931ca7@syntevo.com> <aa841316-5fc0-b69b-a3d0-15911b0776f4@syntevo.com>
Date:   Sun, 24 Jun 2018 13:26:10 +0200
Message-ID: <toe7emobf3h.fsf@mimosa.sascha.silbe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sascha Silbe <sascha-ml-reply-to-2018-3@silbe.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Bryan, hello Marc,

Marc Strapetz <marc.strapetz@syntevo.com> writes:

> The current description of "core.ignoreCase" reads like an option which
> is intended to be changed by the user while it's actually expected to
> be set by Git on initialization only. This is especially important for
> Git for Windows, as noted by Bryan Turner [1]:

Does this apply to Mac OS X as well? I helped someone recently who had
trouble with renamed files (case change only) in a repository residing
on a case-insensitive HFS+ file system. Setting core.ignoreCase
explicitly (apparently it didn't get set automatically during clone for
some reason) helped; the files are recognised correctly now and the
case-only rename could be pulled. Is the post-clone change insufficient
on Mac OS X? Do we need to replace the existing repository and clone
again using '--config core.ignoreCase=true' to avoid future issues?


PS: Including the message-id of the mail being referenced would be
    useful; the id in the URL you gave is specific to the service being
    used (public-inbox.org) and cannot be used to reference the mail in
    any other archive (local or public). If you use the mid:<message-id>
    syntax (RFC 1630) some MUAs can even recognise the link and open the
    mail directly.

Sascha
-- 
Softwareentwicklung Sascha Silbe, Niederhofenstraße 5/1, 71229 Leonberg
https://se-silbe.de/
USt-IdNr.: DE281696641
