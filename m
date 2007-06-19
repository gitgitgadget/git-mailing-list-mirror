From: Olivier Galibert <galibert@pobox.com>
Subject: Re: Stupid quoting...
Date: Tue, 19 Jun 2007 22:53:14 +0200
Message-ID: <20070619205313.GA90303@dspnet.fr.eu.org>
References: <86ir9sw0pi.fsf@lola.quinscape.zz> <f51irh$shq$1@sea.gmane.org> <86ir9l1ylc.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706190156110.4059@racer.site> <86sl8owfqj.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0706191048570.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 22:53:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0khR-00008Y-Sq
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 22:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbXFSUxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 16:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbXFSUxP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 16:53:15 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:2552 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbXFSUxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 16:53:15 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id 27E74A4960; Tue, 19 Jun 2007 22:53:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706191048570.4059@racer.site>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50507>

On Tue, Jun 19, 2007 at 10:50:31AM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 19 Jun 2007, David Kastrup wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > Don't just throw away backwards compatibility, only because it does 
> > > not fit your wishes.
> > 
> > There is no backwards compatibility involved here _at_ _all_.
> 
> I was not talking about Git here. The specification for SMTP is not going 
> to change just because you want it. There are still mail servers out there 
> which speak 7-bit, and the standard requires you to cope with them.

There are standards to send 8-bit into 7-bit for email, and \xxx is in
none of them.  And 8-to-7 encoding for email is not git's job in any
case unless git speaks SMTP directly.  8-to-7 is the mail client
responsability.

  OG.
