From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] diff-highlight: add maxhunksize config option
Date: Tue, 3 Nov 2015 16:46:00 -0500
Message-ID: <20151103214600.GD22484@sigill.intra.peff.net>
References: <1446516334-27652-1-git-send-email-jonathan.lebon@gmail.com>
 <1446516334-27652-5-git-send-email-jonathan.lebon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Lebon <jonathan.lebon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:46:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtjP7-0000DU-PL
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbbKCVqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:46:05 -0500
Received: from cloud.peff.net ([50.56.180.127]:52317 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932366AbbKCVqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:46:04 -0500
Received: (qmail 2666 invoked by uid 102); 3 Nov 2015 21:46:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 15:46:03 -0600
Received: (qmail 29010 invoked by uid 107); 3 Nov 2015 21:46:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Nov 2015 16:46:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Nov 2015 16:46:00 -0500
Content-Disposition: inline
In-Reply-To: <1446516334-27652-5-git-send-email-jonathan.lebon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280823>

On Mon, Nov 02, 2015 at 09:05:34PM -0500, Jonathan Lebon wrote:

> As the size of the hunk gets bigger, it becomes harder to jump back and
> forth between the removed and added lines, and highlighting becomes less
> beneficial. We add a new config option called
> 
> 	diff-highlight.maxhunksize
> 
> which controls the maximum size of the hunk allowed for which
> highlighting is still performed. The default value is set to 20.

I think this makes sense. I'm pleased it is here to limit the problem
space for patch 3, but I think it has value on its own as a heuristic.

-Peff
