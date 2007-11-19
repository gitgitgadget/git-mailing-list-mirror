From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 17:01:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711191617150.12193@iabervon.org>
References: <1195477504.8093.15.camel@localhost> <fhsc7b$k4g$1@ger.gmane.org>
 <1195488877.10573.29.camel@localhost> <3057F6F3-BEAA-447A-AB79-A0AFB7DB8826@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonas Juselius <jonas.juselius@chem.uit.no>,
	Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:02:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuEhT-0007FK-Jj
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbXKSWB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbXKSWBZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:01:25 -0500
Received: from iabervon.org ([66.92.72.58]:57433 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409AbXKSWBY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 17:01:24 -0500
Received: (qmail 15234 invoked by uid 1000); 19 Nov 2007 22:01:23 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Nov 2007 22:01:23 -0000
In-Reply-To: <3057F6F3-BEAA-447A-AB79-A0AFB7DB8826@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65505>

On Mon, 19 Nov 2007, Benoit Sigoure wrote:

> On Nov 19, 2007, at 5:14 PM, Jonas Juselius wrote:
> >On Mon, 2007-11-19 at 17:05 +0100, Jakub Narebski wrote:
> > >Do I understand correctly that you don't support cloning via git://
> > >protocol?
> >
> >Yes, that is correct. The machine is behind a number of firewalls, and I
> >simply cannot be bothered to go through the bureaucracy...
> 
> You can create a repository on repo.or.cz then :)
> 
> As it is often the case different people happen to work on similar things
> without knowing each other.  I started http://repo.or.cz/w/tutorial.git which
> is meant to be a big Beamer presentation that presents Git thoroughly.  I
> wrote some ideas but didn't start to write the slides.  Just in case you want
> to have a look.
> 
> One of the things you said in your guide is that Git is easy to learn.  I
> think this is wrong.  Git is way more complicated than most other SCMs,
> especially compared to SVN.

I convinced my little company to switch to git (from arch, so take this 
with a grain of salt). I'd previously written a document explaining how to 
use arch, and I wrote a version for git, which said practically nothing, 
because everything I'd been able to do in arch is trivial to do in git. 
But I used the same format, anyway, to be sure to cover everything. I also 
told them to ask me if they were trying to do something and couldn't. I 
believe that all of the questions I've gotten were on how to use "advanced 
features" (i.e., things not included in my document because I never 
figured out how to do them with arch and decided to just live without), 
and people are using git successfully.

The main difference I see is that "save" and "publish" are separate 
operations with git and the same with other SCMs, but the separate 
concepts are obvious to anybody who's emailled a word processor document 
to somebody, and the distinction just has to be mentioned.

The challenge in writing a good introduction to git is leaving out 
explanations of all of the wonderful things that git can do that people 
don't expect to be within the abilities of an SCM. If you limit yourself 
to saying how to do things that SCMs can traditionally do, and therefore 
only explain how to do what people know they want to do, it's not to hard 
for people to learn. Of course, that's not enough to make good use of git, 
but it's enough to declare a transition from SVN or CVS successful.

I personally think it would be worth having a pair of documents, with the 
first being "everything you need to know", and the second being "things 
you'll find helpful that aren't strictly necessary".

	-Daniel
*This .sig left intentionally blank*
