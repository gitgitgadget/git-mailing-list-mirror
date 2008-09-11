From: arjen@yaph.org (Arjen Laarhoven)
Subject: Re: [PATCH] Use compatibility regex library also on AIX
Date: Thu, 11 Sep 2008 10:25:54 +0200
Message-ID: <20080911082554.GB27748@regex.yaph.org>
References: <20080907184537.GA4148@regex.yaph.org> <e2b179460809100103t4266650bnac00097cfb86c0b1@mail.gmail.com> <20080910100301.GA27748@regex.yaph.org> <e2b179460809100453r3df4ec8dh3d9bfbbd468c5676@mail.gmail.com> <e2b179460809110059i2eca8b07x6d263f06cc8e5d32@mail.gmail.com> <48C8D374.9050007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 11 10:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdhVY-00022F-JE
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 10:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbYIKIZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 04:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbYIKIZY
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 04:25:24 -0400
Received: from regex.yaph.org ([193.202.115.201]:58849 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbYIKIZY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 04:25:24 -0400
Received: by regex.yaph.org (Postfix, from userid 1000)
	id 59BA35B7D5; Thu, 11 Sep 2008 10:25:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48C8D374.9050007@viscovery.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95594>

On Thu, Sep 11, 2008 at 10:14:44AM +0200, Johannes Sixt wrote:
> This augments 3632cfc24 (Use compatibility regex library on Darwin,
> 2008-09-07), which already carries a "Tested-by" statement for AIX,
> but that test was actually done with this patch included.

I hadn't realized it had already gone in to 'pu'.  I've put the AIX part
into my local patch, and also had it tested on HP-UX.  Today I'll
probably can test it on Solaris too, and add that as well.

Arjen

-- 
Arjen Laarhoven

The presence of those seeking the truth is infinitely to be preferred to 
those who think they've found it.
                                -- Terry Pratchett, "Monstrous Regiment"
