From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: [PATCH resend] perl/Makefile.PL: teach makefiles about possible old Error.pm files
Date: Thu, 22 May 2008 14:12:40 -0400
Message-ID: <20080522181240.GA12725@foursquare.net>
References: <20080517011614.GA11029@foursquare.net> <20080521222150.GA29696@foursquare.net> <7vzlqjz2wz.fsf@gitster.siamese.dyndns.org> <20080521235647.GA21340@foursquare.net> <alpine.DEB.1.00.0805221245240.30431@racer> <20080522164300.GA19765@foursquare.net> <7vd4new8qx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 20:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzFSb-0003oR-9R
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 20:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702AbYEVSXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 14:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755694AbYEVSXZ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 14:23:25 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:40808 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756552AbYEVSXY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 14:23:24 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m4MICeeg024112;
	Thu, 22 May 2008 14:14:25 -0400
Content-Disposition: inline
In-Reply-To: <7vd4new8qx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-15, required 5, autolearn=not spam,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82647>

On Thu, May 22, 2008 at 10:26:14AM -0700, Junio C Hamano wrote:
> > I guess I take the view that anything _installed_ by git is a part of git.
> > If git installs Error.pm, it can't expect the user to keep it around
> > if he uninstalls that version of git.
> 
> True, as we do not give "uninstall" target.  That's what distros are for.

I don't see how you can say "true" to what I said and keep git doing the
exact opposite. :-)

Anyway, there are other ways to fix this than INSTALLED_BY and I'm not
married to that idea, but if this isn't seen as a problem in the first
place, there's little use.

Would you accept a patch to the INSTALL file explaining this dependency?

Thanks,
- Chris
