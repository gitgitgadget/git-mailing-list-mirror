From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fix `git rev-list --show-notes HEAD` when there are no
 notes
Date: Mon, 24 Aug 2015 10:43:29 -0400
Message-ID: <20150824144328.GA2151@sigill.intra.peff.net>
References: <0LZlZ2-1Z1Zyn1mzk-00lZ3Z@mail.gmx.com>
 <20150823174309.GA24735@sigill.intra.peff.net>
 <98f2f674e384ac3af38e305165135a60@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 24 16:43:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTsyI-0005PZ-6J
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 16:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbbHXOnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 10:43:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:49039 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753772AbbHXOnb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 10:43:31 -0400
Received: (qmail 20984 invoked by uid 102); 24 Aug 2015 14:43:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 09:43:31 -0500
Received: (qmail 23944 invoked by uid 107); 24 Aug 2015 14:43:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Aug 2015 10:43:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Aug 2015 10:43:29 -0400
Content-Disposition: inline
In-Reply-To: <98f2f674e384ac3af38e305165135a60@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276448>

On Mon, Aug 24, 2015 at 12:23:52PM +0200, Johannes Schindelin wrote:

> You're right. I think the best approach for now is to error out when
> `--show-notes` is passed to rev-list. Do you agree?

Yes (I imagine you didn't yet read my follow-up patch when you wrote
this). :)

-Peff
