From: Ian Hilt <Ian.Hilt@gmx.com>
Subject: Re: BUG (v1.5.6.1): ./configure missing check for zlib.h
Date: Sat, 28 Jun 2008 23:13:55 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806282311100.3218@sys-0.hiltweb.site>
References: <4864DD65.1080402@mircea.bardac.net>  <m3prq3hr6n.fsf@localhost.localdomain>  <20080627150732.D88F64B4002@artemis.sr.unh.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: tom fogal <tfogal@alumni.unh.edu>
X-From: git-owner@vger.kernel.org Sun Jun 29 05:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCnNo-000350-H3
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 05:15:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbYF2DNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 23:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbYF2DNr
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 23:13:47 -0400
Received: from mail.gmx.com ([74.208.5.67]:39884 "HELO mail.gmx.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753606AbYF2DNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 23:13:46 -0400
Received: (qmail invoked by alias); 29 Jun 2008 03:13:44 -0000
Received: from cpe-75-185-208-72.woh.res.rr.com (EHLO [192.168.1.1]) [75.185.208.72]
  by mail.gmx.com (mp-us003) with SMTP; 28 Jun 2008 23:13:44 -0400
X-Authenticated: #47758715
X-Provags-ID: V01U2FsdGVkX1+UnG5q5wyUdMxoy0P29N/WgBTg+yoNzGUyIit6oM
	+nQanrDD1XbCvE
In-Reply-To: <20080627150732.D88F64B4002@artemis.sr.unh.edu>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86756>

On Fri, 27 Jun 2008 at 11:07am -0000, tom fogal wrote:

> I should note, however, that I disagree with that macro's logic in that
> it `searches' for zlib if the user does not specify it.  IMO, if the
> user does not give a --with option, and it doesn't work `out of the
> box' (without hacking FLAGS), macros should die with an error rather
> than retry with changed FLAGS.
> 
> -tom

Or, one could read the INSTALL file included with git,

 - Git is reasonably self-sufficient, but does depend on a few external
   programs and libraries:

	- "zlib", the compression library. Git won't build without it.

-- 
Ian Hilt
Ian.Hilt (at) gmx.com
GnuPG key: 0x4AFC1EE3
