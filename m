From: carbonated beverage <ramune@net-ronin.org>
Subject: Re: t9106 failure, bisect weirdness
Date: Wed, 21 Nov 2007 01:57:27 -0800
Message-ID: <20071121095727.GA13211@net-ronin.org>
References: <20071119230601.GA15624@net-ronin.org>
 <200711200552.27001.chriscool@tuxfamily.org>
 <20071120061314.GA21819@net-ronin.org>
 <200711210508.27455.chriscool@tuxfamily.org>
 <20071121045638.GA9184@net-ronin.org> <20071121091001.GA23266@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 10:57:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IumL7-0003Ve-P6
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 10:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbXKUJ5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 04:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbXKUJ5b
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 04:57:31 -0500
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:13619 "EHLO
	pd2mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbXKUJ5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 04:57:30 -0500
Received: from pd4mr3so.prod.shaw.ca
 (pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JRU00627OZS0XC0@l-daemon> for git@vger.kernel.org; Wed,
 21 Nov 2007 02:57:28 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
 by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JRU00FHMOZSS590@pd4mr3so.prod.shaw.ca> for
 git@vger.kernel.org; Wed, 21 Nov 2007 02:57:29 -0700 (MST)
Received: from prophet.net-ronin.org ([70.67.106.153])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JRU00K0AOZRNI30@l-daemon> for git@vger.kernel.org; Wed,
 21 Nov 2007 02:57:28 -0700 (MST)
Received: from ramune by prophet.net-ronin.org with local (Exim 4.50)
	id 1IumKl-0003UL-3H; Wed, 21 Nov 2007 01:57:27 -0800
In-reply-to: <20071121091001.GA23266@soma>
Content-disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65625>

> I can't reproduce it at all on any of my boxes, but does the following
> one-liner fix it consistently?

FYI, it's a Core 2 Duo @ 2GHz (Thinkpad Z61t).

Yup, I ran the test in a loop, and it went through 15 iterations without
failure.  This patch works for me.

Thanks!

-- DN
Daniel
