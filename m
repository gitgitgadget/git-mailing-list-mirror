From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Tue, 6 Mar 2007 00:17:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060016020.13683@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	=?ISO-8859-1?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 00:17:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOMQm-00013f-Dh
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 00:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbXCEXRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 18:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbXCEXRR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 18:17:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:59548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751891AbXCEXRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 18:17:16 -0500
Received: (qmail invoked by alias); 05 Mar 2007 23:17:14 -0000
X-Provags-ID: V01U2FsdGVkX1+Oei02oWSObhM0mH4MMKR/nn6XrKPze4CA7HXsTI
	QL209qKuYf+uFV
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41502>

Hi,

On Mon, 5 Mar 2007, Linus Torvalds wrote:

> Anyway, I *suspect* that Dscho's patch might do the wrong thing for 
> something like
> 
> 	gitk -20 v1.4.4.. t/
> 
> exactly because of the subtle interaction between pathname limiting, 
> static commit limiting *and* commit number limiting. Dscho?

Correct. I'll have a look at Junio's patch shortly, which hopefully makes 
me forget my shortsighted patch.

Ciao,
Dscho
