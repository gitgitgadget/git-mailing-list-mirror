Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C3520229
	for <e@80x24.org>; Fri, 21 Oct 2016 15:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934712AbcJUPso (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 11:48:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:60741 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933352AbcJUPsn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 11:48:43 -0400
Received: (qmail 1850 invoked by uid 109); 21 Oct 2016 15:48:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 15:48:43 +0000
Received: (qmail 4840 invoked by uid 111); 21 Oct 2016 15:49:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Oct 2016 11:49:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2016 11:48:40 -0400
Date:   Fri, 21 Oct 2016 11:48:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Prove "Tests out of sequence" Error
Message-ID: <20161021154840.pdmb5c3gjharsrxe@sigill.intra.peff.net>
References: <D9C1E13F-88A2-483E-A549-1C2294EACFEB@gmail.com>
 <CAGZ79kZo3LdcRmrjQTAvgx=H6U2tdjASK3qv5A2K5J2HQ2NvSw@mail.gmail.com>
 <20161021082035.xad6wfny5i6wtshh@sigill.intra.peff.net>
 <20161021084348.dp4jfpfownodl7nz@sigill.intra.peff.net>
 <CA+P7+xozpk2-WZUYtaKmCazG3Owzpa3bsDejyUuGj0YEQnJWJg@mail.gmail.com>
 <20161021153534.mjed3sqhxjelxzwx@sigill.intra.peff.net>
 <CA+P7+xrix3UZDEE1swG_=jBLwWHA04KoYikWBBMNx7aa=Hevmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xrix3UZDEE1swG_=jBLwWHA04KoYikWBBMNx7aa=Hevmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2016 at 08:42:58AM -0700, Jacob Keller wrote:

> > For $HARNESS_ACTIVE with _just_ "--verbose", I don't think it would be a
> > good idea to activate it. We should either silently ignore --verbose
> > then, or complain and die.
> 
> We should probably do that to make sure people realize what might
> happen. I read your series and it has a good explanation of the
> possible alternatives. I like the approach you chose.

Thanks. Do you want to make a patch on top of my series?

-Peff
