From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 04:39:57 -0400
Message-ID: <20071019083957.GA32400@coredump.intra.peff.net>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org> <20071019075725.GA29436@coredump.intra.peff.net> <20071019080755.GO14735@spearce.org> <864pgncy9y.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 10:40:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IinOz-0002JJ-6Y
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 10:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbXJSIkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 04:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbXJSIkA
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 04:40:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4989 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754041AbXJSIkA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 04:40:00 -0400
Received: (qmail 10732 invoked by uid 111); 19 Oct 2007 08:39:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 04:39:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 04:39:57 -0400
Content-Disposition: inline
In-Reply-To: <864pgncy9y.fsf@lola.quinscape.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61677>

On Fri, Oct 19, 2007 at 10:19:05AM +0200, David Kastrup wrote:

> I don't see why.  80 columns has been the standard layout for
> something like 40 or 50 years or so.  It is the standard punch card
> width and required to display Fortran code fitted to this width
> (column 73 to 80 are ignored in non-free-format Fortran and used for
> line identification).

I almost said that, but it seems unnecessarily restrictive. Do people
use git on handhelds (or use them to connect to decent machines that run
git)? If it's related to the actual functioning of the program, then
fine, but it seems unnecessarily strict for something that is just eye
candy anyway.

> All people using smaller terminals are used to wrapping trouble.  We

That is a good point...people on tiny screens are likely to be wrapping
on the _other_ lines anyway. I wonder how awful our progress meters look
on a tiny terminal.

Really, I'm fine with assuming an 80 char terminal. I just didn't want
to be in the position of defending it as a useful feature when somebody
complained.

-Peff
