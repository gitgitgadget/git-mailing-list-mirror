Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021FAC433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAF160698
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 22:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhJUWGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:06:50 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:11537 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230233AbhJUWGt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 18:06:49 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Hb1jX334Gz5Y;
        Fri, 22 Oct 2021 00:04:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1634853872; bh=S26ZNvyk8OnzcElbEwVWuXU+hpTTvHTD4h+FrcyWyYQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=URZ23a7K4x9qiXxCOm35+RwIMWaKh2eicjlLSR0UIZ3LBuHpChf8PfXGRbg9at2hp
         GSyDAzOdOw7mFvdVQj3x2B40P86HlyEpWCToeAKzZ0wscIoI/LogYfkVNvpYz5+DKg
         x/AfUPkIJM28aeL6TZnU9tgZCMP3Ch71sgVWjDYYzKIvj9VwKjkmzcX3ZRSt2MthKZ
         Xk219DBQxporIQPZIMAXj/OdCehoHW7XyCsphjMer6nf+jPQb9Ws/gz3T++E7jvpvQ
         5bHPBVQrHJuhslmPd34gIYMYqagYBsKAs73MpcWVQfdM7Wnaz70rxuyq7FAnn1haHO
         82oL2klZ2JYAw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Fri, 22 Oct 2021 00:04:31 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git format-patch --signoff
Message-ID: <YXHj74OPJmFqamxP@qmqm.qmqm.pl>
References: <YXHaAu2G51vy5H8z@qmqm.qmqm.pl>
 <YXHcjbiE6GX6zJHk@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXHcjbiE6GX6zJHk@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 21, 2021 at 09:33:01PM +0000, brian m. carlson wrote:
> On 2021-10-21 at 21:22:10, Micha³ Miros³aw wrote:
> > Hi.
> > 
> > I just noticed that `git format-patch --signoff` adds the 'Signed-off-by'
> > line even if the exact same line is already present in the commit message.
> > Could this be avoided in the tool?
> Just so I understand correctly, does it do this even if the existing
> sign-off is last (or the only one), or only if the sign-off is not the
> last?

It does this regardless of where the signoff is or whether it is the
only one.

Best Regards
Micha³ Miros³aw
