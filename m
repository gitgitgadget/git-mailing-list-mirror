From: Jeff King <peff@peff.net>
Subject: Re: Host refs to push are chosen (documentation error)?
Date: Wed, 17 Feb 2010 23:43:37 -0500
Message-ID: <20100218044337.GA10970@coredump.intra.peff.net>
References: <201002171627.57599.arvidjaar@mail.ru>
 <be6fef0d1002170539v4384b355lb6be3e2f19b7b87b@mail.gmail.com>
 <32541b131002170939l261f396cpbee45f652fd96c77@mail.gmail.com>
 <20100218011620.GA15870@coredump.intra.peff.net>
 <32541b131002171751n454081a9w90f2957d7a40d87@mail.gmail.com>
 <7vaav7wb8v.fsf@alter.siamese.dyndns.org>
 <20100218021010.GA21693@coredump.intra.peff.net>
 <7vocjnuqzy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 05:43:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhyEx-0006KW-Pl
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 05:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab0BREnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 23:43:42 -0500
Received: from peff.net ([208.65.91.99]:47806 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab0BREnl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 23:43:41 -0500
Received: (qmail 25875 invoked by uid 107); 18 Feb 2010 04:43:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 17 Feb 2010 23:43:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Feb 2010 23:43:37 -0500
Content-Disposition: inline
In-Reply-To: <7vocjnuqzy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140295>

On Wed, Feb 17, 2010 at 08:06:41PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -217,10 +217,8 @@ them easily.
> >  MERGE_HEAD records the commit(s) you are merging into your branch
> >  when you run 'git merge'.
> >  +
> > -For any of the `$GIT_DIR/refs` cases above, packed refs from
> > -`$GIT_DIR/packed-refs` may be substituted (e.g., a line with
> > -`refs/heads/master` in the packed-refs file would have the same
> > -precedence as the file `$GIT_DIR/refs/heads/master`).
> > +Note that any of the `refs/*` cases above may come either from
> > +the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
> 
> This makes it much more clear.  Thanks.

Do you want a repost with the squashed text?

-Peff
