From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Why I love GIT but use Subversion (was: GIT user survey)
Date: Tue, 1 Aug 2006 12:13:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608011201030.17230@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4d8e3fd30607230123m459aa1cle2ab8c1c1dd0fcd2@mail.gmail.com>
 <4d8e3fd30607300248m36b4038dv1fcd1f3716503905@mail.gmail.com>
 <1prv3rw6ldo9s$.dlg@jwmittag.my-fqdn.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-73588562-1154427224=:17230"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 12:13:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7rG6-0000RA-N4
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 12:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWHAKNu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 06:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWHAKNu
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 06:13:50 -0400
Received: from mail.gmx.de ([213.165.64.21]:39352 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932546AbWHAKNt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 06:13:49 -0400
Received: (qmail invoked by alias); 01 Aug 2006 10:13:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 01 Aug 2006 12:13:47 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: =?iso-8859-1?Q?J=F6rg?= W Mittag <Joerg.Mittag@Web.De>
In-Reply-To: <1prv3rw6ldo9s$.dlg@jwmittag.my-fqdn.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24591>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-73588562-1154427224=:17230
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 1 Aug 2006, Jörg W Mittag wrote:

> beware: this rant should have really been a blog post, but I don't have 
> a blog ...;

This is the most polite rant I saw in a long time (including my own rants 
;-).

> (a) a problem with Git being too specialized or (b) a problem with me 
> choosing the wrong tool.

Definitely (a). But I might add "still".

> (Is there any unwritten rule in Git development that says that new 
> features are only accepted if they add a new dependency on a new 
> programming language?  Currently Git is implemented in C, POSIX sh, 
> Perl, Python, Tcl/Tk and C++ (if you include QGit) and I've already seen 
> some Ruby code posted to the mailing list.)

Funny, this is also _my_ pet peeve. Although for different reasons: I do 
not so much mind the dependency as the inconvenience with having different 
programming styles, and often having to build the basic library functions 
in every of these languages. Also, some people do not speak Perl or Bash 
or Python

> The most pressing need for me would be a native Windows port.  Where
> "native" means:
> 
>  - an installer package, 
>  - integration with the Windows Explorer, 
>  - handling of different line-ending encodings and 
>  - addressing the fact that things like SSH clients, diff, patch, 
>      merge, Perl, Python, Tcl/Tk, Bash and so on are usually not part 
>      of a standard Windows installation and are also notoriously 
>      difficult to install.

Let's see: the installer should not be a problem. (Several free options 
come to mind).

Integration with the Windows Explorer is a bit tricky: first, most of the 
Linux cracks have not worked with Windows APIs, and there is also the 
problem that you need to convert the file names from/to braindead MS 
why-not-put-a-colon-into-absolute-filenames names.

You do not need handling of different line-ending encodings _as long_ as 
you have the same throughout your project.

And for the notoriously difficult part: why not just bundle a cygwin 
environment, stripped-down to fit just the needs of git?

Of course, it would be a bit nicer if we had a MinGW32 port, and in fact, 
I played with it a little. But the sad truth is: Windows lacks so many of 
the good features of POSIX. It is not a project for just one afternoon to 
make it run (although I admit that I have it running a "git-log -p" 
successfully!).

> PS: I am well aware of the fact that Git is free software and that I
> could fix all those issues myself.  However, the truth is, I can't.
> I'm stupid.  I'm not a programmer.  So, please don't take this as a
> demand or a request, merely a humble suggestion by a humble wannabe
> user, whom you are free to ignore.

Hey, you may be not a programmer, but what you just did was very valuable: 
write about the problems you have with git.

And you _can_ do more: like Junio said, ask people you know who work on 
Windows to help...

Ciao,
Dscho

---1148973799-73588562-1154427224=:17230--
