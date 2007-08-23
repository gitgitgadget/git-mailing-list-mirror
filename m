From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 10:05:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708231003430.20400@racer.site>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
  <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> 
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> 
 <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <3f4fd2640708221419w624a9920o5dc9a9fcbd680be2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 11:06:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO8e4-0006UT-GG
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 11:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972AbXHWJGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 05:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756763AbXHWJGY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 05:06:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:39047 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756703AbXHWJGX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 05:06:23 -0400
Received: (qmail invoked by alias); 23 Aug 2007 09:06:22 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp047) with SMTP; 23 Aug 2007 11:06:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UhG8AxZ9UmM989FMXnQ9JmE0QkDQF+db7XeamQC
	4cHrWvakilEv+V
X-X-Sender: gene099@racer.site
In-Reply-To: <3f4fd2640708221419w624a9920o5dc9a9fcbd680be2@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56479>

Hi,

On Wed, 22 Aug 2007, Reece Dunn wrote:

> On 22/08/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 22 Aug 2007, Nicolas Pitre wrote:
> >
> > > On Wed, 22 Aug 2007, David Kastrup wrote:
> > >
> > > > If the scripting engine of choice for cobbling together prototypes
> > > > remains the Unix toolchain outside of git proper, then Windows users
> > > > will _always_ remain second class citizens since they will get to work
> > > > with and on new porcelain much later than the rest of the world:
> > > > namely when somebody bothers porting his new favorite tool for them to
> > > > C.
> > >
> > > Right.
> >
> > And not making the scripts builtins helps Windows users how, exactly?
> 
> IIUC, the plumbing is all (or mostly) ported to C code, whereas the
> remaining scripts are on the porcelain side.

Well, I know.  And guess three times why _I_ know.

> Given that you have to deal with other Windows issues (line ending,
> case insensitive file names, path format), why not put the current
> scripts in a posix porcelain directory and have a Windows porcelain
> directory where the Windows porcelain is written in C#?

Isn't C# yet another dependency?  Worse yet, a dependency that you plan to 
have on _one_ platform, and that is utterly unusable on other platforms?  
And don't give me the Mono talk.  I happen to be _very_ unhappy with the 
Mono dependency that SuSE introduced, because it is _slow_ _as_ _magma_.

> Alternatively, the porcelain could be unified to use Python and compiled 
> into an executable that is installed on the Windows platform (removing 
> the need to have anything other than git installed to use it).

Mentioning Python in this context is not even funny.

> This way, both camps (posix and Windows) will be happy.

No.  I would be _very_ unhappy should your plans come true.

Ciao,
Dscho
