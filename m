From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-svn: support fetch with autocrlf on
Date: Sun, 14 Feb 2010 00:59:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002140055550.20986@pacific.mpi-cbg.de>
References: <1265997155-3592-1-git-send-email-kusmabite@gmail.com>  <1265997155-3592-2-git-send-email-kusmabite@gmail.com>  <20100213122532.GA31653@dcvr.yhbt.net> <40aa078e1002130616u478397c0xf757d5424630e6cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 00:52:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgRmr-0008Gq-OC
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 00:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228Ab0BMXw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 18:52:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:47137 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758065Ab0BMXw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 18:52:27 -0500
Received: (qmail invoked by alias); 13 Feb 2010 23:52:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 14 Feb 2010 00:52:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hYcBq4Z8hfcab5tblwbx53tPfz2eDAIlH8fRq54
	e9mImBleZNU+yR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <40aa078e1002130616u478397c0xf757d5424630e6cf@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66000000000000003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139871>

Hi,

On Sat, 13 Feb 2010, Erik Faye-Lund wrote:

> I don't think it affects svn dcommit in any way, except from the 
> implicit svn rebase that svn dcommit performs. d3c9634e sets 
> core.autocrlf to "false" on init, but re-enabling it hasn't shown any 
> problems in my end. I'm using git-svn with these patches and 
> core.autocrlf enabled every day at my day-job.

To elicit a warm and fuzzy feeling about your patch, you will have to 
analyze the code paaths of dcommit, and how crlf affects them. Then you 
will have to describe why dcommit does not have a problem with crlf with 
your patches anymore.

Remember, the idea of a commit message is to optimize the overall time 
balance, i.e. avoid the many to perform what the one can do for them. And 
since you have to do that analysis for yourself anyway, it makes sense to 
write up the result in the commit message.

Thanks,
Dscho
