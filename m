From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: Re: [PATCH] t9155: fix compatibility with older SVN
Date: Thu, 19 Aug 2010 12:39:07 -0700 (PDT)
Message-ID: <56635.12651.qm@web30008.mail.mud.yahoo.com>
References: <4C6D6274.90009@web.de> <AANLkTiky8qn_PSgXSn=0h07cb4VmCFiFXmD9WrpO1z6z@mail.gmail.com> <20100819191425.GA1543@dcvr.yhbt.net> <20100819191552.GB1543@dcvr.yhbt.net>
Reply-To: "David D. Kilzer" <ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 21:39:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmAxJ-0003O2-F2
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 21:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab0HSTjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 15:39:12 -0400
Received: from web30008.mail.mud.yahoo.com ([209.191.69.25]:37674 "HELO
	web30008.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751731Ab0HSTjL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 15:39:11 -0400
Received: (qmail 14365 invoked by uid 60001); 19 Aug 2010 19:39:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1282246748; bh=iX4py/sPWMVbW88CgfpLVcYo/pvNsTkcQwbhNzBLcko=; h=Message-ID:X-YMail-OSG:Received:X-RocketYMMF:X-Mailer:References:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=a0vr4+dIdW8O4CFJl61trmqQhxkb4UUIe7ZAoPBRh4uInWi1IbV5wqtrVg8vTs/GgxnQOCY1y4C4HIzlYiNK76AJEzRElqmNdYG+Pw7ktL8cI65hum9JXODAqdlJObigozB6PfvgxdlVADtsiUhkWJlTwcxHCGh2LxQ8w1XS8YE=
X-YMail-OSG: LwXkZlcVM1nDuvHBQ_lIzBCzlL8bomFPf20YbdpzCW5qTi8
 lJBEcEA1DBhQjaGzkzDhM0iXR5L.ZAxlJRJNcWTykhPNMnrhHUYdktAo3.8m
 9KbUZMKdStANwGeVuZWatepLz6AZOdhcGtkbPfC_cBNrVig4nMxkjMsHfWPC
 6VR1If5p1TDpjaL45K5UvEDubkx1tsoBGV8N7t56POPKWUS3oC1I.dV80B_d
 .6rfmxzlfFH0IhVhoNdmvj8njOPzTOLZs_jw3CDSY1R4qH94uJNjmuVOBAEY
 s7brBhCkQEs86MgQR6BTtAXPs0Gd69DRh6L_KgFERCMDqTNgxSYsehRGdy_f
 wluc6OLOLIgNfKFjXdgu7z9gaEfVKJEWJ8FtcMC4Tl4E-
Received: from [17.202.32.26] by web30008.mail.mud.yahoo.com via HTTP; Thu, 19 Aug 2010 12:39:07 PDT
X-RocketYMMF: ddkilzer
X-Mailer: YahooMailRC/470 YahooMailWebService/0.8.105.279950
In-Reply-To: <20100819191552.GB1543@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153950>

On Thu, August 19, 2010 at 12:15:52 PM, Eric Wong wrote:


> The "--parents" option did not appear until SVN 1.5.x
> and is completely  unnecessary in this case.


At one point in development, I wasn't creating the branches directory on the 
initial import, which is why this was added.  Thanks for fixing this!

> Reported-by: Jens Lehmann <Jens.Lehmann@web.de>
> Signed-off-by:  Eric Wong <normalperson@yhbt.net>


Ack.

Dave
