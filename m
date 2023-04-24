Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714EFC77B7F
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 20:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjDXUla (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjDXUl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 16:41:28 -0400
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D659D5
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:41:25 -0700 (PDT)
Received: from [2400:4160:1877:2b00:2323:d593:1480:911e] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <mh@glandium.org>)
        id 1pr2zv-00HHjN-0e;
        Mon, 24 Apr 2023 20:41:19 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1pr2zq-00CjtJ-V2; Tue, 25 Apr 2023 05:41:14 +0900
Date:   Tue, 25 Apr 2023 05:41:14 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] Fix memory leak in get_reachable_subset
Message-ID: <20230424204114.53di55n22c5zpbyb@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20230421234409.1925489-1-mh@glandium.org>
 <xmqqbkjdgt36.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbkjdgt36.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2023 at 09:09:33AM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > ---
> >  commit-reach.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Missing sign-off?

Gah. Sorry, I forgot it in this and another patch I sent a few days
ago ([PATCH] Handle compiler versions containing a dash)

Do you want full resends or is it okay if I just add

  Signed-off-by: Mike Hommey <mh@glandium.org>

here?

Mike
