From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 17:38:48 -0400
Message-ID: <20090424213848.GA14493@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Apr 24 23:40:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxT8L-00080n-S9
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 23:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbZDXVi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 17:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbZDXVi6
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 17:38:58 -0400
Received: from peff.net ([208.65.91.99]:36922 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204AbZDXVi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 17:38:58 -0400
Received: (qmail 31711 invoked by uid 107); 24 Apr 2009 21:39:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 17:39:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 17:38:48 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117494>

On Fri, Apr 24, 2009 at 05:34:00PM -0400, Daniel Barkalow wrote:

> I'd say that blobs and trees are an implementation detail of "the full 
> content of a version of the project", not something conceptually 
> important. Likewise, the date representation used in commits isn't 

I disagree. I think it's important to note that trees and blobs have a
name, and you can refer to them. Once you know that, the fact that you
can do:

  git show master
  git show master:Documentation
  git show master:Makefile

just makes sense. You are always just specifying an object, but the type
is different for each (and show "does the right thing" based on object
type).

No, that isn't critical for understanding how _commit_ operations work,
but I think that is exactly the sort of conceptual knowledge that let
people use git more fully.

-Peff
