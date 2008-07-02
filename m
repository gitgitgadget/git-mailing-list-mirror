From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 3/7] Documentation: complicate example of "man
	git-command"
Date: Wed, 2 Jul 2008 17:31:48 -0400
Message-ID: <20080702213148.GA26921@fieldses.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu> <Pine.GSO.4.62.0806301706090.7190@harper.uchicago.edu> <20080701162358.GA18305@fieldses.org> <7vmyl1kvn6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@uchicago.edu>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 23:32:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE9wZ-0001fk-7T
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 23:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYGBVby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751997AbYGBVby
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:31:54 -0400
Received: from mail.fieldses.org ([66.93.2.214]:41389 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbYGBVbx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:31:53 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1KE9vY-00076H-UF; Wed, 02 Jul 2008 17:31:48 -0400
Content-Disposition: inline
In-Reply-To: <7vmyl1kvn6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87195>

On Tue, Jul 01, 2008 at 04:54:53PM -0700, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > On Mon, Jun 30, 2008 at 05:10:25PM -0500, Jonathan Nieder wrote:
> >> The manual page for the command invoked as "git clone" is named
> >> git-clone(1), and similarly for the rest of the git commands.
> >> Make sure our first example of this in tutorials makes it clear
> >> that it is the first two words of a command line that make up the
> >> command's name (that is: for example, the effect of "git svn
> >> dcommit" is described in git-svn(1)).
> >
> > Is this confusion really common?
> >
> > I can see how it might be possible in the case of a subcommand that
> > itself has subcommands, but it seems less likely in the two examples you
> > add below (where the third token is an option or a url).  I like your
> > "git svn" example better.  Or "git remote" might be good.
> >
> > --b.
> 
> While I agree with the above, are we ready to talk about "git-svn"
> or "git-remote" that early in the tutorial material?

No, but for the purposes of this example it's not necessary to be
familiar with the command.  (Though it might be less distracting to use
something that'll be discussed early on.)

> We would want to mention the typesetting convention early in the manuals
> (git(7), gittutorial(7) and user-manual.html) as well, so how about...
> 
> 	Conventions used in this document
>         ---------------------------------
> 
> 	When talking about a git subcommand 'cmd', this documentation
> 	typesets the name of it like 'git-cmd', and that is the name you
> 	ask for its manual page.
> 
>         Examples are typeset like this: `$ git cmd` (`$` is your command
> 	prompt, do not actually type it to your shell).  Note that a
> 	subcommand is specified as the first parameter to the 'git'
> 	program when you actually run it from the command line.

I'm not convinced this last sentence is necessary.

> 
> 	E.g. a typical command description may go like this:
> 
>         To propagate the changes you made back to the original subversion
>         repository, you would use 'git-svn dcommit' command.  It does
>         these things (long description here).  Some examples:

> 
>         ------------
> 	$ ... some example command sequence ...
>         $ git svn dcommit
>         ------------

Typographical conventions shouldn't need so much explanation.

I'm curious: Jonathan, was this the original patch the result of a
real-life instance of confusion?  What happened?

--b.

> 
>         For full details, type:
> 
> 	------------
>         $ man git-svn
>         ------------
