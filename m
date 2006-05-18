From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shipping man pages?
Date: Thu, 18 May 2006 11:33:43 -0700
Message-ID: <7vodxvkws8.fsf@assigned-by-dhcp.cox.net>
References: <20060518074630.GA2994@code-monkey.de>
	<7vac9f69la.fsf@assigned-by-dhcp.cox.net>
	<1147945298.1320.35.camel@mjollnir>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tilman Sauerbeck <tilman@code-monkey.de>
X-From: git-owner@vger.kernel.org Thu May 18 20:33:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgnJk-0001bR-Fh
	for gcvg-git@gmane.org; Thu, 18 May 2006 20:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWERSdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 14:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWERSdp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 14:33:45 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:65184 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751111AbWERSdp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 14:33:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518183344.TJGL19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 14:33:44 -0400
To: Mark Rosenstand <mark@borkware.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20297>

Mark Rosenstand <mark@borkware.net> writes:

> On Thu, 2006-05-18 at 01:06 -0700, Junio C Hamano wrote:
>
>> If you are building from the source, please build from the
>> source.  Everything you need is right there.
>
> But asciidoc is a royal PITA to package or install - it doesn't even
> provide a Makefile: http://www.methods.co.nz/asciidoc/userguide.html#X38
>
> Additionally it carries the whole docbook dependency chain with it.

That's a consequence of _your_ choice to build the documentation
files from the source, when I give you preformatted files in
html/man branches and/or prepackaged binary distributions.  Even
plain "make all" nor "make install" do not build them.

IOW, not my problem.

We accomplish things by saying "I did this, it solves my
problem, and it would help others -- so I share", not by
demanding others to do things for you by saying "If you do this,
it would solve my problem.  Now go do it".  That's how open
source works.

>> Why does this have to come up so often, and everybody who asks
>> for them never supplies the patch to do so?
>
> Because it seems like a political decision rather than a technical one

I do not see why that is political.  Do you need a politician to
tell you what is source and what isn't?

> (it's trivial to add the docs as a prerequisite for the dist target.)

Being trivial does not change things a whit, because I do not do
things I consider useless only because they are trivial.

You have to first convince me that it is useful to others, and
one way to do so is by showing that you care deeply enough about
it -- doing the work yourself (instead of demanding _me_ to do
something I do not believe is a good idea yet) is a good way to
do so.  That would tell me that it is a real problem to you.
When that happens, I might start considering the possibility
that a solution to that problem may be useful to other people.

And it actually makes things actively worse to whine without
doing the work yourself when the necessary change is trivial.
You are saying that you cannot be bothered to do that yourself
even though the change is trivial, which implies you _can_ live
without formatted pages just fine.  The conclusion is that not
having the formatted pages is not such a big deal to you (after
all, asciidoc toolchain might be a bear to install, but the
documents formatted in it are very easy to read in the source
form).

Now, with a patch, Tilman showed us he cares deeply enough, so
I'll take a look at it.  Thanks, Tilman.
