From: Jeff King <peff@peff.net>
Subject: Re: git 1.6.1 on AIX 5.3
Date: Wed, 28 Jan 2009 02:42:04 -0500
Message-ID: <20090128074204.GA31951@coredump.intra.peff.net>
References: <A8D76E61-4442-4640-BD0C-84085375E6F1@gmail.com> <20090126210027.GG27604@coredump.intra.peff.net> <e2b179460901261432r601fa006iaf04fc42487e7235@mail.gmail.com> <9E98493A-B17A-4905-8BEA-3E0B837961D6@gmail.com> <e2b179460901270210q69fe1e42xb801553e4e9005e9@mail.gmail.com> <BAD975AD-323D-4278-8405-0B57E7202797@gmail.com> <20090128070114.GB19165@coredump.intra.peff.net> <7v4ozjx4ni.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Perry Smith <pedzsan@gmail.com>,
	Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:43:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS558-0000hT-3L
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbZA1HmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZA1HmH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:42:07 -0500
Received: from peff.net ([208.65.91.99]:47544 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbZA1HmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:42:06 -0500
Received: (qmail 19689 invoked by uid 107); 28 Jan 2009 07:42:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 02:42:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 02:42:04 -0500
Content-Disposition: inline
In-Reply-To: <7v4ozjx4ni.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107497>

On Tue, Jan 27, 2009 at 11:37:21PM -0800, Junio C Hamano wrote:

> >> Just to be sure we are on the same page.  My directory structure has a
> >> top/src/git-1.6.1 and top/build/git.1.6.1.  The src/git-1.6.1 is the
> >> tar ball.  The  build/git-1.6.1 starts out empty.  I cd into it and
> >> then do: ../../src/git-1.6.1/configure <options>  After this
> >> completes, you can do "make".
> >
> > I don't see how this would work without automake support, which git does
> > not have.
> 
> ... nor want to have ;-).

Heh. Yes, in case there was any confusion: I don't want my statement in
any way to be construed as a suggestion to support automake.

I would not be opposed to it if it somehow enhanced some users'
experience without bothering people who didn't want to touch it (like
the way that autoconf support is implemented). But I don't see how that
would be possible.

-Peff
