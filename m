Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 7116 invoked by uid 107); 30 Mar 2009 22:55:13 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 30 Mar 2009 18:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbZC3Wyo (ORCPT <rfc822;peff@peff.net>);
	Mon, 30 Mar 2009 18:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbZC3Wyo
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 18:54:44 -0400
Received: from joe.mail.tiscali.it ([213.205.33.54]:49651 "EHLO
	joe.mail.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbZC3Wyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 18:54:43 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Mar 2009 18:54:43 EDT
Received: from oblomov.local (78.13.53.34) by joe.mail.tiscali.it (8.0.022)
        id 499F039601E4A981; Tue, 31 Mar 2009 00:49:12 +0200
Message-ID: <499F039601E4A981@joe.mail.tiscali.sys> (added by
	    postmaster@tiscali.it)
From:	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] git-gui: make "Git GUI Here" Explorer extension more robust
To:	"Shawn O. Pearce" <spearce@spearce.org>, msysgit@googlegroups.com,
	git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
Date:	Tue, 31 Mar 2009 00:49:07 +0200
References: <200903300030.03733.markus.heidelberg@web.de> <alpine.DEB.1.00.0903300243050.6454@intel-tinevez-2-302> <200903300851.43164.markus.heidelberg@web.de> <20090330141510.GW23521@spearce.org>
User-Agent: KNode/0.10.9
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Face:	::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Monday 30 March 2009 16:15, Shawn O. Pearce wrote:

> Markus Heidelberg <markus.heidelberg@web.de> wrote:
>> 
>> But I just noticed, that it will obviously "cd .." forever, if no .git/
>> was found. Somehow the root directory has to be catched.
> 
> Yup.  I'm dropping this patch for now because of this issue, but
> I'll look at it again if its addressed in another version.  :-)

I have a couple of pending patches to fix git gui handling of repositories,
including support for nonstandard repository locations and bare repositories.
You can find them at

http://git.oblomov.eu/git

and specifically

http://git.oblomov.eu/git/patches/b2e4c32e13df1b7f18e7b4a9f746650471a3122e..a63526bf3238cf25d9a5521f7ee35ed1bd11cb16

I got distracted by real-life issue and forgot to resend them. I'll try
to find the time again later on this week. I'm not entirely sure these
solve Markus' problem though.

-- 
Giuseppe "Oblomov" Bilotta

