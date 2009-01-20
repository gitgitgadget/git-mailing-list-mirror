From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 18:14:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201810170.5159@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901192145.21115.bss@iguanasuicide.net> <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de> <200901201053.03256.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 18:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPKCv-0006D7-QF
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 18:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868AbZATROa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 12:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757803AbZATROa
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 12:14:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:58878 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757706AbZATRO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 12:14:29 -0500
Received: (qmail invoked by alias); 20 Jan 2009 17:14:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 20 Jan 2009 18:14:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19arp9SLita6m9oEnYqUox28ssltXes5NkznGGixE
	xCKNeDPr4B3yCy
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200901201053.03256.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106497>

Hi,

On Tue, 20 Jan 2009, Boyd Stephen Smith Jr. wrote:

> You are up too late Dscho.

You, sir, are absolutely correct.

> >Let's squash the two, okay?
> 
> Will do.  I expected the code changes to be larger than the test, and 
> when I finished it was completely the other way.  My next patch will be 
> all-in-one.

FWIW I think it is the correct thing to start with the test script, so 
that you get a better idea what to look out for.

And for patches of which I don't know if they are still necessary, I like 
to "git checkout <name>^ && make -j50 && git checkout <name> && (cd t && 
sh <test>)".

But for submission, I think it makes sense to squash them, except if you 
submit a bug report with a test script to show the validity of the report 
first, and only later decide that you want to fix it yourself.

Ciao,
Dscho
