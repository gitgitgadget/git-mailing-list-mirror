From: Jeff King <peff@peff.net>
Subject: Re: cvs import and internal plumbing commands
Date: Tue, 21 Jul 2009 22:59:34 -0400
Message-ID: <20090722025934.GB31254@coredump.intra.peff.net>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com>
 <20090716100121.GA6742@coredump.intra.peff.net>
 <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com>
 <20090717214523.GA29955@coredump.intra.peff.net>
 <7vprbwvzu7.fsf@alter.siamese.dyndns.org>
 <20090720153400.GE5347@coredump.intra.peff.net>
 <24155F0E-E467-48EC-9E83-254877B4E786@gmail.com>
 <7vmy6x35ur.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antony Stubbs <antony.stubbs@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 04:59:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTS3O-0003AA-Ib
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 04:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbZGVC7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 22:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbZGVC7b
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 22:59:31 -0400
Received: from peff.net ([208.65.91.99]:57714 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755933AbZGVC7a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 22:59:30 -0400
Received: (qmail 2721 invoked by uid 107); 22 Jul 2009 03:01:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 21 Jul 2009 23:01:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jul 2009 22:59:34 -0400
Content-Disposition: inline
In-Reply-To: <7vmy6x35ur.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123737>

On Tue, Jul 21, 2009 at 05:43:08PM -0700, Junio C Hamano wrote:

> Note that my suggestion on $PATH=$(git --exec-path):$PATH was a response
> to Jeff's message, which was the same message your patch was response to.
> In other words, our messages crossed, and I do not have an issue with
> fixing this either way.  If your patch fixes the issue correctly that
> would be great.

I am still confused about what the "issue" is. That is, why this is a
bugfix for Anthony instead of simply a code modernization. IOW, I think
there is something else broken about his install if cvsimport cannot
find the dashed plumbing commands, and we may simply be papering over
it.

That being said, I think the code modernization is of value itself, so
let's do it.

> Has anybody reviewed the submitted patch?  I do not use cvsimport these
> days anymore for anything real, so the only assurance I have on your patch
> so far are my eyeballs and whatever tests done in test scripts in the t/
> directory.  Independent "Yeah, it looks good and it works for me" would
> make me feel a bit safer.

I am lucky enough not to have needed git-cvsimport for some time, so I
cannot say "it works for me." But I have read the patch; I didn't see
any errors in the conversion, and assuming the conversion is done
correctly, the behavior should be otherwise identical. So

Acked-by: Jeff King <peff@peff.net>

-Peff
