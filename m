From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http.c: Spell the null pointer as NULL
Date: Tue, 15 Oct 2013 18:03:26 -0400
Message-ID: <20131015220326.GA4927@sigill.intra.peff.net>
References: <525DB9B6.8040701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Oct 16 00:03:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWCiE-0002gD-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933597Ab3JOWDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:03:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:49982 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759122Ab3JOWDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:03:30 -0400
Received: (qmail 23956 invoked by uid 102); 15 Oct 2013 22:03:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Oct 2013 17:03:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Oct 2013 18:03:26 -0400
Content-Disposition: inline
In-Reply-To: <525DB9B6.8040701@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236204>

On Tue, Oct 15, 2013 at 10:55:02PM +0100, Ramsay Jones wrote:

> Commit 1bbcc224 ("http: refactor options to http_get_*", 28-09-2013)
> changed the type of final 'options' argument of the http_get_file()
> function from an int to an 'struct http_get_options' pointer.
> However, it neglected to update the (single) call site. Since this
> call was passing '0' to that argument, it was (correctly) being
> interpreted as a null pointer. Change to argument to NULL.

Thanks, patch is obviously correct (and the cause was just oversight on
my part).

-Peff
