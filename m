From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] travis-ci: build documentation
Date: Fri, 29 Apr 2016 08:14:29 -0400
Message-ID: <20160429121429.GB27952@sigill.intra.peff.net>
References: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	stefan.naewe@atlas-elektronik.com, gitster@pobox.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 29 14:14:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw7Ji-00052S-Ei
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 14:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbcD2MOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 08:14:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:59012 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753274AbcD2MOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 08:14:32 -0400
Received: (qmail 2047 invoked by uid 102); 29 Apr 2016 12:14:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 08:14:31 -0400
Received: (qmail 20488 invoked by uid 107); 29 Apr 2016 12:14:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 08:14:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 08:14:29 -0400
Content-Disposition: inline
In-Reply-To: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292987>

On Fri, Apr 29, 2016 at 11:35:34AM +0200, larsxschneider@gmail.com wrote:

> +# The follow numbers need to be adjusted when new documentation is added.
> +test_file_count html 233
> +test_file_count xml 171
> +test_file_count 1 152

This seems like it will be really flaky and a pain in the future. I'm
not really sure what it's accomplishing, either. The earlier steps would
complain if something failed to render, wouldn't they? At some point we
have to have some faith in "make doc".

-Peff
