Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D70311FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 12:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbdBGMCr (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 07:02:47 -0500
Received: from mout.gmx.net ([212.227.17.22]:63976 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753284AbdBGMCr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 07:02:47 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPUFR-1cWNVk0BOL-004nAa; Tue, 07
 Feb 2017 13:02:37 +0100
Date:   Tue, 7 Feb 2017 13:02:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     David Aguilar <davvid@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t7800: replace "wc -l" with test_line_count
In-Reply-To: <20170207091700.20156-2-davvid@gmail.com>
Message-ID: <alpine.DEB.2.20.1702071300021.3496@virtualbox>
References: <20170207091700.20156-1-davvid@gmail.com> <20170207091700.20156-2-davvid@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Fbu1tywu3/Cp89aA5M3U7eDG9dgPWOgL9huetbdqobnwRxhFtDK
 z92aPZUpMo29OMrPLhfbvqXu/UbOeeni1oKU1SyvJw2ULUA2X7hJFl7Y1okgurvFbDEMeye
 0QiqOfwmW9mrItLx8D3r9q6D1X8MLRET3jSTVWTc6DcvcHP/80zSum8MoLEtA9X9VxoGc04
 dsoMs8M74VJoQB8PdJT+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uEHmBUq27a8=:NbYJi263Jq88nVbOqdjRNk
 MJ7XfSbVEzflEwrRL51UeJ32e4YvnEoI6OqsdviV8kBH1EZP5vDAtLyM8aTt8LFypfX+idn+q
 xIvQKVcvJUbzg8JgO+LdBM48jAPYCr5tjrC35+Ls08fp5b3sW5KWi+ddoVrwKK5+tdt751HHt
 OOkDtqIHgqUugV5GXjjqKWXQHJCliMd16hJnS+ivWCVBnKR9IzSmSgovIKTpf5qn2XmSQkMbj
 ARxNBtK+aPYChr16y/uHfbnSuAaItW8JiH52CNFfBbC6OqUNFUmJ8PUrLCTNY61+7ecU8334V
 bFuCgWNSw5Sak0H1zwA4OL2SQIYGsdA/pKRMWATooFlwml0iVTa1G7RiWNgOMyjL06O2M1gxy
 2ZnCFThZFHeNvI/cZhdv1g6VATyHa2cGLB1TNYY9o7wOmwYJs6EL6uC87wjIaMLTOvrjTN5JU
 H9YayYpNIRoa48rwxiwie7iQXt+dYAHQ7wSmYRyz44rnufbN7KQM4qY6fIFsJD7QcNcUjPvRQ
 Rt2eFhgnygc1k+EXB+2DbXuOXQgmMaBTnB4LeckGnUBVNtX/ZA2F4EoMTTdx9XvNGFSWQGNGM
 c+J8GSrIwFuRMfWjUUgGr7j0PNRPU3nHOq2gAMNdkh8jkAMWJewRavjPgrLWxy34RDE3ZxHp7
 ATPxM6jQfoO4tlxXyI3bHkx85Lwix49zy3+ezCyavpFIGQchKzCWWmvymk+UiGVSMyFbToTR/
 tWXkaoDgDBQhfjwVtpCIif63vxWRAFYfMYf0U7NwRkEa/REynBmaHxybXX2y8TClbzzVXUUSb
 hBC/KaCOB1GDnDQ3fLHq7YNLzoxMjoHDfFTtsuMrStN651dhg2Xo7oHJO59Av4pjHO3fLAq2v
 CoKLYpGqJTEIUhvd5Xxw1+YDuschtZcdwPg1W2eMZQTu067DjKOme+xrophpo5+EV6N2o3jb8
 MXgiR9zHUGyPycj+b2huhlSn47glJPn6PfqMYTPFg4YBuoqG8TqEg8hTPLMQlzbK5YrthUxXG
 kdLD2jpwj99u6GE+RY3IxRY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Tue, 7 Feb 2017, David Aguilar wrote:

> Make t7800 easier to debug by capturing output into temporary files and
> using test_line_count to make assertions on those files.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>

Both patches look like an obvious improvement with no obvious bugs to me.

In this case, I allowed myself to forego the more thorough code review in
favor of merely glancing over the diffs, seeing as the changes do not
really need a lot of context.

Thank you,
Johannes
