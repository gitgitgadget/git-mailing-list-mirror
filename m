From: Jeff King <peff@peff.net>
Subject: Re: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 19:44:07 -0400
Message-ID: <20160412234406.GC2210@sigill.intra.peff.net>
References: <570D78CC.9030807@zytor.com>
 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
 <1460502934.5540.71.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:44:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7yi-0001SM-KK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966707AbcDLXoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:44:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:48312 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932781AbcDLXoK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:44:10 -0400
Received: (qmail 15420 invoked by uid 102); 12 Apr 2016 23:44:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 19:44:09 -0400
Received: (qmail 12226 invoked by uid 107); 12 Apr 2016 23:44:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Apr 2016 19:44:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Apr 2016 19:44:07 -0400
Content-Disposition: inline
In-Reply-To: <1460502934.5540.71.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291328>

On Tue, Apr 12, 2016 at 07:15:34PM -0400, David Turner wrote:

> It would be possible, of course, to GPG-sign the entire commit's
> transitive data (rather than just the SHA1s of same).  But as far as I
> know, that is not ever what is done.

There is a project called git-evtag which does this, and you can find
mention on the list. The problem is just that it's not very efficient.
That's maybe OK for tag-signing, which is relatively rare. It wouldn't
really work for commit-signing.

-Peff
