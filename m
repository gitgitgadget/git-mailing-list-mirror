Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE59C38142
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 16:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjA0QkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 11:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjA0QkV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 11:40:21 -0500
X-Greylist: delayed 341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Jan 2023 08:40:18 PST
Received: from fame.vanrein.org (2a02-58-157-9b00--7.ip6.tweak.nl [IPv6:2a02:58:157:9b00::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F5A7CC89
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 08:40:17 -0800 (PST)
Received: by fame.vanrein.org (Postfix, from userid 1000)
        id 7B90E2B051; Fri, 27 Jan 2023 16:34:34 +0000 (UTC)
Date:   Fri, 27 Jan 2023 16:34:34 +0000
From:   Rick van Rein <rick@openfortress.nl>
To:     git@vger.kernel.org
Subject: Git over HTTP; have flexible SASL authentication
Message-ID: <20230127163434.GA784@openfortress.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Git providers are inventing proprietary extensions to HTTP authentication
for Git.  It seems smarter to use SASL for this purpose, possibly allowing
the client a choice and authentication ringback to the client's own domain.

I wrote an Internet Draft to allow just that, and we implemented it for
Apache, Nginx and FireFox.  I would love to learn if this list considers
it a sensible extensions to Git.
https://datatracker.ietf.org/doc/html/draft-vanrein-httpauth-sasl

If you think this is useful, it would be wonderful to mention that on the
HTTP WorkGroup list as well, because they are now considering HTTP-SASL
for adoption, a formal requisite to send "Authorization: SASL" headers.
https://datatracker.ietf.org/wg/httpbis/about/


Thanks!

Rick van Rein
InternetWide.org


Apache  :- https://gitlab.com/arpa2/apachemod/-/tree/master/arpa2_sasl
           https://gitlab.com/arpa2/apachemod/-/tree/master/arpa2_diasasl
Nginx   :- https://github.com/stef/ngx_http_auth_sasl_module
FireFox :- https://gitlab.com/arpa2/http_sasl_client

