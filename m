From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Segmentation fault in git-svn
Date: Mon, 14 May 2007 11:02:41 +0200
Message-ID: <20070514090241.GA5493@xp.machine.xx>
References: <4623F613.5010108@midwinter.com> <20070503123512.GA6500@xp.machine.xx> <20070513082118.GC1168@muzzle> <46478B74.8010005@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 14 11:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnWSA-0001gN-Fj
	for gcvg-git@gmane.org; Mon, 14 May 2007 11:02:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbXENJCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 05:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbXENJCo
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 05:02:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:50580 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754075AbXENJCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 05:02:44 -0400
Received: (qmail invoked by alias); 14 May 2007 09:02:42 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp032) with SMTP; 14 May 2007 11:02:42 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+fEwMeuYafuwLLCr6xAiP59tS594a32M3l2qdUy/
	tmKTR1lbHfOGxR
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46478B74.8010005@midwinter.com>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47229>

On Sun, May 13, 2007 at 03:04:36PM -0700, Steven Grimm wrote:
>  I can confirm that the patch fixes the segfault for me too. Thanks!
> 
>  -Steve
> 

I can (hopefully) confirm this, too.

-Peter


Side Note:

I tried it yesterday and got a message which
looks something alike "connection closed ..." and after continuing the
import I got an segfault. But as I couldn't reproduce this today, it
seems that it was just a flacky connection and after the closed
connection the repo was just in an inconsistent state.

I'll propably try to import this repo a few more times, just to check
if it is really fixed.
