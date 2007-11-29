From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Thu, 29 Nov 2007 18:14:44 -0500
Message-ID: <20071129231444.GA9616@coredump.intra.peff.net>
References: <20071127160423.GA22807@laptop> <Pine.LNX.4.64.0711271617350.27959@racer.site> <20071128000731.GD9174@efreet.light.src> <7v8x4jb295.fsf@gitster.siamese.dyndns.org> <fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com> <7vfxyq2c9b.fsf@gitster.siamese.dyndns.org> <20071129150849.GA32296@coredump.intra.peff.net> <fcaeb9bf0711291205h125dadbbp8e8ae392e9b5b751@mail.gmail.com> <20071129211409.GA16625@sigill.intra.peff.net> <Pine.LNX.4.64.0711292218240.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 30 00:15:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixsb3-0002vn-PK
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 00:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761184AbXK2XOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 18:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762606AbXK2XOs
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 18:14:48 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3838 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbXK2XOr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 18:14:47 -0500
Received: (qmail 29866 invoked by uid 111); 29 Nov 2007 23:14:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 18:14:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 18:14:44 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711292218240.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66570>

On Thu, Nov 29, 2007 at 10:19:16PM +0000, Johannes Schindelin wrote:

> > I think that is totally reasonable, as on those platforms there is
> > actually something to be gained from removing those hardlinks (you could
> 
> Note that one big problem with a few platforms having dash forms and 
> others not is that you _will_ get scripts and aliases that do not work 
> everywhere.
> 
> Consistency is good.

Yes, I am fine with the user having to go to extra lengths to use the
dash forms (like adding $(libexecdir) to their path), which I think
should address your consistency concern.

-Peff
