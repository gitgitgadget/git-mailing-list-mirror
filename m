From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 10:17:25 -0500
Message-ID: <20090214151725.GB3887@sigill.intra.peff.net>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com> <m3skmhteuk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 16:19:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYMJ0-0007Bj-SY
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 16:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbZBNPRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 10:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbZBNPR3
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 10:17:29 -0500
Received: from peff.net ([208.65.91.99]:54249 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366AbZBNPR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 10:17:28 -0500
Received: (qmail 32450 invoked by uid 107); 14 Feb 2009 15:17:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 14 Feb 2009 10:17:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Feb 2009 10:17:25 -0500
Content-Disposition: inline
In-Reply-To: <m3skmhteuk.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109872>

On Sat, Feb 14, 2009 at 03:52:56AM -0800, Jakub Narebski wrote:

> > -static const char git_config_set_usage[] =
> > -"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty] | --edit | -e ]";
> > +static const char *const builtin_config_usage[] = {
> > +	"git config [options]",
> > +	NULL
> > +};
> 
> Just asking: why this change?

If you are asking about this specific hunk, it is because parse-options
will generate the list of options.

-Peff
