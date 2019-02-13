Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362681F453
	for <e@80x24.org>; Wed, 13 Feb 2019 04:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfBMEab (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 23:30:31 -0500
Received: from p3plsmtpa07-06.prod.phx3.secureserver.net ([173.201.192.235]:43801
        "EHLO p3plsmtpa07-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727469AbfBMEab (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Feb 2019 23:30:31 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id tmBog2GKDjKhitmBqgy1rG; Tue, 12 Feb 2019 21:30:31 -0700
Date:   Wed, 13 Feb 2019 06:30:28 +0200
From:   Max Kirillov <max@max630.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git@vger.kernel.org, max@max630.net
Subject: Re: [BUG] More on t5562 hangs randomly in subtests 6,8 and 13 in
 2.21.0-rc0
Message-ID: <20190213043028.GC3064@jessie.local>
References: <001901d4c22b$194bfe60$4be3fb20$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001901d4c22b$194bfe60$4be3fb20$@nexbridge.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfEYsR3YXV3qkT1Jg4QiVAb02qr2FPB/2iK6vL8EbYI2M6DwGDmnV9n3g1t+Tdh5COp3YvT5W/6u6G0P8QVwEb9tSVor1Xs2U2yS0a5KiO20VpimXLAnm
 TXO6su/tH40go9QrHWuRYVOMXo1qkLjTWvFta2vmJ9HcvBGeTecNyj21QVqR1b1M6j4AnjlWtqyNKJp1j0SHiKewb5CeA3v5pL3nB4LqtOBTBQnK+mrPGUx1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 11:59:00AM -0500, Randall S. Becker wrote:
> Hi All,
> 
> I have localized the hang in t5562 (previous thread) to the
> invoke-with-content-length.pl script.

Hi.

I have not noticed the previous thread.

I have yet to look at it more closely, but there have been
one case of misbehavior due to unintended reuse of output file (see
https://public-inbox.org/git/20181119101535.16538-1-carenas@gmail.com/ )
Could your case be somehow related to it?
