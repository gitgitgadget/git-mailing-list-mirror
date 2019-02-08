Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457981F453
	for <e@80x24.org>; Fri,  8 Feb 2019 11:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfBHLzN (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 06:55:13 -0500
Received: from ikke.info ([178.21.113.177]:40686 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbfBHLzM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 06:55:12 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 49E924400CE; Fri,  8 Feb 2019 12:55:11 +0100 (CET)
Date:   Fri, 8 Feb 2019 12:55:11 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Rich Felker <dalias@libc.org>,
        Kevin Daudt <git@lists.ikke.info>, git@vger.kernel.org,
        larsxschneider@gmail.com
Subject: Re: t0028-working-tree-encoding.sh failing on musl based systems
 (Alpine Linux)
Message-ID: <20190208115511.GA30779@alpha>
References: <20190207215935.GA31515@alpha>
 <20190208001705.GC11927@genre.crustytoothpaste.net>
 <20190208060403.GA29788@brightrain.aerifal.cx>
 <20190208114502.GD11927@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208114502.GD11927@genre.crustytoothpaste.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 11:45:02AM +0000, brian m. carlson wrote:
> On Fri, Feb 08, 2019 at 01:04:03AM -0500, Rich Felker wrote:
> [..]
> > In any case, this test seems mainly relevant to Windows users wanting
> > to store source files in UTF-16LE with BOM. This doesn't really make
> > sense to do on a Linux/musl system, so I'm not sure any action is
> > needed here from either side.
> 
> I do know that some people use CIFS or the like to share repositories
> between Unix and Windows. However, I agree that such people aren't
> likely to use UTF-16 on Unix systems. The working tree encoding
> functionality also supports other encodings which musl may or may not
> support.
> 
> If you and your users are comfortable with the fact that the test (and
> the corresponding functionality) won't work as expected with UTF-16,
> then I agree that no action is needed.

So would you suggest that we just skip this test on Alpine Linux?

