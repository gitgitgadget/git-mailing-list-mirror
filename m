From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Subversion-style incrementing revision numbers
Date: Wed, 20 Sep 2006 00:40:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609200038120.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
 <20060919211844.GB8259@pasky.or.cz> <Pine.LNX.4.62.0609191525490.9752@joeldicepc.ecovate.com>
 <20060919220011.GD8259@pasky.or.cz> <Pine.LNX.4.62.0609191609090.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:41:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPoH0-0000oj-5h
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbWISWk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbWISWk7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:40:59 -0400
Received: from mail.gmx.de ([213.165.64.20]:38311 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752085AbWISWk6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 18:40:58 -0400
Received: (qmail invoked by alias); 19 Sep 2006 22:40:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp005) with SMTP; 20 Sep 2006 00:40:57 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Joel Dice <dicej@mailsnare.net>
In-Reply-To: <Pine.LNX.4.62.0609191609090.9752@joeldicepc.ecovate.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27308>

Hi,

On Tue, 19 Sep 2006, Joel Dice wrote:

> The scenario I envision is several developers, each with a clone of a 
> shared repository.  The clones would not have IRNs turned on, only the 
> shared repository.  So, when I do a "git push", I get an IRN back, and I 
> am not confused, because I know that IRN only applies to the shared 
> repository. Then, when I mark a Bugzilla bug as fixed and attach the IRN 
> to it, everybody knows that IRN refers to the shared repository.  After 
> all, I wouldn't mark the bug fixed if I had only committed it to my own 
> private repository.

Why not just tag the commit with something like "bugzilla/#bugid"? 
Granted, it makes for lots of tags. But we actually handle lots of tags.

BTW if your IRN just wants to serve to be less cryptic than SHA1s, you can 
try git-name-rev (of course, it is only immutable if you have a recent 
tag and use the --tags option).

Ciao,
Dscho
