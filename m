From: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.info>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Mon, 29 Aug 2005 11:35:34 +0300
Message-ID: <4312C8D6.9010200@kaijanaho.info>
References: <19723.1125249085@lotus.CS.Berkeley.EDU> <Pine.LNX.4.58.0508281045060.3317@g5.osdl.org> <43120BC5.8060608@kaijanaho.info> <Pine.LNX.4.58.0508281245150.3317@g5.osdl.org> <4312C492.2010307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 10:40:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9f7t-0000mc-B3
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 10:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVH2Ifs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVH2Ifs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 04:35:48 -0400
Received: from flowerpot.kaijanaho.info ([80.68.88.155]:59396 "EHLO
	flowerpot.kaijanaho.info") by vger.kernel.org with ESMTP
	id S1750854AbVH2Ifr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 04:35:47 -0400
Received: from [130.234.161.238] (dynamic-161-238.it.jyu.fi [::ffff:130.234.161.238])
  (AUTH: PLAIN gaia, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by flowerpot.kaijanaho.info with esmtp; Mon, 29 Aug 2005 11:40:45 +0300
  id 0005057C.4312CA0D.00001445
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: Martijn Kuipers <martijn.kuipers@gmail.com>
In-Reply-To: <4312C492.2010307@gmail.com>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7896>

Martijn Kuipers wrote:
> martijn@hobbes:~$ gcc-2.95 --std=c99 -pedantic -Wall -W -ofoo foo.c
> cc1: unknown C standard `c99'

This makes this test a little less useful.  Try with --std=c9x (GCC 2.95
is old enough not to know the standard by the "official" name).

According to GCC 3.0 C99 status page [1], 3.0 supported flexible array
members.  There is no similar page for 2.95.

-- 
Antti-Juhani

[1] http://gcc.gnu.org/gcc-3.0/c99status.html
