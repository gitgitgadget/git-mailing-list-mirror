From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/6] Towards a generalized sequencer
Date: Thu, 11 Aug 2011 21:33:23 -0500
Message-ID: <20110812023323.GA672@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <20110811190312.GD2277@elie.gateway.2wire.net>
 <CALkWK0nXAU+jFwyzmYC6XuPGy8Cdmbpis0Nvb-M+tQSNk_PXiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 04:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrhZ4-0006YO-Su
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 04:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab1HLCde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 22:33:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48046 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753537Ab1HLCdd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 22:33:33 -0400
Received: by mail-yx0-f174.google.com with SMTP id 19so1714406yxj.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 19:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bad+/p9VyzK+Rju/0hdS02kNiCmj3FGDvGJtsm7qeKw=;
        b=hehbn04EMmSxngblevsUnQQa5l3uYhNUTo5u6KAw6HYuUnz4/hJS551Ftd5OiTo6Ql
         n2KBNMHz4ZDz++eDF3/SBpvIpxynCsFomKIVkue5U/muQQ+5p15E8sqwqLWC20oti3k2
         AGa4it8BeXCQoZDojUXlgH2THiLeZ2h0FJ7OA=
Received: by 10.42.133.134 with SMTP id h6mr371208ict.364.1313116413225;
        Thu, 11 Aug 2011 19:33:33 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-30.dsl.chcgil.ameritech.net [68.255.106.30])
        by mx.google.com with ESMTPS id ib5sm3727300icc.12.2011.08.11.19.33.31
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 19:33:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nXAU+jFwyzmYC6XuPGy8Cdmbpis0Nvb-M+tQSNk_PXiQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179161>

Ramkumar Ramachandra wrote:

> 2. Should I move it to sequencer.c and and modify it accordingly?
> It'll read Copyright (C) 2011 <Me>, based on builtin/revert.c which is
> Copyright Dscho, which in turn is based on git-revert.sh
[...]

Isn't it still the same built-in cherry-pick code, originally by Dscho
and improved over time by others?  The filename is irrelevant.

If you want to add your and Christian's names to reflect
multiple-cherry-pick and the restructuring, I guess that would be ok.
Better yet, if you want to remove Dscho's name to encourage people to
look at the commit log and get a richer story, just ask Dscho.

Asking would (1) show that you value his contribution and respect his
wishes and (2) allow him to say, "no, I really prefer to keep my name
there for such-and-such copyright-related reason".  Of course these
are only my own thoughts.  Maybe I'm too picky.
