From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Lots of loose objects
Date: Wed, 10 Oct 2007 20:37:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710102035420.4174@racer.site>
References: <87myuqwzp3.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-501862940-1192045068=:4174"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:38:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfhNr-0001qu-N6
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 21:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbXJJTiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 15:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbXJJTiI
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 15:38:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:38749 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754788AbXJJTiH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 15:38:07 -0400
Received: (qmail invoked by alias); 10 Oct 2007 19:38:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 10 Oct 2007 21:38:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pxt8tYDppnsMtrmcN5DzyzLnbdcjcX/+3DprjT+
	68JCiV3pXW+ZCG
X-X-Sender: gene099@racer.site
In-Reply-To: <87myuqwzp3.fsf@lysator.liu.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60534>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-501862940-1192045068=:4174
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 10 Oct 2007, David Kågedal wrote:

> I hade a tree that made git-gui complain that I had too many loose
> objects every time I started it (3072 to be precise).  Letting git-gui
> compress it for me didn't help.  Neither did git-gc, even with the
> --aggressive flag.
> 
> I noticed that I had a lot of loose files in .git/objects, and
> suddenly I remembered that there was a command called "git
> prune". Finally I was able to get rid of those loose objects.

Probably git-gui should check again, after the compacting stage, how many 
loose objects there are, and suggest to run git prune after a sufficiently 
terrifying warning message ("Should I prune unreferenced objects?  (DON'T 
do this if you share objects between repositories!) Yes / No").

Ciao,
Dscho

--8323584-501862940-1192045068=:4174--
