From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Wed, 29 Apr 2009 02:34:48 -0400
Message-ID: <20090429063448.GA22448@coredump.intra.peff.net>
References: <m24owgqy0j.fsf@boostpro.com> <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <4E155CC5-B20A-4B79-8CBF-9D1E0E36920F@boostpro.com> <20090425003531.GA18125@coredump.intra.peff.net> <1A9F6DB0-983F-4A5B-B3B7-33227C11F36A@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 08:35:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz3Nk-0005DL-Dz
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 08:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbZD2Gev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 02:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbZD2Gev
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 02:34:51 -0400
Received: from peff.net ([208.65.91.99]:59449 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750965AbZD2Geu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 02:34:50 -0400
Received: (qmail 3122 invoked by uid 107); 29 Apr 2009 06:35:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 29 Apr 2009 02:35:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2009 02:34:48 -0400
Content-Disposition: inline
In-Reply-To: <1A9F6DB0-983F-4A5B-B3B7-33227C11F36A@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117855>

On Fri, Apr 24, 2009 at 08:53:37PM -0400, David Abrahams wrote:

>> Actually, it is not the generally of trees that I think is interesting
>> there, but the generality of _objects_. That is, each of those things is
>> a first-class object, and has a unique name by which it can be  
>> referred.
>
> I'm sorry, but I think most people would find that so unremarkable that 
> making a big deal about it would lead to "what am I missing here"  
> confusion.  Maybe a person who's exclusively used CVS (or older)  
> technologies before coming to Git would be happy to know that, but it's 
> sort of obvious.  In CVS the lack of first-class directories sticks out 
> like a sore thumb.

Sadly, I was away from email all weekend and so missed the ensuing storm
in this thread. :) However, I did want to respond to this one point.

To me (and I am talking from personal experience, so it really may be
_just_ me), an important part of understanding git was understanding the
object storage. That is, half of the idea of git is a big database of
content-addressable objects. The _other_ half is the actual VCS built on
top of it. ;)

And by understanding that, and the places where objects refer to each
other (commits point to other commits and to trees, trees point to
blobs, blobs are always leaves), I find it easier to understand what
each operation is doing. And that if I'm unsure of something, I can
always inspect it at many levels.

I don't know. Maybe that is too low-level for most people. I did end up
working on git, so perhaps I am inordinately interested.

-Peff
