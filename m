From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: receive.denyCurrentBranch
Date: Sun, 8 Feb 2009 11:30:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902081128420.10279@pacific.mpi-cbg.de>
References: <20090208042910.19079.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 11:31:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW6wF-00081s-Fs
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbZBHK3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 05:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbZBHK3d
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 05:29:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:60421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752983AbZBHK3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 05:29:32 -0500
Received: (qmail invoked by alias); 08 Feb 2009 10:29:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp053) with SMTP; 08 Feb 2009 11:29:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CFphl8coCXpV6M+lHBaqZ2tX4Sn0eZKAszt8dIg
	Pv5/7ZM5sZCKe3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090208042910.19079.qmail@science.horizon.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108948>

Hi,

On Sat, 7 Feb 2009, George Spelvin wrote:

> (Prompted by the 1.6.2-rc0 announcement.)
> 
> Myself, I always thought the obvious way to handle this problem was to
> detach the HEAD.  Is there a reson there's no "detach" option for this?

It's insane, that's what it is.

You have _no_ business meddling with a remote working directory, _except_ 
by logging into that machine and working on that working directory 
_directly_.

If you do not agree, you have not thought about the implications, i.e. 
what problems you buy.

Ciao,
Dscho
