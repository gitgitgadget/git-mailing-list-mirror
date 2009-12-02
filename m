From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 2 Dec 2009 14:24:25 -0500
Message-ID: <20091202192425.GC30778@coredump.intra.peff.net>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
 <20091202171117.GY31763@genesis.frugalware.org>
 <7vpr6xgtxn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 20:24:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFuoS-0001dR-4y
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbZLBTYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbZLBTYT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:24:19 -0500
Received: from peff.net ([208.65.91.99]:51482 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752305AbZLBTYS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:24:18 -0500
Received: (qmail 27124 invoked by uid 107); 2 Dec 2009 19:28:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Dec 2009 14:28:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Dec 2009 14:24:25 -0500
Content-Disposition: inline
In-Reply-To: <7vpr6xgtxn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134376>

On Wed, Dec 02, 2009 at 09:35:48AM -0800, Junio C Hamano wrote:

> > Is there any documentation describing what does parse_date() accept?
> [...]
> The above are all supported (you can label 2 as ISO even though the
> official ISO8601 wants "T" instead of " " between date and time).
> 
> For more amusing ones, see
> 
>     http://article.gmane.org/gmane.comp.version-control.git/12241
> 
> and follow the discussion there ;-)

Aren't the amusing ones the result of approxidate, and not parse_date?
At least that is my recollection from working on the date code when I
ate 30 hot dogs last August.

-Peff
