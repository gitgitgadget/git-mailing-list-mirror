From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git interix support
Date: Tue, 9 Mar 2010 12:24:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003091220510.3065@intel-tinevez-2-302>
References: <4B962456.20600@salomon.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Markus Duft <markus.duft@salomon.at>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:43:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyXy-0001Do-4l
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631Ab0CILYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 06:24:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:52634 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753658Ab0CILYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 06:24:31 -0500
Received: (qmail invoked by alias); 09 Mar 2010 11:24:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp007) with SMTP; 09 Mar 2010 12:24:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fEq19cBYfSnydtbNeufJXZwBPFmQmbkWharJBsn
	EitxcMOEn789pA
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4B962456.20600@salomon.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141822>

Hi,

On Tue, 9 Mar 2010, Markus Duft wrote:

> i have "ported" git to interix (haha, wasn't so much of a problem after
> all ;)). i have a small patch (attached).

Please inline the patch for easier review. Unless you want no review, that 
is :-)

>From a cursory view, it looks as if all your #ifdef INTERIX actually want 
to be #ifdef HAVE_POLL or some such (we try to define the appropriate 
flags regarding the available features in the Makefile, see for example 
HAVE_ALLOCA_H).

And of course, at some stage it would be good to at least skim
http://repo.or.cz/w/git.git?a=blob_plain;f=Documentation/SubmittingPatches

Ciao,
Dscho
