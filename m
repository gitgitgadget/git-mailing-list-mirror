Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E67C54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 12:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjAJM1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 07:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjAJM0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 07:26:33 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2655563EF
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 04:26:31 -0800 (PST)
Received: (qmail 17264 invoked by uid 109); 10 Jan 2023 12:26:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Jan 2023 12:26:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26897 invoked by uid 111); 10 Jan 2023 12:26:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Jan 2023 07:26:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Jan 2023 07:26:29 -0500
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 2/2] git-bisect-lk2009: update nist report link
Message-ID: <Y71ZdbH0H3LkILHp@coredump.intra.peff.net>
References: <20230110083801.186789-1-rybak.a.v@gmail.com>
 <20230110093251.193552-1-rybak.a.v@gmail.com>
 <20230110093251.193552-3-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230110093251.193552-3-rybak.a.v@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2023 at 10:32:51AM +0100, Andrei Rybak wrote:

> Commit d656218a83 (docs/bisect-lk2009: update nist report link,
> 2017-04-20) replaced a dead link to news release on nist.gov.  However,
> this might be confusing to the reader (like myself) because the article
> git-bisect-lk2009.txt quotes from the news release but the exact quote
> cannot be found in the full report.  In addition to that, the link added
> in 2017 is also dead in 2023.
> 
> Replace the reference to nist.gov with an version of the original NIST
> news release archived to the Wayback Machine.  Include also an updated
> link to a live version of the full report.

Both this and the other patch seem reasonable to me.

> I wasn't sure about inclusion of links to https://web.archive.org, but there is
> a single precedent already in "Documentation/gitcore-tutorial.txt".

I think it's a good match for this kind of link. The point is to cite a
historical artifact, and if archive.org is the only way to get the artifact,
then that's what we should do. Arguably it's what I should have done in
d656218a83 in the first place.

> --- a/Documentation/git-bisect-lk2009.txt
> +++ b/Documentation/git-bisect-lk2009.txt
> @@ -1347,7 +1347,7 @@ author to given a talk and for publishing this paper.
>  References
>  ----------
>  
> -- [[[1]]] https://www.nist.gov/sites/default/files/documents/director/planning/report02-3.pdf['The Economic Impacts of Inadequate Infratructure for Software Testing'.  Nist Planning Report 02-3], see Executive Summary and Chapter 8.
> +- [[[1]]] https://web.archive.org/web/20091206032101/http://www.nist.gov/public_affairs/releases/n02-10.htm['Software Errors Cost U.S. Economy $59.5 Billion Annually'. Nist News Release.] See also https://www.nist.gov/system/files/documents/director/planning/report02-3.pdf['The Economic Impacts of Inadequate Infratructure for Software Testing'.  Nist Planning Report 02-3], Executive Summary and Chapter 8.

The link target given to archive.org is for http, not https. I guess it
doesn't really matter as they archived the same content back then, and
the actual browser connection to archive.org will be over https. And
yours is more historically accurate. ;)

-Peff
