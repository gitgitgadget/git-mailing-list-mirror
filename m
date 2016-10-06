Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3D120986
	for <e@80x24.org>; Thu,  6 Oct 2016 09:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941948AbcJFJyR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 6 Oct 2016 05:54:17 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:49789 "EHLO
        mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941944AbcJFJyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 05:54:14 -0400
X-Greylist: delayed 2437 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Oct 2016 05:54:13 EDT
Received: from mail-ua0-f181.google.com ([209.85.217.181])
        by mail.mailgateway.no with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72 (FreeBSD))
        (envelope-from <johan@herland.net>)
        id 1bs4k8-000Hjh-Q1
        for git@vger.kernel.org; Thu, 06 Oct 2016 11:13:32 +0200
Received: by mail-ua0-f181.google.com with SMTP id r64so11878469uar.3
        for <git@vger.kernel.org>; Thu, 06 Oct 2016 02:13:32 -0700 (PDT)
X-Gm-Message-State: AA6/9RmvWvlZU5lGcPd3GyjIGSlaoLmpTH3lp3XRfpjj+16gTKe+04NT0pDnfR4VYFSPYCq4JKrdubzEqzteVQ==
X-Received: by 10.176.6.163 with SMTP id g32mr8871031uag.138.1475745206847;
 Thu, 06 Oct 2016 02:13:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.2.167 with HTTP; Thu, 6 Oct 2016 02:13:26 -0700 (PDT)
In-Reply-To: <20161006084905.14944-1-avarab@gmail.com>
References: <20161006084905.14944-1-avarab@gmail.com>
From:   Johan Herland <johan@herland.net>
Date:   Thu, 6 Oct 2016 11:13:26 +0200
X-Gmail-Original-Message-ID: <CALKQrgeBwT=20CRysy55VwymaWqVKEqPYexviiiZG4HZxS9_nQ@mail.gmail.com>
Message-ID: <CALKQrgeBwT=20CRysy55VwymaWqVKEqPYexviiiZG4HZxS9_nQ@mail.gmail.com>
Subject: Re: [PATCH] push: Re-include "push.default=tracking" in the documentation
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 6, 2016 at 10:49 AM, Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Change the documentation for push.tracking=* to re-include a mention
> of what "tracking" does.
>
> The "tracking" option was renamed to "upstream" back in
> 53c4031 ("push.default: Rename 'tracking' to 'upstream'", 2011-02-16),
> this section was then subsequently rewritten in 87a70e4 ("config doc:
> rewrite push.default section", 2013-06-19) to remove any mention of
> "tracking".
>
> Maybe we should just warn or die nowadays if this option is in the
> config, but I had some old config of mine use this option, I'd
> forgotten that it was a synonym, and nothing in git's documentation
> mentioned that.
>
> That's bad, either we shouldn't support it at all, or we should
> document what it does. This patch does the latter.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Acked-by: Johan Herland <johan@herland.net>


-- 
Johan Herland, <johan@herland.net>
www.herland.net
