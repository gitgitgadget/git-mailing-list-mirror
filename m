From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sun, 20 Jan 2008 11:00:56 +0300
Message-ID: <20080120080056.GO14871@dpotapov.dyndns.org>
References: <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <alpine.LFD.1.00.0801191026500.2957@woody.linux-foundation.org> <B4FDA32F-16C9-497A-AAD8-27A8D510C4CB@wincent.com> <alpine.LFD.1.00.0801191659350.2957@woody.linux-foundation.org> <20080120052735.GA18581@glandium.org> <alpine.LFD.1.00.0801192130180.2957@woody.linux-foundation.org> <20080120070018.GA11015@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Wincent Colaiuta <win@wincent.com>,
	Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 09:01:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGV7e-0004pL-Ac
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 09:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYATIBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 03:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbYATIA7
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 03:00:59 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:57544 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbYATIA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 03:00:59 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 9F61D317AA;
	Sun, 20 Jan 2008 11:00:48 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-190-198.pppoe.mtu-net.ru [85.141.190.198])
	by smtp02.mtu.ru (Postfix) with ESMTP id F1448317B3;
	Sun, 20 Jan 2008 11:00:47 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JGV6u-0002X6-Mz; Sun, 20 Jan 2008 11:00:56 +0300
Content-Disposition: inline
In-Reply-To: <20080120070018.GA11015@glandium.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71163>

On Sun, Jan 20, 2008 at 08:00:18AM +0100, Mike Hommey wrote:
> 
> That said, the "decomposed" version of UTF-8 has nice side effects on
> OSX, with UTF-8 encoded RockRidge ISO-9660 volumes (with or without
> Joliet ; OSX will use RockRidge by default when it's there), for instance.

AFAIK, the RockRidge standard prescribes to use the portable character
set, and it has nothing to do with Unicode. Basically, it is a subset of
ASCII.

http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap06.html

So, I don't think UTF-8 encoded filenames are valid regardless whether
they are decomposed or not.

Dmitry
