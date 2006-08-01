From: =?iso-8859-1?Q?J=F6rg?= W Mittag <Joerg.Mittag@Web.De>
Subject: Why I love GIT but use Subversion (was: GIT user survey)
Date: Tue, 1 Aug 2006 03:45:52 +0200
Message-ID: <1prv3rw6ldo9s$.dlg@jwmittag.my-fqdn.de>
References: <4d8e3fd30607230123m459aa1cle2ab8c1c1dd0fcd2@mail.gmail.com> <4d8e3fd30607300248m36b4038dv1fcd1f3716503905@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 01 03:50:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7jOe-0007TA-UH
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 03:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbWHABuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 21:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbWHABuI
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 21:50:08 -0400
Received: from main.gmane.org ([80.91.229.2]:62138 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030237AbWHABuG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 21:50:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1G7jOU-0007RD-Uv
	for git@vger.kernel.org; Tue, 01 Aug 2006 03:50:03 +0200
Received: from pd9e9949f.dip0.t-ipconnect.de ([217.233.148.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 03:50:02 +0200
Received: from Joerg.Mittag by pd9e9949f.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 03:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e9949f.dip0.t-ipconnect.de
User-Agent: 40tude_Dialog/2.0.15.1de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24562>

Paolo Ciarrocchi wrote:
> On 7/23/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
>> We would like to ask you a few questions about your use of the GIT
>> version control system. This survey is mainly to understand who is
>> using GIT, how and why.
> Thanks a lot to all the people that already filled the questionnaire.
> We received 89 full filled questionnaires but we can do better, if you
> didn't fill it please do it before the 6th of August.

Okay, I thought a bit about filling out that survey, but I couldn't
because it didn't really fit my needs.  After all, it's a Git *user*
survey and I'm only a *wannabe* user.

So, why am I only a wannabe Git user (and a frustrated Subversion
user) even though I like Git very much?  Well, there's a couple of
reasons (beware: this rant should have really been a blog post, but I
don't have a blog ...; also, being a rant, this post may contain
oversimplification, overgeneralization and overexaggeration.  Please,
don't feel offended and also keep in mind that I'm not a native
speaker.).

The most important reason why I'm not using Git is probably that I'm
the wrong kind of user: Git is a source code(1) management system for
Linux(2) developers(3) and I am

  (1) not managing source code, 
  (2) not using Linux and 
  (3) not a developer.
  
Please note that there's nothing actually wrong with that---you can't
drive screws with a hammer and you can't make coffee with a
screwdriver but that doesn't mean that the hammer or the screwdriver
are buggy, it just means you have either the wrong problem or the
wrong tool.

So, I don't really know whether the fact that Git doesn't support my
operating environment and my workflow is (a) a problem with Git being
too specialized or (b) a problem with me choosing the wrong tool.
This is probably actually the most important question I have, because
if the answer is (a) I just need to wait some more until Git matures,
but if the answer is (b) I need to forget about Git and start looking
for another tool.

In my opinion, version control needs to integrate and really blend
into the operating environment and the workflow people use, because
otherwise, if it *doesn't* integrate but forces them to change their
operating environment, their workflow or their habits, people will get
lazy.  I know I would.  And being lazy about version control is even
worse than not having any version control at all, just as with backups
it gives you a false sense of security.

In my case the operating environment is the Windows Explorer or
Eclipse and my workflow is basically dragging and dropping files with
the mouse.  I can do just that with TortoiseSVN and Subclipse without
having to change the way I normally work.  With Git I would constantly
need to switch back and forth between Explorer or Eclipse and Cygwin.
That is, if I actually get Git compiled and up and running *at all*.
(Is there any unwritten rule in Git development that says that new
features are only accepted if they add a new dependency on a new
programming language?  Currently Git is implemented in C, POSIX sh,
Perl, Python, Tcl/Tk and C++ (if you include QGit) and I've already
seen some Ruby code posted to the mailing list.)

Don't get me wrong: Git is very nice.  Its similarity to a Unix
filesystem and the similarity of its UI to popular Unix command line
utilities means that it actually integrates perfectly with the Unix
shell, which also means that it integrates perfectly with the workflow
of people who mainly work in a Unix shell.  I'm sometimes using Git in
Linux where I mainly work from the command line and it's absolutely
amazing!  You have everything you would expect from your regular
environment: cat, diff, ls, tar, grep, mv, rm and even fsck!

But that's not the only operating environment, and it's certainly not
the one most widely used.  In order to be universally usable, Git
needs to also integrate with the Windows Explorer, MacOS Finder,
Konqueror, Nautilus, Eclipse and Visual Studio (among others).  It
needs to integrate with project management tools like Trac or Collaboa
and in order to do that it probably needs complete high-quality native
language bindings for Java, Perl, Python, Ruby, PHP, ...

Okay, let's answer two questions from the survey:

| Q20. What would you most like to see improved about GIT? (features,
|        bugs, plugins, documentation, ...)

The most pressing need for me would be a native Windows port.  Where
"native" means:

 - an installer package, 
 - integration with the Windows Explorer, 
 - handling of different line-ending encodings and 
 - addressing the fact that things like SSH clients, diff, patch, 
     merge, Perl, Python, Tcl/Tk, Bash and so on are usually not part 
     of a standard Windows installation and are also notoriously 
     difficult to install.

Number 2 would probably be providing the same level of integration for
Eclipse.

| Q21. If you want to see GIT more widely used, what do you think we
|        could do to make this happen?

What I think is most lacking is the ecosystem *around* Git, which is
actually not very surprising, considering that Git is still fairly
young compared to e.g. CVS and Subversion.  With "ecosystem" I mean
things like public repository hosting (currently it's mostly CVS
and/or Subversion and some Arch), integration in IDEs (e.g. Eclipse,
Visual Studio), project management software (e.g. Trac, Collaboa) and
so on.

The general theme is probably: make Git more seamless for more types
of users on more operating systems.

I currently use Subversion.  I hate Subversion.  I constanly hit the
limitations of the centralized model, and I hit them *very hard* and
*very often*.  I would *love* to migrate away as soon as possible.
There's only two reasons why I use Subversion: because I can install
it with three mouse clicks and because I can use it with three mouse
clicks.

Please, make those reasons go away.

Thank you for bearing with me through this long rant.

jwm

PS: I am well aware of the fact that Git is free software and that I
could fix all those issues myself.  However, the truth is, I can't.
I'm stupid.  I'm not a programmer.  So, please don't take this as a
demand or a request, merely a humble suggestion by a humble wannabe
user, whom you are free to ignore.
