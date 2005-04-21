From: David Greaves <david@dgreaves.com>
Subject: Re: [PATCH] Improve usage messages
Date: Thu, 21 Apr 2005 17:43:55 +0100
Message-ID: <4267D84B.4090403@dgreaves.com>
References: <20050421124152.A28137F87D@smurf.noris.de> <20050421162505.GE30991@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 18:41:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOeiC-0007Kx-PH
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 18:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVDUQn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 12:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVDUQn6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 12:43:58 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:15570 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261538AbVDUQn5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 12:43:57 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id A92E4E6D5F; Thu, 21 Apr 2005 17:42:05 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 21126-08; Thu, 21 Apr 2005 17:42:05 +0100 (BST)
Received: from oak.dgreaves.com (modem-1822.leopard.dialup.pol.co.uk [217.135.151.30])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 18945E6D40; Thu, 21 Apr 2005 17:42:05 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DOemR-0002N0-Gd; Thu, 21 Apr 2005 17:43:55 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050421162505.GE30991@pasky.ji.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Thu, Apr 21, 2005 at 02:41:52PM CEST, I got a letter
> where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> 
>>This patch adds somewhat-improved usage messages to some of Linus' programs.
>>Specifically, they now handle -? / --help.

just so you know, the intention of doing the README.reference was to get 
all the docs in one place and then go back to the c and update the 
usage() to be consistent.

I started by doing
   grep usage *.c
:)

I'm actually working on diff-cache as we speak...

David
