From: Jeff King <peff@peff.net>
Subject: Re: git-daemon
Date: Tue, 20 Nov 2007 13:26:06 -0500
Message-ID: <20071120182606.GA9646@sigill.intra.peff.net>
References: <598D5675D34BE349929AF5EDE9B03E27017BCC42@az33exm24.fsl.freescale.net> <7vbq9pnac2.fsf@gitster.siamese.dyndns.org> <598D5675D34BE349929AF5EDE9B03E27017BCC8D@az33exm24.fsl.freescale.net> <20071120050756.GA29502@sigill.intra.peff.net> <598D5675D34BE349929AF5EDE9B03E27017BCD50@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Medve Emilian <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 19:27:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuXow-0001ne-B1
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 19:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761102AbXKTS0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 13:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761084AbXKTS0L
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 13:26:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4118 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761008AbXKTS0J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2007 13:26:09 -0500
Received: (qmail 31806 invoked by uid 111); 20 Nov 2007 18:26:08 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 20 Nov 2007 13:26:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2007 13:26:06 -0500
Content-Disposition: inline
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27017BCD50@az33exm24.fsl.freescale.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65559>

On Tue, Nov 20, 2007 at 09:54:13AM -0700, Medve Emilian wrote:

> I just built and installed the latest master (and next) and then I tried
> to clone (as I usualy do) one of my repositories. I run git-daemon only
> with the upload-pack service enabled.
> [...]
> 
> Nov 20 10:17:04 emmedve1-12 git-daemon: [3921] Connection from
> 10.82.124.104:2978
> Nov 20 10:17:04 emmedve1-12 git-daemon: [3921] Extended attributes (18
> bytes) exist <host=server>
> Nov 20 10:17:04 emmedve1-12 git-daemon: [3921] Request upload-pack for
> '/srv/scm/linux-2.6.git'

I don't see anything useful there.  Have you tried running git-daemon
with --verbose? If that doesn't turn up anything, can you try running
with GIT_TRACE=1 to see the upload pack command that is being executed
(and try running it yourself)?

> Did you try this and is working for you?

Yes, it works fine (though I ran it under tcpserver, not xinetd).

-Peff
