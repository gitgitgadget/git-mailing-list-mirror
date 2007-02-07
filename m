From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW binary installer available
Date: Wed, 7 Feb 2007 17:16:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071713190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45C9E470.7030609@xs4all.nl>
 <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C9EB54.3040406@xs4all.nl> <Pine.LNX.4.63.0702071625341.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C9F184.1060300@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Nieuwenhuizen <janneke@gnu.org>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Feb 07 17:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEpT0-0001U5-UR
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 17:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161357AbXBGQQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 11:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbXBGQQP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 11:16:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:38207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161357AbXBGQQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 11:16:14 -0500
Received: (qmail invoked by alias); 07 Feb 2007 16:16:12 -0000
X-Provags-ID: V01U2FsdGVkX19635slm6R6B91NsKO07qhYth6HmCvc8ho4A8JaDj
	cT2A==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45C9F184.1060300@xs4all.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38936>

Hi,

On Wed, 7 Feb 2007, Han-Wen Nienhuys wrote:

> Johannes Schindelin escreveu:
> > 
> > You don't want to tell me that you x-compile Python when bundling 
> > LilyPond, do you?
> 
> See
> 
>   http://lilypond.org/vc/gub.darcs/patches/python-2.5.patch
>   https://sourceforge.net/tracker/?func=detail&atid=305470&aid=1597850&group_id=5470
> 
> I freely admit that it doesn't work very well, because the python build 
> procedure is rather naive when it comes to detecting installed modules.

So you _do_ build it? Phew.

A few months back, when we had that nasty Aussie on lily-devel whining 
about not being able to compile LilyPond on Windows, I tried to build 
_all_ of the dependencies on MinGW, including Python. Needless to say, I 
gave up...

BTW do you have side branches in that darcs gub repository? If not, I'll 
try to leech it into a git repo with tailor (I do not want to install 
darcs on all my machines, just to play with gub).

Ciao,
Dscho
