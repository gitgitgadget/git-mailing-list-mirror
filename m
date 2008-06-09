From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] use natural ordering to display list of branches.
Date: Mon, 09 Jun 2008 10:00:09 +0200
Message-ID: <484CE309.6000908@op5.se>
References: <d45085aa0806051041y42ce467fq2e07371d225ccca3@mail.gmail.com>	 <e2b179460806060142y7edc92e4y7cbad6b3cfad1eac@mail.gmail.com> <d45085aa0806060154p58e7e87dk636d519cbdcf2dc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	mbp@sourcefrog.net
To: Cedric Vivier <cedricv@neonux.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 10:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5cJQ-00036N-Cf
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 10:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbYFIIAP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 04:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbYFIIAO
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 04:00:14 -0400
Received: from mail.op5.se ([193.201.96.20]:35956 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbYFIIAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 04:00:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8F4941B800AE;
	Mon,  9 Jun 2008 09:56:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNnXKuupP5nZ; Mon,  9 Jun 2008 09:56:21 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 7F7041B800A6;
	Mon,  9 Jun 2008 09:56:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <d45085aa0806060154p58e7e87dk636d519cbdcf2dc7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84370>

Cedric Vivier wrote:
> 
> I've found a discussion on the Apache mailing-list where the author,
> Martin Pool seems to ack that this is ok to include his code in GPL'ed
> code or even to relicense it :
> http://lists.debian.org/debian-glibc/2003/10/msg00016.html
> 

AFAIU, that's the same as putting it in the public domain.

> Also maybe we could use glibc's strverscmp instead, but am not sure of
> its portability ?

glibc is extremely portable. In particular the code that doesn't require
anything in particular from the OS (which strvercmp() really shouldn't).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
