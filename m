From: Petr Baudis <pasky@suse.cz>
Subject: Official Git Homepage change? Re: git-scm.com
Date: Sat, 26 Jul 2008 03:53:14 +0200
Message-ID: <20080726015314.GU32184@machine.or.cz>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 03:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMYzI-00012N-2I
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 03:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752623AbYGZBxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 21:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752610AbYGZBxS
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 21:53:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56424 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485AbYGZBxR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 21:53:17 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 44AE3393B321; Sat, 26 Jul 2008 03:53:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90146>

  Hi,

On Fri, Jul 25, 2008 at 10:35:43AM -0700, Scott Chacon wrote:
> Anyhow, I'm discussing with Petr about where we want to go from here -
> what changes he'd like to make, etc, but I obviously value your
> opinion as well, so please let me know what you think.  The content
> has barely changed, it's really just a usability overhaul.  I want to
> make sure that whatever someone is looking for (especially someone
> new), they can find in a few clicks and a few seconds.

  when the initial NIH reaction passes, I have to admit that I do rather
like it - and it's not only because you keep mentioning how awesome I am
in your blog post. ;-)

  I wonder if all the Git users find the heading rather funny as I did,
instead of unprofessional - but maybe we don't care about users without
a particular sense of humor. I'm also not overly fond of the color theme
but I'm perhaps just too heavy of a blue fan.

  Plenty of minor fixes are available for pull at

	git://github.com/pasky/learn-github.git
	(http://github.com/pasky/learn-github/tree/master)

(Note that I didn't test whether the pages still look ok with my changes
since I have no Ruby on Rails setup; hopefully they should, though.)

  Other non-trivial nits:

  * I'm feeling a bit uneasy about listing so many projects using Git;
I haven't heard about quite a few of these and I'm not sure on what
merit should we list projects. "Prototype" or "Liftweb" and probably
even "Rubinius", is that going to ring a bell for major part of visitors
so that they say "oh, even _those_ guys are using Git"?

  * Cut the contributors list at 4 or 5 commits? Below that, the list
is getting fairly useless anyway and you have trouble with keeping the
names reasonably well-formed.

  * Reusing captions from command manpages in the Documentation page
shows nicely how awful they sometimes are. :-) This is probably something
to fix upstream, though.

  * Is "Git for the lazy" really unique in some regard to deserve to be
listed among the other resources? I think we should minimalize
redundancy at the documentation page, the amount of material is already
overwhelming and it should be obvious for the visitor which document to
choose based on his needs. I have similar doubts about the 37signals
resources.

	In other words, "let's keep the resources orthogonal!"

  * There is no reference to the Wiki in the documentation, only to the
[GitDocumentation] page; I think there should be a reference to the
[GitFaq] page too - a lot of important points that are not obvious
to newcomers are covered there. I'm just not sure where exactly to put
the link.

  * I would go as far as put the link to the Wiki itself to the
navigation bar, simply since it is such a crucial resource.

  * A guide on maintaining third-party patches is currently missing.

  * The development page is not referenced anywhere; the missing
information are mailing list details (how to subscribe) and a link to
SubmittingPatches. Also, I have recently talked with Junio about adding
a link to the Note from the Maintainer, but we didn't yet figure out
where to stabilize the location of that page.

> Next, I will be working on the larger end-user documentation project,
> which will linked to from the documentation page of this site, and
> probably the main page too.  I'll keep this list updated as I go,
> since people tend to think I don't care about the community when I try
> not to waste your time. :)

  How does that compare with the Git user manual? Have you considered
collaborating on that one, or what are your reasons not to? Or are you
trying to do something different?

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
