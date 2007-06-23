From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 100%
Date: Sat, 23 Jun 2007 13:21:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706231318180.4059@racer.site>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
 <Pine.LNX.4.64.0706220214250.4059@racer.site> <467B777D.C47BFE0E@eudaptics.com>
 <Pine.LNX.4.64.0706221122200.4059@racer.site> <86ps3oi7ma.fsf_-_@lola.quinscape.zz>
 <Pine.LNX.4.64.0706221347480.4059@racer.site> <86abusi1fw.fsf@lola.quinscape.zz>
 <Pine.LNX.4.64.0706230222330.4059@racer.site> <467CF380.6060603@lsrfire.ath.cx>
 <Pine.LNX.4.64.0706231154300.4059@racer.site> <467D06D4.9050203@lsrfire.ath.cx>
 <Pine.LNX.4.64.0706231259021.4059@racer.site> <467D0DE8.6030104@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1208263341-1182601260=:4059"
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 23 14:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I24c5-0006n6-8I
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 14:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbXFWMVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 08:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbXFWMVJ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 08:21:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:41102 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751001AbXFWMVI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 08:21:08 -0400
Received: (qmail invoked by alias); 23 Jun 2007 12:21:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 23 Jun 2007 14:21:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/JbJtOVO/PZlvkFcn7iVBTyoYp0ET659vQ4xxui
	mexqKNg0HzsiC0
X-X-Sender: gene099@racer.site
In-Reply-To: <467D0DE8.6030104@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50735>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1208263341-1182601260=:4059
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 23 Jun 2007, René Scharfe wrote:

> As I already hinted at, the common result of comparing two files, as 
> done by e.g. cmp(1), is one bit that indicates equality.  This 
> information is lost when using up/down rounding, but it is retained when 
> rounding down.  It's _not_ common to be unable to determine equality 
> from the result of a file compare.

And as _I_ already hinted, this does not matter. The whole purpose to have 
a number here instead of a bit is to have a larger range. In practice, I 
bet that the 100% are really uninteresting. At least here, they are.

For example, if you move a Java class from one package into another, you 
have to change the package name in the file. Guess what, I am perfectly 
okay if the rename detector says "100% similarity" here. Because if it is 
closer to 100% than to 99%, dammit, I want to see 100%, not 99%.

Nuff said about this subject.

Ciao,
Dscho

--8323584-1208263341-1182601260=:4059--
