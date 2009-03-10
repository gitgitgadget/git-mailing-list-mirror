From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] winansi: support ESC [ K (erase in line)
Date: Tue, 10 Mar 2009 12:31:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903101231240.14295@intel-tinevez-2-302>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 12:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh0D2-0004ZC-ED
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 12:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbZCJLbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 07:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbZCJLbs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 07:31:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:59609 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750928AbZCJLbr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 07:31:47 -0400
Received: (qmail invoked by alias); 10 Mar 2009 11:31:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 10 Mar 2009 12:31:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DICtK//ODiBKyH3uqwOfAteMOSYYLRRTp9pfr6N
	jSS7sNE5GHHTHf
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49B61377.90103@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112807>

Hi,

On Tue, 10 Mar 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > 	This fixes the last bit of msysGit issue 124 for me:
> > 
> > 		http://code.google.com/p/msysgit/issues/detail?id=124
> > 
> > 	which annoyed me one time to many today.
> > 
> > 	I had an earlier version which was smaller, but pretty hacky, in 
> > 	that it checked if fprintf is #define'd in xwrite(), and had 
> > 	special handling for that case.
> > 
> > 	This patch is only slightly hacky, in that it assumes that you do 
> > 	not try to output something that ends in an incomplete ESC [
> > 	sequence.
> 
> Good that I read mail before I start hacking. I was about to do something
> about this in a moment. ;)

Heh...

> > To make use of it during a fetch, write() needs to be overridden, too.
> 
> No, that's not necessary with the patch that I'm about to send in a
> moment. To replace write() for ANSI emulation really goes too far.

See my response to your patch...

Ciao,
Dscho
