From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t6013: replace use of 'tac' with equivalent Perl
Date: Mon, 1 Sep 2008 18:32:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809011831200.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1220212998-90810-1-git-send-email-benji@silverinsanity.com> <1220221897-6081-1-git-send-email-trast@student.ethz.ch> <48BBE682.2070000@op5.se> <41757CC9-DB9B-41C9-A698-E2948F79DC2C@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Thomas Rast <trast@student.ethz.ch>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Sep 01 18:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaCGB-0003yY-9a
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 18:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbYIAQ1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 12:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbYIAQ1E
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 12:27:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:51741 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751360AbYIAQ1D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 12:27:03 -0400
Received: (qmail invoked by alias); 01 Sep 2008 16:27:00 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 01 Sep 2008 18:27:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18E/A0Vw7AE2PtFvnOU6PpSPYFPKImeK2dgUEzeSW
	YFVuGmvuW8GX6I
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <41757CC9-DB9B-41C9-A698-E2948F79DC2C@silverinsanity.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94595>

Hi,

On Mon, 1 Sep 2008, Brian Gernhardt wrote:

> I am reminded of the last time I tried to remove a use of tac from git 
> (rebase -i, to be specific).  I was yelled at for trying to use perl, 
> and "sed -ne '1!G;$p;h'" turned out to be not portable enough.

Please note that using Perl in test scripts is considered less bad than 
using Perl in a shell script which is part of Git's core.

Ciao,
Dscho
