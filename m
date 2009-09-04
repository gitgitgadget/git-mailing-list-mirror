From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-completion.bash: prevent 'git help' from searching
 for git repository
Date: Fri, 4 Sep 2009 14:35:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909041434310.4605@intel-tinevez-2-302>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org> <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com> <20090904092929.23208.qmail@00cf3567a0e8b4.315fe32.mid.smarden.org> <alpine.DEB.1.00.0909041217370.4605@intel-tinevez-2-302>
 <20090904110936.6663.qmail@046e1bfbf7e41d.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 14:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjY0Y-0007JT-EV
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 14:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796AbZIDMfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2009 08:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756789AbZIDMfE
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 08:35:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:57520 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755862AbZIDMfD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2009 08:35:03 -0400
Received: (qmail invoked by alias); 04 Sep 2009 12:35:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp016) with SMTP; 04 Sep 2009 14:35:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yjwZPmMPyy/bfABGw7ELp9mXL+rvhFQP5uS1uzn
	tcbW/qiZ8XCQBg
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090904110936.6663.qmail@046e1bfbf7e41d.315fe32.mid.smarden.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127727>

Hi,

On Fri, 4 Sep 2009, Gerrit Pape wrote:

> On Fri, Sep 04, 2009 at 12:22:36PM +0200, Johannes Schindelin wrote:
> > -- snipsnap --
> > [PATCH] git help -a: do not look for a repository
> 
> Perfect, thanks.
> 
> Acked-by: Gerrit Pape <pape@smarden.org>

Hmm... I haven't checked if 'git help -a' wants to discover the (possibly 
repository-specific) aliases.  Have you?

Ciao,
Dscho
