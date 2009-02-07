From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] give exclude mechanism a debug option
Date: Sat, 7 Feb 2009 06:46:28 -0500
Message-ID: <20090207114628.GC18079@coredump.intra.peff.net>
References: <20090207064221.GA14856@coredump.intra.peff.net> <20090207064454.GB14906@coredump.intra.peff.net> <7vljsizog1.fsf@gitster.siamese.dyndns.org> <7vhc36zo96.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 12:49:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVlgI-0002Yc-Mv
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 12:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbZBGLqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 06:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbZBGLqb
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 06:46:31 -0500
Received: from peff.net ([208.65.91.99]:35690 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922AbZBGLqa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 06:46:30 -0500
Received: (qmail 20625 invoked by uid 107); 7 Feb 2009 11:46:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 07 Feb 2009 06:46:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Feb 2009 06:46:28 -0500
Content-Disposition: inline
In-Reply-To: <7vhc36zo96.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108841>

On Fri, Feb 06, 2009 at 11:42:45PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>   1. Doing it as a debug environment variable is hack-ish.
> >>      A nicer interface would be a .gitignore equivalent of
> >>      "git check-attr".
> >
> > Correct.
> 
> I suspect that ls-files would be the good match for it.  Wasn't the
> exclude mechanism originally done for that command to begin with?

I think you are envisioning something like "which files are excluded,
and what patterns matched them?" which ls-files is perhaps a good fit
for. I was imagining something more like "which patterns are affecting
this particular path?" which you could feed the output of a failed "git
add" to.

-Peff
