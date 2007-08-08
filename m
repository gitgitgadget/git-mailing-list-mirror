From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 8 Aug 2007 18:20:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708081810130.14781@racer.site>
References: <f99cem$4a4$1@sea.gmane.org> <f99nm6$9vi$1@sea.gmane.org> 
 <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org> 
 <20070807145825.GO21692@lavos.net>  <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de>
  <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com> 
 <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de> 
 <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com> 
 <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de>
 <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 19:23:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIpFh-0008UY-OL
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 19:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934938AbXHHRUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 13:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbXHHRUp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 13:20:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:43953 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965082AbXHHRUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 13:20:43 -0400
Received: (qmail invoked by alias); 08 Aug 2007 17:20:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 08 Aug 2007 19:20:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/m12Fc0cHm/0s4DtASL1/MeMOtVaLjcNlFbQBp4M
	xKatpvk9QUiH+n
X-X-Sender: gene099@racer.site
In-Reply-To: <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55333>

Hi,

On Wed, 8 Aug 2007, Mark Levedahl wrote:

> On 8/8/07, Steffen Prohaska <prohaska@zib.de> wrote:
> >
> > The bottom line for me is, git does not yet support Windows in a
> > usable way for the organizations that I need to convince.
> >
> >         Steffen
> >
> 
> Have you considered jumping in to help on the msys git port Johannes
> Schindelin is working? He has very generously offered to do
> essentially everything except find bugs, the latter because he does
> not actually use Windows so can't, and is clearly putting a great deal
> of effort into this. A stable and complete Windows port may be much
> closer than you think.

To be fair, we are already a team of five working on it.  The 3rd 
generation of the net installer works as flawlessly as the first, but 
msysgit.git is a superproject now, containing the complete build 
environment you need, and has git/mingw/4msysgit.git as a submodule (yes, 
that is a fork of a fork; they work now on repo.or.cz).

Please find it on

	http://msysgit.googlecode.com/

(It's a meager 1.4 MB, so the whole rest is git-cloned natively!) It 
already passes all tests, is able to start gitk and git-gui, and more is 
to come!

And no, I did not agree to do _everything_.  I agreed to do things _when I 
get something in return_.

For example, we have a functional script sitting in msysgit.git which 
builds a complete WinGit installer (WinGit being the code name for "Git on 
MSys without the whole build environment").

It is incomplete in only a few issues:

	- it does not install anything in the start menu

	- it does not install any short cut on the Desktop

	- it does not install anything in the Quick Launch bar

	- it does not include a nice WelcomeToGit.html, to be launched 
	  after a successful install

	- it does not contain a nice way to start git-gui (you have to 
	  start it by hand from the command line inside bash)

	- etc.

So go for it, everybody, or alternatively do not even bother to whine.

Ciao,
Dscho

P.S.: I'll be not really available for a few days, starting from tomorrow, 
so do use the mailing list to keep in touch with others working on msysgit 
or 4msysgit, and do use the mob branch (you can bug the project members 
listed on the homepage to cherry-pick, sign off and push if need be).
