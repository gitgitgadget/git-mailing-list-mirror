From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: janitoring
Date: Thu, 23 Jul 2009 00:29:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907230028230.3155@pacific.mpi-cbg.de>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org> <7vws60cr9m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 00:27:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTkHt-00058n-P7
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbZGVW1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753049AbZGVW1l
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:27:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:44278 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753320AbZGVW1l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:27:41 -0400
Received: (qmail invoked by alias); 22 Jul 2009 22:27:39 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp020) with SMTP; 23 Jul 2009 00:27:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18o3DchNnYoSOTHPw1imU74ARRSia3bY2agDovtpf
	+Cy8PE7mgnwuzq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vws60cr9m.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123805>

Hi,

On Wed, 22 Jul 2009, Junio C Hamano wrote:

> Pierre Habouzit <madcoder@debian.org> writes:
> 
> > [PATCH 1/3] janitor: use NULL and not 0 for pointers.
> >
> >   I really dislike the use of 0 when NULL is meant. This patch probably
> >   fixes most of them. The biggest culprit is nedmalloc, but a few
> >   remnants exist in plain git code.
> 
> I am not enthused about "fixing" borrowed foreign code, unless we know
> that we are committed to support our fork.  My impression was that this
> ned stuff was borrowed by the MinGW folks with the understanding that we
> will slurp it with minimum modification and turn a blind eye to its
> sub-par coding styles, so that it can be more easily updated from the
> upstream?

Indeed.  Maintaining msysGit is enough of a burden already (and I do not 
often get to do fun stuff anymore).  So I really appreciate your concern 
here.

Ciao,
Dscho
