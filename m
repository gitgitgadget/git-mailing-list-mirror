From: Jeff King <peff@peff.net>
Subject: Re: Question re. git remote repository
Date: Wed, 16 Jan 2013 10:21:56 -0800
Message-ID: <20130116182156.GB4426@sigill.intra.peff.net>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca>
 <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Lang, David" <David.Lang@uhn.ca>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:22:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXd6-00043t-5M
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199Ab3APSWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:22:03 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35456 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757179Ab3APSWA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:22:00 -0500
Received: (qmail 14372 invoked by uid 107); 16 Jan 2013 18:23:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 16 Jan 2013 13:23:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Jan 2013 10:21:56 -0800
Content-Disposition: inline
In-Reply-To: <20130116220615.48c159546bccfa5b9cd9028e@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213792>

On Wed, Jan 16, 2013 at 10:06:15PM +0400, Konstantin Khomoutov wrote:

> > In regards to the repositories, I think I understand correctly that
> > each developer will have a local repository that they will work
> > from, and that there will also be a remote repository (origin) that
> > will hold the original version of the project.

Note that this is just one common topology for setting up repos (and it
is probably the simplest). Others are described here:

  http://git-scm.com/book/en/Distributed-Git-Distributed-Workflows

> > Ideally we'd prefer to simply create our remote repository on a drive
> > of one of our local network servers. Is this possible?
> 
> Yes, this is possible, but it's not advised to keep such a "reference"
> repository on an exported networked drive for a number of reasons (both
> performance and bug-free operation).

I agree that performance is not ideal (although if you are on a fast
LAN, it probably would not matter much), but I do not recall any
specific bugs in that area. Can you elaborate?

-Peff
