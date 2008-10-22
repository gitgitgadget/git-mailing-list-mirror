From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase-i-p: delay saving current-commit to REWRITTEN
	if squashing
Date: Wed, 22 Oct 2008 15:15:17 -0400
Message-ID: <20081022191517.GB31568@coredump.intra.peff.net>
References: <cover.1224055978.git.stephen@exigencecorp.com> <759654ef1f1781cd2b102e21c6f972b065560398.1224055978.git.stephen@exigencecorp.com> <20081022125149.GA17092@coredump.intra.peff.net> <7v4p34v42e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Haberman <stephen@exigencecorp.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 21:16:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsjC5-0000Z8-Sw
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 21:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbYJVTPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 15:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbYJVTPU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 15:15:20 -0400
Received: from peff.net ([208.65.91.99]:1524 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752895AbYJVTPT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 15:15:19 -0400
Received: (qmail 3175 invoked by uid 111); 22 Oct 2008 19:15:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 15:15:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 15:15:17 -0400
Content-Disposition: inline
In-Reply-To: <7v4p34v42e.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98893>

On Wed, Oct 22, 2008 at 12:10:33PM -0700, Junio C Hamano wrote:

> >> +		if [ "$fast_forward" == "t" ]
> > This one even fails on my Linux box. :) "==" is a bash-ism.
> 
> Thanks.

You're very welcome, and sorry for not saving you a little time by
writing my complaint in patch form in the first place.

-Peff
