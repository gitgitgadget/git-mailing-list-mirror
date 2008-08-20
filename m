From: Jeff King <peff@peff.net>
Subject: Re: git am with MIME
Date: Wed, 20 Aug 2008 17:58:33 -0400
Message-ID: <20080820215833.GA8137@coredump.intra.peff.net>
References: <48AAEBB6.9070306@gmail.com> <20080819170731.GA2424@coredump.intra.peff.net> <20080820195734.GE16626@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:59:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVviP-0007xB-Rr
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbYHTV6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 17:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbYHTV6f
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:58:35 -0400
Received: from peff.net ([208.65.91.99]:3693 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083AbYHTV6f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 17:58:35 -0400
Received: (qmail 29401 invoked by uid 111); 20 Aug 2008 21:58:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 20 Aug 2008 17:58:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 17:58:33 -0400
Content-Disposition: inline
In-Reply-To: <20080820195734.GE16626@blimp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93060>

On Wed, Aug 20, 2008 at 09:57:34PM +0200, Alex Riesen wrote:

> > -	strbuf_remove(&f, at - f.buf, el + 1);
> > +	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
>  +	strbuf_remove(&f, at - f.buf, el + !!at[el]);
> 
> (Some people'll kill me for that :)

Ewwww. ;)

-Peff
