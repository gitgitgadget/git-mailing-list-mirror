From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] config: add options to list only variable names
Date: Wed, 27 May 2015 17:08:26 -0400
Message-ID: <20150527210826.GD22815@peff.net>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
 <20150527210438.GB22815@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 27 23:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxiYz-0002Qp-SE
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 23:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbbE0VI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 17:08:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:36897 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751575AbbE0VI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 17:08:29 -0400
Received: (qmail 14305 invoked by uid 102); 27 May 2015 21:08:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 16:08:29 -0500
Received: (qmail 10657 invoked by uid 107); 27 May 2015 21:08:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 17:08:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 17:08:26 -0400
Content-Disposition: inline
In-Reply-To: <20150527210438.GB22815@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270097>

On Wed, May 27, 2015 at 05:04:38PM -0400, Jeff King wrote:

> > -'git config' [<file-option>] [-z|--null] -l | --list
> > +'git config' [<file-option>] [-z|--null] -l | --list | --list-name
> 
> s/list-name/&s/, to match the code (and your commit message).

Doh, just saw your "1.5".

FWIW, I expected "PATCH 1.5/2" to be "eh, I should have put this in
between patches 1 and 2". I expect a re-roll to be "v1.5" (or just
"v2").

This was the only real error in the patch, so your 1.5 looks OK to me.
Though I hope you will consider my other suggestions, too.

-Peff
