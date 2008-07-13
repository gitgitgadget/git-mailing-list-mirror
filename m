From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [HACK] t/test-lib.sh HACK: Add -s/--show-hack to test suite.
Date: Sun, 13 Jul 2008 15:21:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807131518370.4816@eeepc-johanness>
References: <1215375751-30853-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807062241040.7342@eeepc-johanness> <20080707140841.GB6726@leksak.fem-net> <alpine.DEB.1.00.0807071540310.18205@racer> <20080712222212.GC22323@leksak.fem-net>
 <alpine.DEB.1.00.0807130222320.2995@eeepc-johanness> <20080713110904.GG22323@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jul 13 15:22:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI1Wm-0001yd-37
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 15:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbYGMNVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 09:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753238AbYGMNVL
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 09:21:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:56343 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753229AbYGMNVL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 09:21:11 -0400
Received: (qmail invoked by alias); 13 Jul 2008 13:21:09 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp024) with SMTP; 13 Jul 2008 15:21:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mUDkLqLnmnG3mgnd7kLWwwqJyge2/hVv+NAwpUm
	0oC11/PLHQgB5L
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080713110904.GG22323@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88311>

Hi,

On Sun, 13 Jul 2008, Stephan Beyer wrote:

> I want to see that the test failed at "! :" and I can't see that
> on this output.
> 
> But perhaps I just have to reconfigure something, so that it will show 
> me.

Ah, I implicitely assumed that you would also pass the "-i -v" flags to 
the test script, as my fingers are already trained to do so whenever I 
call a test script:

$ sh -x t4150-am.sh -i -v

You will have to scroll back a few lines to see exactly what failed, but 
you will see the exact commands (also of functions that were called), 
together with their return values (i.e. what the function output, and what 
was assigned to variables).

All that using the screen estate much more cautiously than your output.

I use "sh -x t* -i -v" all the time,
Dscho
