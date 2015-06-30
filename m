From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config.c: fix writing config files on Windows network
 shares
Date: Tue, 30 Jun 2015 12:00:15 -0400
Message-ID: <20150630160014.GA3953@peff.net>
References: <20150528075142.GB3688@peff.net>
 <20150528075443.GB23395@peff.net>
 <5592A8E5.2090601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Jorge <griffin@gmx.es>,
	git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:00:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9xxQ-00009R-L7
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 18:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbbF3QAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 12:00:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:53772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751804AbbF3QAT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 12:00:19 -0400
Received: (qmail 31293 invoked by uid 102); 30 Jun 2015 16:00:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 11:00:18 -0500
Received: (qmail 15973 invoked by uid 107); 30 Jun 2015 16:00:22 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 12:00:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jun 2015 12:00:15 -0400
Content-Disposition: inline
In-Reply-To: <5592A8E5.2090601@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273074>

On Tue, Jun 30, 2015 at 04:34:13PM +0200, Karsten Blees wrote:

> Renaming to an existing file doesn't work on Windows network shares if the
> target file is open.
> 
> munmap() the old config file before commit_lock_file.
> 
> Signed-off-by: Karsten Blees <blees@dcon.de>

Thanks for fixing this.

Acked-by: Jeff King <peff@peff.net>

-Peff
