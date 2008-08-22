From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 20:40:52 -0400
Message-ID: <20080822004052.GA30476@coredump.intra.peff.net>
References: <48ACB29C.7000606@zytor.com> <48ADE2FF.4080704@acm.org> <48ADF542.9010105@zytor.com> <48AE035C.8000504@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Federico Lucifredi <flucifredi@acm.org>
X-From: git-owner@vger.kernel.org Fri Aug 22 02:42:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWKj2-0003oz-Df
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 02:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbYHVAkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 20:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754440AbYHVAkz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 20:40:55 -0400
Received: from peff.net ([208.65.91.99]:3164 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbYHVAkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 20:40:55 -0400
Received: (qmail 11148 invoked by uid 111); 22 Aug 2008 00:40:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 21 Aug 2008 20:40:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2008 20:40:52 -0400
Content-Disposition: inline
In-Reply-To: <48AE035C.8000504@acm.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93237>

On Thu, Aug 21, 2008 at 08:07:56PM -0400, Federico Lucifredi wrote:

> I am all for bass-ackwards compatibility, and I think the suggestion of  
> going on "man foo bar" :
>
>  1) look for foo-bar; if success, terminate search
>  2) look for foo
>  3) look for bar
>  ....
>
> may be acceptable - I don't see drawbacks at a first glance, and it would 
> allow for groups of pages to be meaningful.

Well, the drawback is that there exist X-Y such that X and Y both have
manpages (e.g., cvs-debc on my debian box). So we are assuming that the
risk is acceptably low of somebody asking for "man X Y", wanting two
manpages, and that X and Y fit this pattern.

Personally I have never ever wanted to see two manpages from one man
invocation, so I have no real problem with that assumption.

> Are you willing to put your patch where your mouth is? :-)

I've never looked at man code before, but there seem to be at least two
man packages for Linux. My boxes have man-db 2.5.2.

-Peff
