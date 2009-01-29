From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: diff settings
Date: Thu, 29 Jan 2009 17:33:00 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291731220.3586@pacific.mpi-cbg.de>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi> <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu> <497CD352.2060402@tedpavlic.com> <alpine.GSO.2.00.0901251307030.12651@kiwi.cs.ucla.edu> <497D1AB7.7000208@tedpavlic.com>
 <4981D8AD.6000000@tedpavlic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Cascio <keith@CS.UCLA.EDU>, Teemu Likonen <tlikonen@iki.fi>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 17:34:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSZqH-0002iG-Pk
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 17:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbZA2Qcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 11:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbZA2Qcm
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 11:32:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:59689 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751320AbZA2Qcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 11:32:42 -0500
Received: (qmail invoked by alias); 29 Jan 2009 16:32:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 29 Jan 2009 17:32:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18XCPMlCJAXAL/j9d+TCDaeg+44HxQVB6LVyq1E1N
	LUgirCy+8bVaHW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4981D8AD.6000000@tedpavlic.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107703>

Hi,

On Thu, 29 Jan 2009, Ted Pavlic wrote:

> > This task is pretty easy in Mercurial because Mercurial porcelains are
> > implemented as modules that are all executed through the central "hg"
> > command. This isn't the case with git.
> 
> (on the other hand, having a "[defaults]" section that only applies when
> commands are called via "git" might be nice. That way you can use the
> "git-CMD" when you want to use CMD without the "[defaults]"... perhaps?)

Nope, the dash form is deprecated, and once y'all out there finally do not 
write it any more, we can start thinking about _not_ hardlinking the 
builtins to their dashed form anymore.

Believe it or not, we already have a distinction between what is called 
from scripts vs from humans: plumbing vs porcelain.  So you can set the 
defaults for porcelain as much as you want, but please leave plumbing 
alone.

Ciao,
Dscho
