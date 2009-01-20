From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce for_each_recent_reflog_ent().
Date: Tue, 20 Jan 2009 11:15:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201114250.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de> <7vmydp5tqj.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de> <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de> <7vprijra52.fsf@gitster.siamese.dyndns.org> <7vljt7r9mq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de> <7vpriimr93.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 11:17:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPDeu-00055l-Or
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 11:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbZATKPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 05:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbZATKPI
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 05:15:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:52259 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755208AbZATKPG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 05:15:06 -0500
Received: (qmail invoked by alias); 20 Jan 2009 10:15:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 20 Jan 2009 11:15:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IJkJEctvIolSZac7qwZiV4gwFaiat+OVmrSBl7W
	T+7TRe+VaZsksH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vpriimr93.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106464>

Hi,

On Mon, 19 Jan 2009, Junio C Hamano wrote:

> This can be used to scan only the last few kilobytes of a reflog, as a 
> cheap optimization when the data you are looking for is likely to be 
> found near the end of it.  The caller is expected to fall back to the 
> full scan if that is not the case.

FWIW I really like it, as it works around mmap() nicely.

Ciao,
Dscho
