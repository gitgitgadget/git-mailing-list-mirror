Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE579C55186
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07D72075A
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 09:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDVJKt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:10:49 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53049 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgDVJKs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 05:10:48 -0400
X-Originating-IP: 42.109.213.158
Received: from localhost (unknown [42.109.213.158])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0F05F6000C;
        Wed, 22 Apr 2020 09:10:45 +0000 (UTC)
Date:   Wed, 22 Apr 2020 14:40:40 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git diff
Message-ID: <20200422091040.dmmdqih5ni3gfaac@yadavpratyush.com>
References: <65cbee30-fa37-1422-98f2-2c2b5aa094bd@maurel.de>
 <20200416225502.GJ2751707@camp.crustytoothpaste.net>
 <24a180f6-cc7e-fe5b-e810-0fc717d601ea@maurel.de>
 <20200417203323.GK2751707@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417203323.GK2751707@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/04/20 08:33PM, brian m. carlson wrote:
> On 2020-04-17 at 12:23:35, Guy Maurel wrote:
> > Hello again!
> > 
> > Using .git/config with
> > [diff]
> >         algorithm = patience
> > 
> > doesn't work with "git gui"
> > What is to do?
 
The bug has been reported on this list before. I will try to fix it when 
I can find the time. In the meantime, please use Junio's suggestion as a 
workaround.

> I don't know because I don't use git-gui.  If you would, please keep the
> list in CC, so that other folks who do know the answer can chime in.

-- 
Regards,
Pratyush Yadav
