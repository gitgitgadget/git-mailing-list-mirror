From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] subtree/Makefile: Standardize (esp. for packagers)
Date: Sat, 26 Apr 2014 22:51:50 -0400
Message-ID: <20140427025150.GA26382@sigill.intra.peff.net>
References: <1398304336-1879-1-git-send-email-nod.helm@gmail.com>
 <CAHYYfeGNDLVxzP6zMyJnSi8GxpQaUKGAkqaLfXbZ=8B1k7vvyQ@mail.gmail.com>
 <3cb4338e-de68-404d-86dc-70cac7e13606@email.android.com>
 <20140426072520.GB7558@sigill.intra.peff.net>
 <6a7bcc79-d9c3-4cf8-8f3b-a6a16298c221@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 04:52:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeFCM-0005Wz-VG
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 04:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbaD0Cvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 22:51:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:39347 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751293AbaD0Cvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 22:51:52 -0400
Received: (qmail 21600 invoked by uid 102); 27 Apr 2014 02:51:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Apr 2014 21:51:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Apr 2014 22:51:50 -0400
Content-Disposition: inline
In-Reply-To: <6a7bcc79-d9c3-4cf8-8f3b-a6a16298c221@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247191>

On Sun, Apr 27, 2014 at 12:35:13PM +1000, James Denholm wrote:

> >Do we even make [subproject and mainline] anymore? It looks like they are part
> >of the tests, but the whole test script runs inside its own trash
> >directory.
> 
> subproject and mainline are actually made in  contrib/subtree,
> but I'll look at perhaps "fixing" that when I split the proposal
> into a series as you suggest.

Are they? I couldn't find any reference to them as directories except in
the test script, and doing a "make" from contrib/subtree didn't create
them. I'll leave it to you to investigate further whether the "clean"
rules are cruft or not, but certainly if they are, cleaning up cruft is
a good thing.

-Peff
