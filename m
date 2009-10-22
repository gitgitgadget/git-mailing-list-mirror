From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Oct 2009, #03; Mon, 19)
Date: Thu, 22 Oct 2009 17:33:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910221732450.1263@felix-maschine>
References: <7vhbtv6c76.fsf@alter.siamese.dyndns.org> <200910191125.19997.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 22 17:34:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0zg2-0001ig-N2
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 17:34:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517AbZJVPdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 11:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756285AbZJVPdo
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 11:33:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:53699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756128AbZJVPdn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 11:33:43 -0400
Received: (qmail invoked by alias); 22 Oct 2009 15:33:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 22 Oct 2009 17:33:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DWWwMgXZDrYBvQd8laUgp6g1cEKkZ1zek2jcUzw
	VWsBmV5hqqTq4y
X-X-Sender: johannes@felix-maschine
In-Reply-To: <200910191125.19997.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131027>

Hi Johan,

On Mon, 19 Oct 2009, Johan Herland wrote:

> On Monday 19 October 2009, Junio C Hamano wrote:
> > * jh/notes (2009-10-09) 22 commits.
> >  - fast-import: Proper notes tree manipulation using the notes API
> >  - Refactor notes concatenation into a flexible interface for combining notes
> >  - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
> >  - Notes API: for_each_note(): Traverse the entire notes tree with a callback
> >  - Notes API: get_note(): Return the note annotating the given object
> >  - Notes API: add_note(): Add note objects to the internal notes tree structure
> >  - Notes API: init_notes(): Initialize the notes tree from the given notes ref
> >  - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
> >  - Add selftests verifying concatenation of multiple notes for the same commit
> >  - Refactor notes code to concatenate multiple notes annotating the same object
> >  - Add selftests verifying that we can parse notes trees with various fanouts
> >  - Teach the notes lookup code to parse notes trees with various fanout schemes
> >  - Teach notes code to free its internal data structures on request
> >  - Add '%N'-format for pretty-printing commit notes
> >  - Add flags to get_commit_notes() to control the format of the note string
> >  - t3302-notes-index-expensive: Speed up create_repo()
> >  - fast-import: Add support for importing commit notes
> >  - Teach "-m <msg>" and "-F <file>" to "git notes edit"
> >  - Add an expensive test for git-notes
> >  - Speed up git notes lookup
> >  - Add a script to edit/inspect notes
> >  - Introduce commit notes
> 
> > Is this good for 'next' now?
> 
> Not all of it.
> 
> I suspect the first 14 patches are stable and 'next'-worthy, although
> it would be nice if Dscho had the time to ACK them.

As you probably realized, I have little time for Git these days (mainly 
due to work), so please do not wait for me.

Ciao,
Dscho
