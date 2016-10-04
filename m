Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4523C20987
	for <e@80x24.org>; Tue,  4 Oct 2016 11:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbcJDLlY (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 07:41:24 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.41]:57734 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbcJDLlX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 07:41:23 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1brO63-0008HU-Bg; Tue, 04 Oct 2016 13:41:19 +0200
Date:   Tue, 4 Oct 2016 13:41:17 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeremy Morton <admin@game-point.net>,
        Chris Packham <judge.packham@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        mara.kim@vanderbilt.edu, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config option
Message-ID: <20161004114117.GC20309@book.hvoigt.net>
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
 <1401874256-13332-1-git-send-email-judge.packham@gmail.com>
 <57F27B02.8080803@game-point.net>
 <CAGZ79kbNVy7VFj31m7VKZYP6xphkV_d9Y1x9Q0_=5PZ+_068HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbNVy7VFj31m7VKZYP6xphkV_d9Y1x9Q0_=5PZ+_068HA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 10:18:32AM -0700, Stefan Beller wrote:
> On Mon, Oct 3, 2016 at 8:36 AM, Jeremy Morton <admin@game-point.net> wrote:
> > Did this ever get anywhere?  Can we recursively update submodules with "git
> > pull" in the supermodule now?
> 
> I think the idea is sound.

I am confused there is nothing handling *pull* here? This patch was
about clone. Handling 'pull' is a much bigger topic[1].

Cheers Heiko

[1] https://github.com/jlehmann/git-submod-enhancements/wiki/Recursive-submodule-checkout
