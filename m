From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 20:35:31 -0400
Message-ID: <20090425003531.GA18125@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <4E155CC5-B20A-4B79-8CBF-9D1E0E36920F@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 02:37:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxVtM-0006wz-Bz
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 02:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbZDYAfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 20:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbZDYAfm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 20:35:42 -0400
Received: from peff.net ([208.65.91.99]:46272 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbZDYAfl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 20:35:41 -0400
Received: (qmail 638 invoked by uid 107); 25 Apr 2009 00:35:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 20:35:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 20:35:31 -0400
Content-Disposition: inline
In-Reply-To: <4E155CC5-B20A-4B79-8CBF-9D1E0E36920F@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117530>

On Fri, Apr 24, 2009 at 08:19:18PM -0400, David Abrahams wrote:

>>  git show master
>>  git show master:Documentation
>>  git show master:Makefile
>>
> I don't believe you need to know about trees and blobs to make sense of 
> that.  Those are just directories and files.  The whole idea that trees 
> are a more-general thing that could be used to represent something other 
> than directory structure and blobs could be used to represent something 
> other than file contents is way below most peoples' need-to-know 
> threshold.

Actually, it is not the generally of trees that I think is interesting
there, but the generality of _objects_. That is, each of those things is
a first-class object, and has a unique name by which it can be referred.
The examples above are just _one_ of the ways you can refer to the same
objects.

-Peff
