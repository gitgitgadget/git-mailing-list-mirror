From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 19:35:12 -0500
Message-ID: <20071130003512.GB11683@coredump.intra.peff.net>
References: <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site> <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:35:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixtr0-0002Up-9g
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763157AbXK3AfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762451AbXK3AfS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:35:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3612 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759832AbXK3AfP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:35:15 -0500
Received: (qmail 30325 invoked by uid 111); 30 Nov 2007 00:35:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 19:35:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 19:35:12 -0500
Content-Disposition: inline
In-Reply-To: <7veje8twt2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66576>

On Thu, Nov 29, 2007 at 04:13:29PM -0800, Junio C Hamano wrote:

>  - Post v1.5.5, start cooking the change that does not install hardlinks
>    for built-in commands, aiming for inclusion in v1.5.6, in May-Jun
>    2008 timeframe.

I am still against this step, for the reasons mentioned in the mails
leading up to the one you just quoted. I am fine with "does not install
hardlinks for builtin-commands on systems that don't support hardlinks"
(and of course all such hardlinks are in $(libexecdir)/git-core at this
point).

-Peff
