From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] [1/2many] - FInd the maintainer(s) for a patch - scripts/get_maintainer.pl
Date: Wed, 15 Aug 2007 11:29:06 +0200
Message-ID: <46C2C762.7080205@s5r6.in-berlin.de>
References: <1186984174.10249.7.camel@localhost>  <200708131933.10125.m.kozlowski@tuxland.pl>  <1187026955.2688.4.camel@laptopd505.fenrus.org>  <1187037445.6628.98.camel@heimdal.trondhjem.org>  <1187054366.2757.0.camel@laptopd505.fenrus.org>  <46C10AA8.3090505@gmail.com> <20070814102033.604c8695@the-village.bc.nu>  <46C1CFFE.4000001@gmail.com> <1187110824.32555.76.camel@localhost>  <46C1EE6F.2080807@gmail.com> <1187116082.32555.122.camel@localhost> <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Joe Perches <joe@perches.com>, Rene Herman <rene.herman@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759881AbXHOJ3W@vger.kernel.org Wed Aug 15 11:29:53 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759881AbXHOJ3W@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILFCI-0001j7-IC
	for glk-linux-kernel-3@gmane.org; Wed, 15 Aug 2007 11:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759881AbXHOJ3W (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 15 Aug 2007 05:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbXHOJ3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Aug 2007 05:29:09 -0400
Received: from hp3.statik.tu-cottbus.de ([141.43.120.68]:37499 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbXHOJ3H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Aug 2007 05:29:07 -0400
Received: from [141.43.120.89] (ap10.statik.tu-cottbus.de [141.43.120.89])
	by hp3.statik.tu-cottbus.de (Postfix) with ESMTP id 3583639701;
	Wed, 15 Aug 2007 11:29:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.1.6) Gecko/20070802 SeaMonkey/1.1.4
In-Reply-To: <alpine.LFD.0.999.0708141131140.30176@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55889>

Linus Torvalds wrote:
> 	#!/bin/sh
> 	git log --since=6.months.ago -- "$@" |
> 		grep -i '^    [-a-z]*by:.*@' |
> 		sort | uniq -c |
> 		sort -r -n | head
> 
> and it gives you a rather good picture of who is involved with a 
> particular subdirectory or file.

No, it doesn't.  The subscribers of <subsystem-devel@somewhere.org> are
not listed in patch logs.
-- 
Stefan Richter
-=====-=-=== =--- -====
http://arcgraph.de/sr/
