From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 15:18:51 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne0e36r.fr9.mdw@metalzone.distorted.org.uk>
References: <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx> <Pine.LNX.4.64.0602261217080.22647@g5.osdl.org> <20060226204027.GC30735@trixie.casa.cgf.cx> <81b0412b0603020618q3b205cdeuabc7e204044cca5b@mail.gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 02 16:19:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEpaI-0000ay-Ur
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 16:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWCBPS4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 10:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWCBPS4
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 10:18:56 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:43396 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751283AbWCBPSz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 10:18:55 -0500
Received: (qmail 26768 invoked by uid 110); 2 Mar 2006 15:18:51 -0000
To: git@vger.kernel.org
Received: (qmail 26755 invoked by uid 9); 2 Mar 2006 15:18:51 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1141312731 26015 172.29.199.2 (2 Mar 2006 15:18:51 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 2 Mar 2006 15:18:51 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17076>

"Alex Riesen" <raa.lkml@gmail.com> wrote:

> AFAIK, windows has only one argument, returned by GetCommandLine?

This is true, but there's a standard quoting convention which (in
particular) Microsoft's C library uses to split the single argument back
into an argv.  The spawn* functions quote; the C library startup stuff
unquotes and splits.

The actual quoting convention is /horrible/.  I had to implement the
darned thing once.  See

  http://sources.redhat.com/ml/cygwin/1999-08/msg00701.html

for the details.

-- [mdw]
