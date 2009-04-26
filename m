From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and
 Mercurial
Date: Sun, 26 Apr 2009 11:21:40 +0200
Message-ID: <op.uszlmeoo1e62zd@merlin.emma.line.org>
References: <200904260703.31243.chriscool@tuxfamily.org>
 <m363grq13i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Christian Couder" <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 27 05:02:56 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly0aV-0001bk-LZ
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 11:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbZDZJVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 05:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbZDZJVq
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 05:21:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:53201 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752787AbZDZJVo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 05:21:44 -0400
Received: (qmail invoked by alias); 26 Apr 2009 09:21:43 -0000
Received: from g226233177.adsl.alicedsl.de (EHLO mandree.no-ip.org) [92.226.233.177]
  by mail.gmx.net (mp005) with SMTP; 26 Apr 2009 11:21:43 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19NIjoz8tRNGkfj3SXiJvV3i4A0dohrCD6N3b2i8X
	X2j5eyg89hjf4/
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id 52D27940DF;
	Sun, 26 Apr 2009 11:21:41 +0200 (CEST)
In-Reply-To: <m363grq13i.fsf@localhost.localdomain>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117596>

Am 26.04.2009, 10:16 Uhr, schrieb Jakub Narebski <jnareb@gmail.com>:

> I can't comment on MS Windows support, but AFAIK Mercurial has better
> support here than Git.

I have some experience here, and with exception to the SVN 1.6 breaks  
git-svn for https:// (probably due to misbehaviour of APR or SVN stuff on  
Cygwin), it works flawless on Cygwin 1.5. (SVN 1.5 on Cygwin 1.5 or SVN  
1.6 on Cygwin 1.7 seem to work).

I wonder why people are always pissed at Cygwin - it's quite easy to setup  
and works.

With Mercurial, I've sometimes found that it's awkward to integrate with  
other tools such as Emacs. It only works if you use the hg.exe approach,  
which entails packing the whole module library into the .exe and is  
inefficient. Particularly, it seems slower on start than the native or  
byte-compiled Python code for many operations. Not benchmarked, just a gut  
feeling. And I'm talking about a rather swift laptop here, Intel Core Duo  
T2500 (2 x 2 GHz), 2 GB RAM, Win XP SP3.

> The deciding feature (well, one of deciding features) was the fact
> that Mercurial has better HTTP support... I guess (it was not obvious
> from the analysis, but it was hinted at) that Mercurial uses its
> custom protocol over HTTP, as opposed to "dumb" HTTP protocol support
> in Git.
>
> Perhaps it is time to restart work on _"smart" HTTP protocol_?

That would certainly be useful, but the "packs" approach is something that  
may make this more difficult than for Mercurial. Git+SSH works rather well  
though.

-- 
Matthias Andree
