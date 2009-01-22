From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: git fast-import problem converting from CVS with git 1.6.1 and
 cvs2svn 2.2.0
Date: Thu, 22 Jan 2009 17:31:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901221729130.3586@pacific.mpi-cbg.de>
References: <63BEA5E623E09F4D92233FB12A9F794302BC6851@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F794302BC6855@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F794302BC6921@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 17:32:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ2Tw-0000qy-GA
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 17:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753380AbZAVQbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 11:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbZAVQbO
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 11:31:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:43089 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751161AbZAVQbN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 11:31:13 -0500
Received: (qmail invoked by alias); 22 Jan 2009 16:31:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 22 Jan 2009 17:31:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dowBwus7dd/KQr8F+UuJ40ISFWtJBcalxoBhMx6
	QFDNPumtZ9ojof
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302BC6921@emailmn.mqsoftware.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106760>

Hi,

On Thu, 22 Jan 2009, Kelly F. Hickel wrote:

> I found the section in question, it is:
> -- snip --
> commit refs/heads/TAG.FIXUP
> mark :1000007128
> committer cvs2svn <cvs2svn> 1002043747 +0000
> data 88
> This commit was manufactured by cvs2svn to create tag
> 'T_BU_Problem_9xxx_Merge_3-21-2000'.
> merge :1000007126
> M 100755 :180810 mfcdev/Domedit/DlgAddAlias.h
> -- snap --
> 
> By my count, 88 is the ending single quote character, leaving the '.' to
> be interpreted as a command.

Great!

> Looks like I should go post this on the cvs2svn list.....

Indeed.  I think that Michael will find the culprit very soon, with this 
detailed report.

BTW for future reference, please Cc: the people you are responding to.  
The Git mailing list is a high volume list, and people will miss you 
answers otherwise.

Thanks,
Dscho
