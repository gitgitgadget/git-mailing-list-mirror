Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D562D1F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 20:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbcIVU1x (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 16:27:53 -0400
Received: from ikke.info ([178.21.113.177]:57454 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933642AbcIVU1w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 16:27:52 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 053E54400BA; Thu, 22 Sep 2016 22:27:49 +0200 (CEST)
Date:   Thu, 22 Sep 2016 22:27:49 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Aaron Gray <aaronngray.lists@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Request for large repo clone on slow intermittent connections
Message-ID: <20160922202749.GA32197@ikke.info>
References: <CANkmNDe7y8oYRDDz4uTUso0SaDn+jSGs=q3XTzKuavSWhnP4kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANkmNDe7y8oYRDDz4uTUso0SaDn+jSGs=q3XTzKuavSWhnP4kg@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 12:54:57PM +0100, Aaron Gray wrote:
> I am having problems cloning a 2.1GB repo from googlesource
> 
> C:\Users\Aaron Gray\GitHub>git clone
> https://chromium.googlesource.com/chromium/chromium
> Cloning into 'chromium'...
> remote: Sending approximately 2.11 GiB ...
> error: fatal: The remote end hung up unexpectedly MiB | 2.74 MiB/s
> fatal: RPC failed; curl 56 SSL read:
> error:00000000:lib(0):func(0):reason(0), errno 10054
> early EOF
> fatal: index-pack failed
> 
> I am repeatedly getting the same result on a 36MBit connection
> 
> Hoping for a soulution.
> 
> Regards,
> 
> Aaron

Nothing much that can be done with a flaky connection. What git does
support are so called bundle files. These basically contain history that
you can import. Such a bundle can be offered through a resumable
transport, such as http.

I'll send you a link to a bundle for the chromium project.
