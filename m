Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7DFC2BB55
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 17:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D15820857
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 17:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgDGRl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:41:59 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:46050 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgDGRl7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Apr 2020 13:41:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DE91A180A7352;
        Tue,  7 Apr 2020 17:41:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cover48_2e216e91cf159
X-Filterd-Recvd-Size: 1771
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  7 Apr 2020 17:41:56 +0000 (UTC)
Message-ID: <5d05fca7bcdeb57ed31fbbfc66d4cf7224e56f92.camel@perches.com>
Subject: Re: get_maintainer.pl sends bogus addresses to git send-email
From:   Joe Perches <joe@perches.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Jeff King <peff@peff.net>, linux-kernel@vger.kernel.org,
        git@vger.kernel.org
Date:   Tue, 07 Apr 2020 10:39:58 -0700
In-Reply-To: <20200407192949.586159e7.olaf@aepfle.de>
References: <20200407154046.GA15368@aepfle.de>
         <20200407170257.GA1844923@coredump.intra.peff.net>
         <2e6975d606846c834a387c07ee11cdce52356586.camel@perches.com>
         <20200407192949.586159e7.olaf@aepfle.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2020-04-07 at 19:29 +0200, Olaf Hering wrote:
> Am Tue, 07 Apr 2020 10:18:41 -0700
> schrieb Joe Perches <joe@perches.com>:
> 
> > You need to add --norolestats on the get_maintainer command line
> 
> Thanks, this can be used as a workaround for the time being.
> Not sure why anyone would actually care about such details in default mode...

Because the default is
"tell me more about the maintainers of a particular file".
which can include not just the default maintainers of
a particular file within a subsystem, but the also info
about the people that actually apply patches to files.

For instance, a patch made to a file often has a nominal
maintainer that doesn't actually apply the patches but
that maintainer may review or approve but not actually
be the upstream path for acceptance of the patch.



