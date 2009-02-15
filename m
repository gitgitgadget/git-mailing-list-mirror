From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: filter-branch: Remove original/*
Date: Sun, 15 Feb 2009 20:47:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902152046090.10279@pacific.mpi-cbg.de>
References: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com> <alpine.DEB.1.00.0902142219010.10279@pacific.mpi-cbg.de> <7vvdrblcl0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Kidd <git@randomhacks.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 20:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYmyM-0001d9-KW
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 20:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbZBOTq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 14:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbZBOTq1
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 14:46:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:36379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752550AbZBOTq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 14:46:27 -0500
Received: (qmail invoked by alias); 15 Feb 2009 19:46:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 15 Feb 2009 20:46:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jG74rL9ij13ofgKT75zqgCoasWb3W5Aws3zAjVX
	aPJqm2e12MyUMC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdrblcl0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110047>

Hi,

On Sun, 15 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hmm.  Indeed, we ignore reflogs in log_ref_write() when the ref starts 
> > with refs/tags/ (implicitly, not explicitely).
> >
> > Maybe it is time to change that.
> 
> Why?  Most tags will be created once and will stay there.  That is how 
> tags are supposed to behave, isn't it?

Exactly my point.  In the common case, it does not change a thing.

However in the case that we _do_ change tags, would you not agree that the 
reflog is _the_ place to record the change?

Ciao,
Dscho
