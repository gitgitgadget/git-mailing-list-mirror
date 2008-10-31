From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file
	modification time
Date: Fri, 31 Oct 2008 08:00:03 +0100
Message-ID: <20081031070003.GA4458@blimp.localdomain>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com> <1225344554.10803.17.camel@maia.lan>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-15?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Oct 31 08:01:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvo0j-0003wc-1Z
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 08:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbYJaHAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 03:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYJaHAP
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 03:00:15 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:46293 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbYJaHAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 03:00:13 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8BU83rXw=
Received: from tigra.home (Fae26.f.strato-dslnet.de [195.4.174.38])
	by post.webmailer.de (mrclete mo51) (RZmta 17.14)
	with ESMTP id a00e28k9V66nqP ; Fri, 31 Oct 2008 08:00:04 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 5AC77277C8;
	Fri, 31 Oct 2008 08:00:04 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 2570736D27; Fri, 31 Oct 2008 08:00:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225344554.10803.17.camel@maia.lan>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99556>

Sam Vilain, Thu, Oct 30, 2008 06:29:14 +0100:
> On Wed, 2008-10-29 at 11:38 +0100, Alex Riesen wrote:
> > I could not find what exactly does the ActiveState's Perl use for its stat
> > implementation (and honestly, have no motivation to look harder).
> > It seems to honor TZ, but the produced time does not seem to be either
> > local or GMT.
> 
> See, the difference is that the perl is portable and your patch isn't.

ActiveState Perl on Windows is portable? To another windows, maybe.

> Can you at least reveal how far out the value printed by the perl
> fragment was from the expected value, and what your TZ offset is in
> seconds.  It might be pointing to a deeper problem that could affect
> more than just this test case.

I tried TZ set to CET (my zone), GMT, and UTC. The difference was from
1200 sec to 3600.
