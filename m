From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 10:10:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708231006220.20400@racer.site>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
  <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> 
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> 
 <Pine.LNX.4.64.0708221713540.20400@racer.site>  <86mywjcwv7.fsf@lola.quinscape.zz>
 <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 11:10:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO8iF-0007te-No
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 11:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbXHWJKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 05:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754593AbXHWJKo
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 05:10:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:43355 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756147AbXHWJKn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 05:10:43 -0400
Received: (qmail invoked by alias); 23 Aug 2007 09:10:42 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.57]) [132.187.25.128]
  by mail.gmx.net (mp055) with SMTP; 23 Aug 2007 11:10:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18IGORWmUcIGNT6EEj7N0qTpno8Bs2hu2vOwvozwy
	Spe/2hx3opf+2c
X-X-Sender: gene099@racer.site
In-Reply-To: <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56480>

Hi,

On Wed, 22 Aug 2007, Reece Dunn wrote:

> On 22/08/07, David Kastrup <dak@gnu.org> wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > On Wed, 22 Aug 2007, Nicolas Pitre wrote:
> > >
> > >> On Wed, 22 Aug 2007, David Kastrup wrote:
> > >> > If the scripting engine of choice for cobbling together
> > >> > prototypes remains the Unix toolchain outside of git proper, then
> > >> > Windows users will _always_ remain second class citizens since
> > >> > they will get to work with and on new porcelain much later than
> > >> > the rest of the world: namely when somebody bothers porting his
> > >> > new favorite tool for them to C.
> > >>
> > >> Right.
> > >
> > > And not making the scripts builtins helps Windows users how,
> > > exactly?
> >
> > Red herring.  The proposal was not to do nothing, but rather give git
> > a dedicated scripting language internal to it.
> 
> That is a really neat idea.

Why?  Why should just _having_ a dedicated scripting language _per se_ be 
a neat idea?  We do not _need_ it!  We script git in bash, perl, other 
people in Python, Ruby, and even Haskell.  So why should we _take away_ 
that freedom from others to script Git in whatever language they like 
most?  There is no good reason.

> > Two suggestions of mine with different advantages were git-busybox and 
> > Lua.  A third one was once proposed by Linus with some code example: 
> > starting a scripting language from scratch.
> 
> Do you have a link to the proposal?

Go search in the mailing list archives.  It's not hard to find.

> > So obviously, the need for something like that is recognized, and not 
> > having to start from zero for that might be an advantage if a good, 
> > workable language can be found.
> 
> It would also aid the Windows porting effort by having a single, builtin 
> scripting engine that does not have differing behaviours on different 
> platforms.

What is your problem?  msysGit is coming along pretty fine _without_ that 
maintenance nightmare of an own scripting language.  We use bash and perl, 
thank you very much.

> One thing that will need sorting is the binding of the C 
> plumbing/builtin command API to the scripting language, but this 
> shouldn't be that difficult to do.

It is that easy that you could do it in an hour or so, right?  Or not.  We 
need a whole GSoC project to do that, since sorting out a decent API is 
_not_ easy.

Ciao,
Dscho
