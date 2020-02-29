Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6643C3F2CD
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 16:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0402469C
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 16:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgB2QQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 11:16:48 -0500
Received: from elephants.elehost.com ([216.66.27.132]:10699 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgB2QQs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 11:16:48 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 01TGGemo035321
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Feb 2020 11:16:40 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     "'Alex Henrie'" <alexhenrie24@gmail.com>, <git@vger.kernel.org>,
        <rcdailey.lists@gmail.com>, <newren@gmail.com>, <annulen@yandex.ru>
References: <20200228215833.319691-1-alexhenrie24@gmail.com> <xmqqeeuecngu.fsf@gitster-ct.c.googlers.com> <20200229030344.GG101220@mit.edu>
In-Reply-To: <20200229030344.GG101220@mit.edu>
Subject: RE: [PATCH] pull: warn if the user didn't say whether to rebase or to merge
Date:   Sat, 29 Feb 2020 11:16:34 -0500
Message-ID: <012801d5ef1b$a0167740$e04365c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQLcJFSZg7OnYOyF1KP1NVyiv4pw4QHAeKrgAkSS01umBcVR8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On February 28, 2020 10:04 PM, Theodore Y. Ts'o wrote:
> To: Junio C Hamano <gitster@pobox.com>
> Cc: Alex Henrie <alexhenrie24@gmail.com>; git@vger.kernel.org;
> rcdailey.lists@gmail.com; newren@gmail.com; rsbecker@nexbridge.com;
> annulen@yandex.ru
> Subject: Re: [PATCH] pull: warn if the user didn't say whether to rebase
or to
> merge
> 
> On Fri, Feb 28, 2020 at 03:16:01PM -0800, Junio C Hamano wrote:
> > > To
> > > avoid that situation, Git should require users to explicitly specify
> > > whether their primary workflow is a contributor/rebasing workflow or
> > > a maintainer/merging workflow.
> >
> > There is nothing Git "should" do.  There are things we wish Git did,
> > and we give orders to the codebase to do so in our proposed log
> > message.  Perhaps like:
> 
> I'd also note that there are some workflows that assume that --rebase is
> *never* a good thing, even for contributors.  We can decide whether we
> want to bias the git man page in favor of one workflow as opposed to
> another, for the sake of new git users, but I don't think it's accurate to
say
> (or even imply) that there are only two workflows:
> contributor/rebasing and maintainer/merging.

I second this sentiment. The repositories my community (outside my company)
has are typically large (3-5Gb of sources) with 10K-100K individual files.
They all use a */merging paradigm.

Randall

