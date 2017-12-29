Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 426331F406
	for <e@80x24.org>; Fri, 29 Dec 2017 04:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754838AbdL2Eli (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 23:41:38 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:48359 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754665AbdL2Elh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 23:41:37 -0500
Received: from ip-9-223-239-173.east.us.northamericancoax.com ([173.239.223.9] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1eUmU9-0007sw-J0; Thu, 28 Dec 2017 23:41:34 -0500
Date:   Thu, 28 Dec 2017 23:41:27 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20171229044127.7jwyg7geclsmksw4@hopa.kiewit.dartmouth.edu>
References: <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
 <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
 <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
 <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
 <xmqqing6cje7.fsf@gitster.mtv.corp.google.com>
 <xmqqefqucigh.fsf@gitster.mtv.corp.google.com>
 <xmqqa81ichdu.fsf@gitster.mtv.corp.google.com>
 <20170926133703.7gtk5ztkhqvfxszh@hopa.kiewit.dartmouth.edu>
 <xmqqtvyzslcz.fsf_-_@gitster.mtv.corp.google.com>
 <CABPp-BHTZrNonnJrWfZg+_xCrO+o_uNjx4nbwuVHF4qVGe01cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHTZrNonnJrWfZg+_xCrO+o_uNjx4nbwuVHF4qVGe01cA@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: 173.239.223.9
X-SA-Exim-Rcpt-To: newren@gmail.com, gitster@pobox.com, git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [PATCH] merge: teach -Xours/-Xtheirs to symbolic link merge
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, 28 Dec 2017, Elijah Newren wrote:
> > Teach a similar trick to the codepath that deals with merging two
> > conflicting changes to symbolic links.

> Saw this change referenced in the "what's cooking" emails and decided
> to review this.  The code changes look obviously correct to me, and
> the testcase looks good too.

> Reviewed-by: Elijah Newren <newren@gmail.com>

> (and perhaps we should also add in "Tested-by: Yaroslav Halchenko
> <yoh@onerussian.com>" ?  At least, that was my thought based on
> https://public-inbox.org/git/20170926133703.7gtk5ztkhqvfxszh@hopa.kiewit.dartmouth.edu/
> )

I would be honored to wear a badge of the git-tested-by-er!  FWIW
I can reconfirm, that the patch did work out nicely for me back then

Thanks!
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
