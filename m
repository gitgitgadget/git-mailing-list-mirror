From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Documentation: convert tutorials to man pages
Date: Fri, 2 May 2008 08:49:01 -0400
Message-ID: <20080502124900.GA2923@sigill.intra.peff.net>
References: <20080502053051.c8066c4e.chriscool@tuxfamily.org> <8fe92b430805020255r1a06e169te583c371bde83ade@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 14:49:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jruhz-0001Io-02
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 14:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934950AbYEBMtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 08:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934935AbYEBMtF
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 08:49:05 -0400
Received: from peff.net ([208.65.91.99]:3616 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934804AbYEBMtC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 08:49:02 -0400
Received: (qmail 1267 invoked by uid 111); 2 May 2008 12:49:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 May 2008 08:49:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 May 2008 08:49:01 -0400
Content-Disposition: inline
In-Reply-To: <8fe92b430805020255r1a06e169te583c371bde83ade@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80984>

On Fri, May 02, 2008 at 11:55:10AM +0200, Jakub Narebski wrote:

> On 5/2/08, Christian Couder <chriscool@tuxfamily.org> wrote:
> > This patch renames the following documents and at the same time converts
> >  them to the man page format:
> >
> >  cvs-migration.txt -> gitcvs-migration.txt
> >  everyday.txt      -> giteveryday.txt
> >  tutorial.txt      -> gittutorial.txt
> >  tutorial-2.txt    -> gittutorial-2.txt
> 
> I like the rest of the series, but this I have serious doubts about. I think
> that manpage format is just not suitable for guides and tutorials (larger
> works), especially that we have HTML and beginnings of info versions.
> 
> Beside, the filenames looks stupid... githooks would go in a pinch, but
> other names...

I don't know about that:

  $ man perlretut | wc -l
  2348

which is basically the same thing (funny name, and very long). At least
for me, looking at a manpage is much more convenient than info or HTML.
It's quick to load and easy to search through. Sure, the HTML will look
a lot nicer. But it seems like if even a few people use the man version,
the almost zero effort to generate them is worth it (though I would
argue that it should remain "tutorial.txt" and "tutorial.html", but
generate "gittutorial.1").

-Peff
