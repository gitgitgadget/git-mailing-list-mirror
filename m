From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Moving "git remote add --mirror blah" functionality to
 "git clone --bare --origin=blah"
Date: Wed, 23 Apr 2008 10:59:59 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804231057470.4181@eeepc-johanness>
References: <480EF334.1090907@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Apr 23 12:01:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jobn8-0004aM-98
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 12:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbYDWKAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 06:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755529AbYDWKAG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 06:00:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:53712 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759629AbYDWKAB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 06:00:01 -0400
Received: (qmail invoked by alias); 23 Apr 2008 09:59:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp044) with SMTP; 23 Apr 2008 11:59:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dUR9QSgSdWf8jgEAHeIRF/AxNdi0ozV4RcgSCa5
	No3EVPiwLaGzOm
X-X-Sender: user@eeepc-johanness
In-Reply-To: <480EF334.1090907@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80205>

Hi,

On Wed, 23 Apr 2008, Paolo Bonzini wrote:

> In the thread "git remote update -> rejected" Junio and Johannes came to 
> the conclusion that "--mirror means that you do not have local 
> branches", because "you give control away to the other end on the ref 
> namespace".  Furthermore, it was agreed that --mirror currently makes 
> sense mostly (or only?) on a bare repository.

Yes.  But the opposite may not be true: if you plan to work on many 
workdirs, but the same repository, you might still want to have separate 
remotes layout.

In any case, I think that this discussion is too early: clone should be 
builtin first, making things much simpler because of being a very thin 
layer on top of init && remote && fetch.

But yes, there is a lot of work left on the builtin-clone to make it so.

Ciao,
Dscho
