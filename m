From: Jeff King <peff@peff.net>
Subject: Re: [RFD/BUG?] git show with tree/commit
Date: Tue, 12 Apr 2016 12:34:21 -0400
Message-ID: <20160412163420.GA23462@sigill.intra.peff.net>
References: <570D154D.6090006@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 12 18:34:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq1Gm-000573-H0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 18:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333AbcDLQeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 12:34:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:48069 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933265AbcDLQeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 12:34:24 -0400
Received: (qmail 21965 invoked by uid 102); 12 Apr 2016 16:34:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 12:34:23 -0400
Received: (qmail 8376 invoked by uid 107); 12 Apr 2016 16:34:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 12:34:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Apr 2016 12:34:21 -0400
Content-Disposition: inline
In-Reply-To: <570D154D.6090006@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291278>

On Tue, Apr 12, 2016 at 05:33:33PM +0200, Michael J Gruber wrote:

> $ git show cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
> tree cab2cdadfda8e8e8631026443b11d3ed6e7ba517:
> 
> .gitattributes
> .gitignore
> .mailmap
> ...

As Junio pointed out, the colon here is not syntactic, but from the
original object name you gave it. But here...

> $ git show 04050d37b1676ba8da277be1902513049b45413a:
> tree 04050d37b1676ba8da277be1902513049b45413a
> 
> .gitattributes
> .gitignore
> .mailmap
> ...

...it is missing. Did you mean to omit it from the command-line?

-Peff
