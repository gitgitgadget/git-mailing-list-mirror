From: Federico Mena Quintero <federico@novell.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Fri, 19 Oct 2007 15:57:56 -0500
Message-ID: <1192827476.4522.93.camel@cacharro.xalalinux.org>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail .com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 19 23:09:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiz52-00022g-83
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 23:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765072AbXJSVHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 17:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764999AbXJSVHj
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 17:07:39 -0400
Received: from jericho.provo.novell.com ([137.65.248.124]:48714 "EHLO
	jericho.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765034AbXJSVHh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 17:07:37 -0400
Received: from [164.99.192.35] ([164.99.192.35])
	by jericho.provo.novell.com with ESMTP; Fri, 19 Oct 2007 15:07:19 -0600
In-Reply-To: <Pine.LNX.4.64.0710130130380.25221@racer.site>
X-Mailer: Evolution 2.11.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61763>

On Sat, 2007-10-13 at 01:46 +0100, Johannes Schindelin wrote:

> Jakub, thank you very much for doing this.  It is a very tedious work, and 
> I deem it invaluable.

Seconded!  This survey is very valuable, Jakub!

> >    Figure out why people find git hard to learn and eliminate those
> >    barriers to entry.  Make git more task-oriented rather than
> >    data-model-oriented the way it is now.
> 
> Frankly, expectations like these make me want to bang somebody's head on 
> the wall.  Why do people expect others to work for them for free?  Hard?

The "barriers to entry" / "data model" comment came from me :)

"Find out why people find git hard to learn and eliminate those barriers
to entry" is what we do with usability tests e.g. in GNOME.  You ask
people to use your software to accomplish well-defined tasks ("send a
mail to foo@bar.com", "using the word processor, copy this fancy printed
layout").  Then, you see how they *expect* your software to work, you
see in which places it doesn't behave like that, and you fix it.  This
produces very good results.  For Git in particular this could be things
like, "Import this project from SVN, fix a bug, commit the patch", or
"You are a maintainer, merge in these two branches from two
contributors".

"Make git more task-oriented rather than data-model-oriented" is about
making the tool adapt to what you usually want to do, instead of making
*you* adapt to the way the tool wants to work.  Many commands in Git
have documentation like

  "option --foo updates the refs without modifying the index.  Requires
  a clean working tree"

This is gibberish for people who are not very familiar with Git's
internals.  "Git for computer scientists" provides a *very nice*
explanation of the DAG and refs and tags, but unfortunately it doesn't
explain the index, why you would want to know about it, etc.

Git introduces a lot of terminlogy:  refs, index, working tree, remotes,
origin, HEAD (which is not the same as CVS HEAD!), detached head,
rebasing, porcelains, etc.  Even the basic documentation is hard to read
when you don't know all the terms yet.

It's nice that Git lets you manipulate the repository in all kinds of
ways, but presenting porcelains at the same level as plumbing makes
things hard for users to learn.  I was just in our Beijing office,
teaching people about development tools and Git in particular.

  Federico: "get Git from this location"

  Beijing hacker: tap tap tap, "okay, it's installed now"

  Federico "Git commands all start with 'git'"

  Beijing hacker: git<Tab>
  
  Bash: Display all 150 possibilities?

  Beijing hacker: "oh, shit..."

It's hard to know where to begin :)  Do I need "git-cherry-pick" or
"git-cherry"?  Why is the "apply a patch" command called "git-am"?  Why
is it different from "git-apply"?  From "git-applypatch"?  Etc.

  Federico
