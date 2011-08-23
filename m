From: Jeff King <peff@peff.net>
Subject: Re: Merge after directory rename ?
Date: Tue, 23 Aug 2011 15:13:50 -0400
Message-ID: <20110823191350.GA4016@sigill.intra.peff.net>
References: <j2ru2h$cd$1@dough.gmane.org>
 <CAMOZ1BukGPZt8gJh0J4EHRrPHv5teAdnkNT+gZJa9mX=2ohFOw@mail.gmail.com>
 <CAMOZ1Bt8cP146xiDXfSA-naSOaS3AC8pUZgW12=3TMg2JGCD=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marcin =?utf-8?B?V2nFm25pY2tp?= <mwisnicki@gmail.com>,
	git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 21:13:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvwQB-0007Rv-00
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 21:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974Ab1HWTNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 15:13:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50936
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681Ab1HWTNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 15:13:53 -0400
Received: (qmail 27647 invoked by uid 107); 23 Aug 2011 19:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Aug 2011 15:14:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Aug 2011 15:13:50 -0400
Content-Disposition: inline
In-Reply-To: <CAMOZ1Bt8cP146xiDXfSA-naSOaS3AC8pUZgW12=3TMg2JGCD=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179960>

On Sun, Aug 21, 2011 at 11:53:34PM +0000, Michael Witten wrote:

> This is because git fundamentally tracks content, and paths are just
> one kind of content associated with another blob of content.
> Consequently, git really knows next to nothing about directories, so
> it's not too surprising that git doesn't bother finding such a
> DIRECTORY rename anyway (at most, git would detect a FILE rename, and
> your FILE `dir1/file2' has nothing to do with, say, the FILE
> `dir1/file1' being renamed `dir2/file1').
> 
> Still, some command line switches could be useful to help the user
> express to git what should be going on in a case such as yours.

FYI, Yann Dirson was working on some patches to detect directory
renames, but we haven't heard anything for a while. The last version I
could find was:

  http://thread.gmane.org/gmane.comp.version-control.git/163328

-Peff
