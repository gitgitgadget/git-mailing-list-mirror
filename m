From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 3/3] Documentation: convert tutorials to man pages
Date: Fri, 2 May 2008 10:31:18 -0400
Message-ID: <20080502143118.GB16959@fieldses.org>
References: <20080502053051.c8066c4e.chriscool@tuxfamily.org> <8fe92b430805020255r1a06e169te583c371bde83ade@mail.gmail.com> <20080502124900.GA2923@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 02 16:32:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrwJ5-00035U-Ie
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 16:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760142AbYEBOb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759501AbYEBOb0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 10:31:26 -0400
Received: from mail.fieldses.org ([66.93.2.214]:33684 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758962AbYEBObY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 10:31:24 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JrwIA-0004iM-LD; Fri, 02 May 2008 10:31:18 -0400
Content-Disposition: inline
In-Reply-To: <20080502124900.GA2923@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81004>

On Fri, May 02, 2008 at 08:49:01AM -0400, Jeff King wrote:
> On Fri, May 02, 2008 at 11:55:10AM +0200, Jakub Narebski wrote:
> 
> > On 5/2/08, Christian Couder <chriscool@tuxfamily.org> wrote:
> > > This patch renames the following documents and at the same time converts
> > >  them to the man page format:
> > >
> > >  cvs-migration.txt -> gitcvs-migration.txt
> > >  everyday.txt      -> giteveryday.txt
> > >  tutorial.txt      -> gittutorial.txt
> > >  tutorial-2.txt    -> gittutorial-2.txt
> > 
> > I like the rest of the series, but this I have serious doubts about. I think
> > that manpage format is just not suitable for guides and tutorials (larger
> > works), especially that we have HTML and beginnings of info versions.
> > 
> > Beside, the filenames looks stupid... githooks would go in a pinch, but
> > other names...
> 
> I don't know about that:
> 
>   $ man perlretut | wc -l
>   2348
> 
> which is basically the same thing (funny name, and very long).

I'm with Jakub--I always found it awkward reading all that perl
documentation with man.

But I think that's outweighed by the advantages of much easier
cross-referencing.  (Sure, git(7) can tell them to fire up a web browser
and go find tutorial.html.  If you're lucky, your distro installed it
someplace, but where?  And it seems much more polite to refer them to
something that can be read with the same program they're already using.)

it seems rude to reference documents
in the man pages without giving users an immediate way to find them (if
you're lucky then your distro installed them someplace, but where?).

> At least
> for me, looking at a manpage is much more convenient than info or HTML.
> It's quick to load and easy to search through. Sure, the HTML will look
> a lot nicer. But it seems like if even a few people use the man version,
> the almost zero effort to generate them is worth it (though I would
> argue that it should remain "tutorial.txt" and "tutorial.html", but
> generate "gittutorial.1").

Yeah, that would be nice if it were easy to do.

--b.
