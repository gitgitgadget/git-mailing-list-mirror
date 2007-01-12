From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Importing from tarballs; add, rm, update-index?
Date: Sat, 13 Jan 2007 00:28:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701130023330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <6efbd9b70701120541n5dc4d0e1va50ae96543d8c80@mail.gmail.com>
 <7virfct737.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Riddoch <riddochc@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 00:28:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Vp5-0007YD-Em
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 00:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161156AbXALX2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 18:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161159AbXALX2d
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 18:28:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:36994 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161156AbXALX2c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 18:28:32 -0500
Received: (qmail invoked by alias); 12 Jan 2007 23:28:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 13 Jan 2007 00:28:29 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virfct737.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36729>

Hi,

On Fri, 12 Jan 2007, Junio C Hamano wrote:

> "Chris Riddoch" <riddochc@gmail.com> writes:
>
> > First, specifying extra files after 'git commit' bypasses the index.
> 
> Which I happen to think is a misfeature.

You probably should not teach people about that feature right away, 
because it has huge potential of shooting-yourself-in-your-own-foot.

But darn it, it's _useful_.

Very often I happen to find a subtle bug in the middle of my work. Which 
basically means that I have a dirty working tree, a dirty index, and I 
_need_ to commit something completely different. Usually it is a 
one-liner, which I don't even have to test in isolation, but with my dirty 
working tree. And usually it is in a file which was non-dirty until I 
put in a fix, so committing specific files -- bypassing the current index 
-- _is_ useful.

Ciao,
Dscho
