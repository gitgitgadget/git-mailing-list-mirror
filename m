From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Wed, 26 Nov 2008 13:46:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811261344120.30769@pacific.mpi-cbg.de>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com> <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de> <492D227C.8020805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Wed Nov 26 13:40:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5JgK-0002Hq-9E
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 13:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbYKZMib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 07:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYKZMib
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 07:38:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:33938 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751553AbYKZMib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 07:38:31 -0500
Received: (qmail invoked by alias); 26 Nov 2008 12:38:29 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 26 Nov 2008 13:38:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cOiZyqGMc+jH5mJ6NQ1zmXWFsI3CA5N2ImkRk9n
	o1tfw2/VOF73Qb
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <492D227C.8020805@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101730>

Hi Ondrej & Michael,

On Wed, 26 Nov 2008, Michael J Gruber wrote:

> Johannes Schindelin venit, vidit, dixit 26.11.2008 01:14:
> 
> > Can you try again with a Git version that contains the commit 
> > 2075ffb5(fast-export: use an unsorted string list for extra_refs)?

Okay, so both of your use cases seem to be real bugs in fast-export.  May 
I respectfully submit a request for a test script (as patch to 
t/t9301-fast-export.sh)  which is as short as possible and shows the 
respective bugs?

My Git time budget these days is almost negative, so I will not be able to 
work on these issues without having a small and concise example.

Thanks so much,
Dscho
