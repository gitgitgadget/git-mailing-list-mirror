From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: detect extra arguments
Date: Thu, 29 Oct 2009 12:06:15 -0400
Message-ID: <20091029160614.GB7622@sigill.intra.peff.net>
References: <20091029081030.GA11213@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 17:06:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3XW3-00041Y-0I
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 17:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbZJ2QGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 12:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbZJ2QGN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 12:06:13 -0400
Received: from peff.net ([208.65.91.99]:42080 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753226AbZJ2QGM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 12:06:12 -0400
Received: (qmail 22624 invoked by uid 107); 29 Oct 2009 16:09:57 -0000
Received: from 65-121-75-131.dia.static.qwest.net (HELO sigill.intra.peff.net) (65.121.75.131)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 29 Oct 2009 12:09:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Oct 2009 12:06:15 -0400
Content-Disposition: inline
In-Reply-To: <20091029081030.GA11213@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131607>

On Thu, Oct 29, 2009 at 03:10:30AM -0500, Jonathan Nieder wrote:

> If git clone is given more than two non-option arguments, it
> silently throws away all but the first one.  Complain instead.
> [...]
> +	if (argc > 2)
> +		die("Too many arguments.");
> +

Should we maybe be showing the usage in this case?

>  	if (argc == 0)
>  		die("You must specify a repository to clone.");

Probably we should do the same here, too.

-Peff
