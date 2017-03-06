Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF6520133
	for <e@80x24.org>; Mon,  6 Mar 2017 15:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753009AbdCFPvw (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 10:51:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:39229 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752785AbdCFPvu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 10:51:50 -0500
Received: (qmail 27291 invoked by uid 109); 6 Mar 2017 15:45:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 15:45:08 +0000
Received: (qmail 18659 invoked by uid 111); 6 Mar 2017 15:45:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Mar 2017 10:45:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Mar 2017 10:45:05 -0500
Date:   Mon, 6 Mar 2017 10:45:05 -0500
From:   Jeff King <peff@peff.net>
To:     Christian7573 <cag4561@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: HTTP Dumb Push?
Message-ID: <20170306154505.ams3ekxf33qqcou7@sigill.intra.peff.net>
References: <CAOJpByWRg1V85CJsX2akuvbKuqFBoGJO+XJu01Kq0KNwuM-YFA@mail.gmail.com>
 <CAOJpByWFKbWE=HtNVpqDgfoqo1ajNttstNpRaUHT7a5AjObuJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOJpByWFKbWE=HtNVpqDgfoqo1ajNttstNpRaUHT7a5AjObuJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2017 at 09:38:33AM -0600, Christian7573 wrote:

> Is there a way for git to push to a server using the dumb protocol?
> Perhaps using the PUT method to upload files?
> Just wondering cause I just set up a dumb server and pushing to it
> doesn't work.

Git dumb-http push protocol goes over DAV. There are instructions in
Documentation/howto/setup-git-server-over-http.txt of the git
repository. They're quite old now, and I have no idea if they've
bit-rotted over the years. Hardly anybody uses that solution these days
(and it's much less efficient than the smart protocol).

> If that isn't an option, where can I get a smart server?

The CGI ships with the rest of git.  Try "git help http-backend", which
has some sample config for Apache and lighttpd.

-Peff
