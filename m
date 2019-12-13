Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E5CC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809102253D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLMVhz convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 13 Dec 2019 16:37:55 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:48360 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbfLMVhz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:37:55 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 2FF7B20039F;
        Fri, 13 Dec 2019 22:37:51 +0100 (CET)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] doc: remove non pure ASCII characters
Date:   Fri, 13 Dec 2019 22:37:50 +0100
Message-ID: <2958852.hm7A7XRobS@cayenne>
In-Reply-To: <xmqqk170j938.fsf@gitster-ct.c.googlers.com>
References: <20191212204655.10425-1-jn.avila@free.fr> <20191212204655.10425-2-jn.avila@free.fr> <xmqqk170j938.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, 13 December 2019 20:53:31 CET Junio C Hamano wrote:
> Jean-Noël Avila <jn.avila@free.fr> writes:
> 
> > Non ASCII characters may be handled by publishing chains, but right
> > now, nothing indicates the encoding of files. Moreover, non ASCII
> > source strings upset the localization toolchain.
> >
> > Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> > ---
> >  Documentation/git-clone.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Thanks.  I've always wanted to do this, but it is a bit surprising
> that there is only this single instance?

There's another one in git-format-patch.txt, "Uwe Kleine-König diet", but this one does not seem to cause issues and it is difficult to replace it with ASCII only.

Should I try to find an alternative text?

> 
> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> > index 34011c2940..2e8babe671 100644
> > --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -262,9 +262,9 @@ or `--mirror` is given)
> >  	All submodules which are cloned will be shallow with a depth of 1.
> >  
> >  --[no-]remote-submodules::
> > -	All submodules which are cloned will use the status of the submodule’s
> > +	All submodules which are cloned will use the status of the submodule's
> >  	remote-tracking branch to update the submodule, rather than the
> > -	superproject’s recorded SHA-1. Equivalent to passing `--remote` to
> > +	superproject's recorded SHA-1. Equivalent to passing `--remote` to
> >  	`git submodule update`.
> >  
> >  --separate-git-dir=<git dir>::
> 




