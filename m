From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-send-email is omitting author and date lines
Date: Mon, 24 Sep 2007 01:30:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709240129450.28395@racer.site>
References: <1190585633.29937.44.camel@localhost>  <7v4phlc668.fsf@gitster.siamese.dyndns.org>
 <1190590538.12557.1.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Hanspeter Kunz <hp@edelkunz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 24 02:31:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZbrf-000544-SM
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 02:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbXIXAbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 20:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbXIXAbu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 20:31:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:55666 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753967AbXIXAbt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 20:31:49 -0400
Received: (qmail invoked by alias); 24 Sep 2007 00:31:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 24 Sep 2007 02:31:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Qde9o4zJQ5S6zx1X12LgrGymES7WgDxiKKNdv7i
	OJagcwnYA9UYpz
X-X-Sender: gene099@racer.site
In-Reply-To: <1190590538.12557.1.camel@localhost>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59010>

Hi,

On Mon, 24 Sep 2007, Hanspeter Kunz wrote:

> On Sun, 2007-09-23 at 16:29 -0700, Junio C Hamano wrote:
> > Hanspeter Kunz <hp@edelkunz.ch> writes:
> > 
> > > When sending a patch to myself using `git-send-email` I realized that
> > > the lines containing the author and the date (lines 5 and 6 in the patch
> > > file) were not in the sent email.
> > 
> > Was the commit authored by yourself?
> 
> yes. does this make a difference?

Yes, it does.  The author is usually inferred from the sender of the mail, 
and therefore git-send-email strips that information from the message 
(IIRC).

Hth,
Dscho
