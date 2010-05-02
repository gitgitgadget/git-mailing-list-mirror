From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/5] pretty: make %H/%h/etc respect --abbrev[-commit]
Date: Sun, 2 May 2010 00:45:06 -0400
Message-ID: <20100502044506.GA14776@coredump.intra.peff.net>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
 <1272656128-2002-3-git-send-email-wmpalmer@gmail.com>
 <7vocgzyp1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 06:45:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8R3f-0008RP-AJ
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 06:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab0EBEpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 00:45:10 -0400
Received: from peff.net ([208.65.91.99]:48968 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab0EBEpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 00:45:08 -0400
Received: (qmail 3510 invoked by uid 107); 2 May 2010 04:45:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 02 May 2010 00:45:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 May 2010 00:45:06 -0400
Content-Disposition: inline
In-Reply-To: <7vocgzyp1f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146131>

On Sat, May 01, 2010 at 08:13:00PM -0700, Junio C Hamano wrote:

> Will Palmer <wmpalmer@gmail.com> writes:
> 
> > Prior to this, the output of %H was always 40 characters long, and the
> > output of %h always DEFAULT_ABBREV characters long, without regard to
> > whether --abbrev-commit or --abbrev had been passed.
> >
> > Here we make "git log --pretty=%H --abbrev-commit" synonymous with
> > "git log --pretty=%h", and make %h/abbreviated-%H respect the length
> > specified for --abbrev.
> 
> I think it is a good change to make %h follow --abbrev, but %H should stay
> the full length no matter what (otherwise why would anybody use %H not %h?).

But I thought the point of %h was to be abbreviated? If it follows
--abbrev, then "git log --format=%h" would show the full sha1, no?

-Peff
