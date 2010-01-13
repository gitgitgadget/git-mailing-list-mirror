From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: default behaviour for `gitmerge` (no arguments)
Date: Wed, 13 Jan 2010 23:49:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001132348570.4985@pacific.mpi-cbg.de>
References: <loom.20100111T185144-655@post.gmane.org> <7v7hrojukz.fsf@alter.siamese.dyndns.org> <20100112162355.GB25092@coredump.intra.peff.net> <7vhbqr2nxt.fsf@alter.siamese.dyndns.org> <20100112182550.GA15696@coredump.intra.peff.net>
 <7vwrzmqypn.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1001131024420.3043@intel-tinevez-2-302> <7v6376pc9w.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1001131202510.3043@intel-tinevez-2-302> <7vpr5dn5vt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Gareth Adams <gareth.adams@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 23:44:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVBwd-0004oR-VJ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 23:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab0AMWn4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 17:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755627Ab0AMWn4
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 17:43:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:46868 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755063Ab0AMWn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 17:43:56 -0500
Received: (qmail invoked by alias); 13 Jan 2010 22:43:54 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp028) with SMTP; 13 Jan 2010 23:43:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+vrOISETSv1NC6kY0koL0AQKP0TSS2lko5Ih3SE5
	CNggHxR4hJSHEa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vpr5dn5vt.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136891>

Hi,

On Wed, 13 Jan 2010, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> What I was asking was:
> 
> 	*PROVIDED* *IF* you wanted to keep the same semantics between
>          them, then you would have patched i-b-n, but you didn't.  Was there
>          a reason callers of s-b-n should know about @{u} but callers of i-b-n
> 	shouldn't?
> 
> Expected answer was either:
> 
> 	(a) Codepath X that uses i-b-n shouldn't interpret @{upstream} as
>             a symbolic name given by the user, but it should treat it as a
>             mere SHA-1 expression instead for *this and that* reason.
>             Otherwise we will see *this* breakage when the user does
>             *that*.  That is why i-b-n doesn't know about the new syntax;
>             or
> 
> 	(b) It was a thinko; all codepaths that use i-b-n should know the
>             new syntax as they _are_ interested in learning the symbolic
>             name when the user gives @{upstream}.

And I gave answer (c): I do not remember.

Ciao,
Dscho
