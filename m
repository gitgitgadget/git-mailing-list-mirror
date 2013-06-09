From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local
 changes without pushing
Date: Sun, 9 Jun 2013 02:12:22 -0400
Message-ID: <20130609061222.GB8906@sigill.intra.peff.net>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
 <vpqzjv0tokx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: benoit.person@ensimag.fr, git@vger.kernel.org,
	celestin.matte@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 09 08:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlYrd-0001Tr-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab3FIGMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 02:12:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:60545 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3FIGMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:12:25 -0400
Received: (qmail 15574 invoked by uid 102); 9 Jun 2013 06:13:14 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 01:13:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 02:12:22 -0400
Content-Disposition: inline
In-Reply-To: <vpqzjv0tokx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226891>

On Sat, Jun 08, 2013 at 09:00:30PM +0200, Matthieu Moy wrote:

> > +	# Auto-loading in browser
> > +	if ($autoload) {
> > +		open(my $browser, "-|:encoding(UTF-8)", "xdg-open ".$preview_file_name);
> 
> That could be read from Git's configuration, and default to xdg-open.
> But you don't want to hardcode it in the middle of the code.

In fact, I think we provide the "git-web--browse" tool for just this
purpose. It takes care of the trickiness of looking at the "web.browser"
config, resolving custom browser tools defined by "browser.<tool>.*",
and handling backgrounding of the browser (which you want to do for
graphical browsers but not for terminal ones).

-Peff

PS I agreed with all of the other comments in your review. :)
