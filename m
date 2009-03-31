From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] Add configuration variable for sign-off to format-patch
Date: Tue, 31 Mar 2009 22:43:48 +0200
Message-ID: <20090331204338.GA88381@macbook.lan>
References: <20090331185018.GD72569@macbook.lan> <20090331200457.GA23879@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:45:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lokpn-0007Dz-Ay
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbZCaUnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753094AbZCaUnw
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:43:52 -0400
Received: from darksea.de ([83.133.111.250]:34045 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752360AbZCaUnv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:43:51 -0400
Received: (qmail 14709 invoked from network); 31 Mar 2009 22:43:35 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 31 Mar 2009 22:43:35 +0200
Content-Disposition: inline
In-Reply-To: <20090331200457.GA23879@coredump.intra.peff.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115315>

On Tue, Mar 31, 2009 at 04:04:57PM -0400, Jeff King wrote:
> On Tue, Mar 31, 2009 at 08:50:19PM +0200, Heiko Voigt wrote:
> 
> > If you regularly create patches which require a Signed-off: line you may
> > want to make it your default to add that line. It also helps you not to forget
> > to add the -s/--signoff switch.
> 
> I personally have no problem with such an option, but it has been argued
> against before. E.g.:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/32522
>   http://article.gmane.org/gmane.comp.version-control.git/51780
> 
> There is also some discussion here indicating that it might be accepted:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/103939

I see, it is of course true that you should not just sign off
everything without thinking about it.

However I always read through my messages before sending them and it is
way easier to delete that line than typing/copying it.

I suppose if A changes a patch which originated from B he also needs to
be nice and delete that the sign-off line from B (at least initially).

I don't know but if I am preparing to send a patch and *see* my
signed-off line in the message I am conscious about it! I see this more
as another customization. Some people tend to forget to add the
signed-off and others might tend to forget to delete it. It should be on
you to find out what type you are.

cheers Heiko
