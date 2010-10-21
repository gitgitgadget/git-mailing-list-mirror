From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: treat non-existent config files as empty
Date: Thu, 21 Oct 2010 13:00:46 -0400
Message-ID: <20101021170046.GA15667@sigill.intra.peff.net>
References: <20101021144544.GA18901@sigill.intra.peff.net>
 <20101021164708.GD3732@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 19:00:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8yUw-0005gx-LQ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 19:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab0JURAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 13:00:06 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42707 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379Ab0JURAF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 13:00:05 -0400
Received: (qmail 7762 invoked by uid 111); 21 Oct 2010 17:00:04 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 Oct 2010 17:00:04 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 13:00:46 -0400
Content-Disposition: inline
In-Reply-To: <20101021164708.GD3732@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159525>

On Thu, Oct 21, 2010 at 11:47:08AM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >   1. Does it still error on GIT_CONFIG=/nonexistent? I said then I
> >      hadn't tested. I just did, and it does still produce an error.
> 
> Maybe it would make sense to squash in something like this, then.

Yes, I think it's worth adding those tests. Thanks.

-Peff
