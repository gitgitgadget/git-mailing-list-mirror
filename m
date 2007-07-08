From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Sun, 08 Jul 2007 19:30:27 +0200
Message-ID: <20070708173027.GK1528MdfPADPa@greensroom.kotnet.org>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl>
 <Pine.LNX.4.64.0707081729040.4248@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 19:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7aak-00074p-Ft
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 19:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbXGHRaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 13:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbXGHRaa
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 13:30:30 -0400
Received: from smtp19.wxs.nl ([195.121.247.10]:35086 "EHLO smtp19.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbXGHRa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 13:30:29 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKV003W3FAROD@smtp19.wxs.nl> for git@vger.kernel.org; Sun,
 08 Jul 2007 19:30:27 +0200 (CEST)
Received: (qmail 4327 invoked by uid 500); Sun, 08 Jul 2007 17:30:27 +0000
In-reply-to: <Pine.LNX.4.64.0707081729040.4248@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51896>

On Sun, Jul 08, 2007 at 05:37:22PM +0100, Johannes Schindelin wrote:
> That is to be expected.  After all, the first is a script.  However, I 
> really have ask: how often per hour do you want to run that program?

I have a project that needs some cleaning-up and I'd like to do
it incrementally.  I think I'll have to run it about a dozen times.

> I am really unhappy that so much is talked about filtering out commits.  
> That is amost certainly not what you want in most cases.  In particular, I 
> suspect that most users would expect the _changes_ filtered out by such a 
> command, which is just not true.

I don't care about that either.  I'm just mentioning it because
it's mentioned in the git-filter-branch documentation (which you
added).

> The second is to rewrite the commit messages so that the hashes are 
> mapped, too.  But that should be relatively easy, too: you can provide a 
> message filter, and you can use the provided "map" function.  If this 
> seems to be what many people need, you can write a simple function and put 
> it into filter-branch for common use.

It's not going to be me (as I sais, I don't like shell programming).

skimo
