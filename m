From: Jeff King <peff@peff.net>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Tue, 13 Oct 2009 01:01:52 -0400
Message-ID: <20091013050149.GA11317@sigill.intra.peff.net>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
 <1255383459.15646.10.camel@localhost>
 <20091013014332.GB13737@coredump.intra.peff.net>
 <1255407433.15646.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: sylvain@demarque.qc.ca, git@vger.kernel.org
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 07:10:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxZeu-0004CI-SJ
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 07:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbZJMFCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 01:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbZJMFCe
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 01:02:34 -0400
Received: from peff.net ([208.65.91.99]:39950 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbZJMFCd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 01:02:33 -0400
Received: (qmail 11281 invoked by uid 107); 13 Oct 2009 05:05:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 13 Oct 2009 01:05:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Oct 2009 01:01:52 -0400
Content-Disposition: inline
In-Reply-To: <1255407433.15646.12.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130128>

On Tue, Oct 13, 2009 at 06:17:13AM +0200, Daniele Segato wrote:

> > This seems to work:
> > 
> >   $ cd ~
> >   $ git init
> >   $ echo '*' >.gitignore
> >   $ echo '!.*' >.gitignore
> > 
> > > Or better: provide a list of directory under $HOME I want to track 
> > 
> > Same thing, but make your ! pattern more specific.
> 
> thanks again!

You're welcome, though while reading the quoted text I noticed a typo in
my instructions. The second echo should obviously be _appending_ to
.gitignore:

  $ echo '!.*' >>.gitignore

Hopefully that was obvious, but I thought I would point it out for the
record.

-Peff
