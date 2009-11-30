From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] tests: handle NO_PYTHON setting
Date: Mon, 30 Nov 2009 23:31:41 +0100
Message-ID: <200911302331.41235.johan@herland.net>
References: <20091130075221.GA5421@coredump.intra.peff.net>
 <20091130205453.GA20348@coredump.intra.peff.net>
 <tzCtKYIbFlbIbn30IPnqgVxpN1o3NxDP88NXFHHufBYXMjZJIG1Gyw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 23:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFEmk-0001Q8-VA
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 23:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941AbZK3Wbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 17:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752658AbZK3Wbr
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 17:31:47 -0500
Received: from smtp.getmail.no ([84.208.15.66]:42809 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752596AbZK3Wbq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 17:31:46 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTY00CJT193QRD0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Nov 2009 23:31:51 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KTY00DFV18U2T30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Nov 2009 23:31:51 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.11.30.222121
User-Agent: KMail/1.12.3 (Linux/2.6.31-ARCH; KDE/4.3.3; x86_64; ; )
In-reply-to: <tzCtKYIbFlbIbn30IPnqgVxpN1o3NxDP88NXFHHufBYXMjZJIG1Gyw@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134146>

On Monday 30 November 2009, Brandon Casey wrote:
> Jeff King wrote:
> > On Mon, Nov 30, 2009 at 12:07:40PM -0600, Brandon Casey wrote:
> >> ps. There's something eerily familiar about this patch.
> >
> > Hmmm. Yes, I didn't search before writing it, but you probably mean:
> >
> >   http://article.gmane.org/gmane.comp.version-control.git/127172
> >
> :) yeah, that was it, nbd.

Oops. I got Brandon's patches in my local tree, but I never got around to 
resend the series until Sverre picked up and refactored it. Sorry for the 
screwup.

> > But that is missing the NO-PYTHON bit in GIT-BUILD-OPTIONS (did you
> > forget it there, or was it part of some other patch that also didn't
> > get applied?).
> 
> It was 1/2 of that series.

Indeed.

> > Also, I am tempted to move the GIT-BUILD-OPTIONS invocation _up_. It
> > is about reading config and should probably come before we start doing
> > _anything_.
> >
> > So maybe this instead:
> 
> <snip the patch>
> 
> Looks fine to me.

As with Brandon's original patch, this is of course

Acked-by: Johan Herland <johan@herland.net>

> No strong opinion on whether the BUILD-OPTIONS thing should be
> at the beginning of the script, or in the place where you placed
> it.

Me neither.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
