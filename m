From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/9] Makefile: Normalize $(bindir) and $(gitexecdir)
 before comparing
Date: Tue, 22 Jul 2008 01:48:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807220147320.3407@eeepc-johanness>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Jul 22 01:48:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL572-0003C8-S5
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 01:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbYGUXrR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 19:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbYGUXrR
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 19:47:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:40547 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752041AbYGUXrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 19:47:16 -0400
Received: (qmail invoked by alias); 21 Jul 2008 23:47:15 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp050) with SMTP; 22 Jul 2008 01:47:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ceh5c/v0c0qcDpUi5hbO6IdOeAw6o5duvEs8iEP
	UjUkMOI+IcYh3h
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89419>

Hi,

On Mon, 21 Jul 2008, Johannes Sixt wrote:

> +	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
> +	execdir=$$(cd '$(DESTDIR_SQ)$(gitexecdir_SQ)' && pwd) && \

These lack quotes, no?

Ciao,
Dscho
