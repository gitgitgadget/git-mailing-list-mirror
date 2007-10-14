From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Switching from CVS to GIT
Date: Sun, 14 Oct 2007 19:20:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141916510.25221@racer.site>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>, Eli Zaretskii <eliz@gnu.org>,
	Make Windows <make-w32@gnu.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sun Oct 14 20:21:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih858-0002su-CZ
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 20:20:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758643AbXJNSUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 14:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758598AbXJNSUn
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 14:20:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:32897 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758417AbXJNSUm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 14:20:42 -0400
Received: (qmail invoked by alias); 14 Oct 2007 18:20:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 14 Oct 2007 20:20:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18abjcUN7gaRsjlmQqvS3j39sV+GHnVME8nIoGydq
	IdLhmfaayS2RmW
X-X-Sender: gene099@racer.site
In-Reply-To: <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60889>

Hi,

On Sun, 14 Oct 2007, Benoit SIGOURE wrote:

> Context: GNU make seems to be willing to switch from CVS to ... 
> something else.
> 
> On Oct 14, 2007, at 6:57 PM, Paul Smith wrote:
> 
> > [...] the big thing no one else seems to have addressed much in other 
> > discussions I've seen is portability.  It LOOKS like there are native 
> > ports of GIT to MINGW, but I have no idea how complete and usable they 
> > are.  If someone who has a Windows system could look into that it 
> > would be a big help.

There is msysGit.  This project is nearing to its first beta, being 
self-hosted since mid-August IIRC.

It is a port of Git to MinGW, using parts of MSys as long as we have 
dependencies on bash and perl.

I have no doubt that we'll manage to finish version 0.3 of the installer 
this week, still not decided if it is still alpha or already beta.

There are some issues with using msysGit, none of them really serious, but 
you better be ready to ask questions on this list or #git in case 
something crops up.  msysGit is young.

Having said that, IMHO msysGit is already quite usable, and should be 
pretty stable within a few weeks (if it is not already).

Ciao,
Dscho
