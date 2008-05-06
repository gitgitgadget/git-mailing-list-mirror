From: Jeff King <peff@peff.net>
Subject: Re: To page or not to page
Date: Tue, 6 May 2008 01:53:45 -0400
Message-ID: <20080506055344.GA26409@sigill.intra.peff.net>
References: <70F76C0E-E16D-4047-873D-7FD19FDBB55D@sb.org> <20080502054508.GA28506@sigill.intra.peff.net> <20080502060930.GA1079@sigill.intra.peff.net> <7vd4o5xm62.fsf@gitster.siamese.dyndns.org> <20080502125553.GB2923@sigill.intra.peff.net> <7v1w4ky3hh.fsf@gitster.siamese.dyndns.org> <20080506055128.GA26311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 07:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtG8G-00089H-2r
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 07:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbYEFFxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 01:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752608AbYEFFxn
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 01:53:43 -0400
Received: from peff.net ([208.65.91.99]:3066 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbYEFFxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 01:53:43 -0400
Received: (qmail 28885 invoked by uid 111); 6 May 2008 05:53:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 06 May 2008 01:53:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 May 2008 01:53:45 -0400
Content-Disposition: inline
In-Reply-To: <20080506055128.GA26311@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81332>

On Tue, May 06, 2008 at 01:51:28AM -0400, Jeff King wrote:

> So anyway, here is the less invasive version.
> 
> ---
>  git.c |   48 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 44 insertions(+), 4 deletions(-)

NB: this of course works only for git-* that is a builtin, and does
nothing for an external "git-foo" (of course it does work for "git foo"
in that case).

We need to decide if that is a showstopper, or if it is OK for that
inconsistency to live (I don't think manually fixing all such git-foo is
possible, since they could be user scripts).

-Peff
