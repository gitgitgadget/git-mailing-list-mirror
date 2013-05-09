From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/5] allow more sources for config values
Date: Fri, 10 May 2013 00:41:25 +0200
Message-ID: <20130509224124.GD30774@sigill.intra.peff.net>
References: <20130509161636.GB3526@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri May 10 00:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZWs-0001UI-Pf
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 00:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756450Ab3EIWla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 18:41:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:42308 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753443Ab3EIWl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 18:41:28 -0400
Received: (qmail 16514 invoked by uid 102); 9 May 2013 22:41:51 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 May 2013 17:41:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 May 2013 00:41:25 +0200
Content-Disposition: inline
In-Reply-To: <20130509161636.GB3526@book-mint>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223792>

On Thu, May 09, 2013 at 06:16:36PM +0200, Heiko Voigt wrote:

> This is an update with the comments of the second iteration[1] incorporated.
> 
> [1] http://thread.gmane.org/gmane.comp.version-control.git/217811
> 
> Heiko Voigt (5):
>   config: factor out config file stack management
>   config: drop cf validity check in get_next_char()
>   config: make parsing stack struct independent from actual data source
>   teach config --blob option to parse config from database
>   do not die when error in config parsing of buf occurs

Thanks, I think it looks good except for a few minor things I mentioned.

-Peff
