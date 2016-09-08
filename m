Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E04F1F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758134AbcIHHwu (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:52:50 -0400
Received: from mout.gmx.net ([212.227.17.21]:59438 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753751AbcIHHws (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:52:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MXDo1-1bVcaq3CQH-00WCsH; Thu, 08 Sep 2016 09:52:41
 +0200
Date:   Thu, 8 Sep 2016 09:52:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff_populate_filespec: NUL-terminate buffers
In-Reply-To: <xmqqinu7muic.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1609080950090.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <f899957fa71537aa2686f17ce18aaf16f2fea2ac.1473090278.git.johannes.schindelin@gmx.de> <20160906070604.i5rojh3kyc7x7kso@sigill.intra.peff.net> <alpine.DEB.2.20.1609061613270.129229@virtualbox>
 <20160906184143.55a5zoa2mj6c2e5m@sigill.intra.peff.net> <xmqqinu7muic.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RQm+FK2CLg8mC9lXIzo0yYATnsvneuriT3QdeDHTT7K/sYvdzZC
 QdqCrSk0mx6V/lLSw+HWj8qgtn4MyohDah+b54XmuktKHPnztFdGMBdmjkS+suauDSdmrVo
 qzic9zDTM+Aznbmn7dzHVImmpEdutWfP4Y6HWuTGk4ynJmDGxiO5fHArgnbuY856qnPdaxQ
 JikhLK05uarRtQc7c2G0g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ydwYkOlM+Z0=:9OXlPg7esCpJI6Rjqd/9bq
 +lwdUUvQ3RWzzWsgzj1iyOPvq1HXlGmuaps0vxwIVbdMOY4HSQgWHTbRW+izpWKrIe6tpZ/xl
 vJADqv5Mtiu4CkuxeZVI+KcKXdeIuBnHBK4jCRb+x4hKPtuOlCaeOeolEuovhLqRoedBHh6xn
 855tmyEGKrTSxCA7ZDKm5aBRGhGcEUqfTodQzuFnrrPy8LAw4VLKhk50RccS37F83OVVFQ0Ze
 IfJOMqlSbKk8yftmM6YvvctkfKoA+lQzYmgHGUus0N9skI+PgxzsvpATvhaZq99ivVW1avswg
 LCEfp7YpNq0nm2eoYhf2Wx26/G9Ts6WUPENnlbPSELOkmYhb70OTVOFzf+LURj8X5CAN5KdgS
 qRLmInuSXFzJ09uEEGmX4wS9enm4VlY28FNWcmiQ2Af+UYR8lirhxpw2c03+lGNuiaTAkhAvh
 My87zYNnD1hcaJKHWdrFAGxXoS1PdqDzvA+ont4Rj8bK0zdb+4+D1/dxq1tgFPQAAZQMn2A8f
 h+JEpCek32Q5xmj+qRAB1XwEcRIAae2Zg0X5j/646l8xJ3wIjBrfCpTPhA2xN5DuC8M6C3oT0
 mzOLJo2kuI43OKQxPjm4dPStzC3p+ypE9dNE7R0VqKoi+XffMt2YsqLZD+IoTTTwfFfSbh81M
 BqJcG6Ae7VpejxBOfNlT6RfWAJN7ZozcwhQk1/JULJMbxNSUXVlw+gCfXkjLQwTWcn6gaVgJp
 oOZSrJCbUfxztDx9M64mACNN/lOy9rd98ECDzABHckRu037tD9jQA+f/cvknZx4VvRuJHlbYe
 bkBupSb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 7 Sep 2016, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > What happens to those poor souls on systems without REG_STARTEND? Do
> > they get to keep segfaulting?
> >
> > I think the solution is to push them into setting NO_REGEX. So looking
> > at this versus a "regexecn", it seems:
> >
> >   - this lets people keep using their native regexec if it supports
> >     STARTEND
> >
> >   - this is a bit more clunky to use at the callsites (though we could
> >     _create_ a portable regexecn wrapper that uses this technique on top
> >     of the native regex library)
> >
> > But I much prefer this approach to copying the data just to add a NUL.
> 
> I first thought "push them to NO_REGEX" to mean "they live with
> crippled Git that does not do regexp" and went "Huh?", but it merely
> means "let's avoid platform regex library and use on from the
> compat/ hierarchy", which would solve the STARTEND portability issue
> for everybody.
> 
> Which is very good.
> 
> The idea to create a thin regexecn() wrapper also sounds like a good
> idea, too.  The changes to the callsites in the demonstration patch
> does look a bit clunky to me, too.

The demonstration patch was only meant as a mere demonstration where this
leads us. I DRY'd it up quite a bit (which was my plan all along, but it
was faster to make the changes in place, to avoid a full-sale
recompilation due to a central header change; you might not care because
you use Linux with its native POSIX, while I have to use MSYS2, making
even my builds slower).

And I really do not think that it would be a good idea to use
compat/regex/ for everybody, even if they already have a working regex.h
on their system.

Ciao,
Dscho
