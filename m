From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Pushing and fetching sha1s directly
Date: Sun, 23 Dec 2007 20:04:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712232003470.23902@racer.site>
References: <20071222211308.GA27281@pvv.org> <7vlk7mwchm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Finn Arne Gangstad <finnag@pvv.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 23 21:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6X4z-0005Ih-R1
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 21:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbXLWUFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 15:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754658AbXLWUFV
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 15:05:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:50235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754655AbXLWUFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 15:05:20 -0500
Received: (qmail invoked by alias); 23 Dec 2007 20:05:17 -0000
Received: from R16df.r.pppool.de (EHLO [192.168.220.101]) [89.54.22.223]
  by mail.gmx.net (mp027) with SMTP; 23 Dec 2007 21:05:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6TNoCQFf6fN0x0q0pRybrv+XBBQG7IO4GUk7mLW
	UF2BMBgsuivlpZ
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlk7mwchm.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69196>

Hi,

On Sat, 22 Dec 2007, Junio C Hamano wrote:

> Finn Arne Gangstad <finnag@pvv.org> writes:
> 
> > Currently there seems to be no way of pusing a sha1 directly, or to 
> > fetch a sha1 directly. When working with submodules, it is convenient 
> > to be able to work with detached HEADs, so it would be good if this 
> > could be supported also by fetch and push.
> 
> For fetch, I would normally say "check the list archives", but it was 
> very long time ago that it was proposed and discussed. It has some 
> security and performance implications.

To enhance on that: sometimes you need to delete a branch in a hurry, 
because you publicised some secret code/file.  In that case, you do _not_ 
want people being able to fetch arbitrary commits.

Ciao,
Dscho
