From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-filter-branch.sh: don't use --default when
 calling rev-list
Date: Thu, 31 Jan 2008 00:49:06 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801310048350.23907@racer.site>
References: <47A109A7.1070502@nrlssc.navy.mil> <1201738186-28132-1-git-send-email-casey@nrlssc.navy.mil> <47A11317.2010409@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 31 01:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKNd2-0007Zc-FH
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 01:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbYAaAth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 19:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbYAaAth
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 19:49:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:34414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752710AbYAaAtg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 19:49:36 -0500
Received: (qmail invoked by alias); 31 Jan 2008 00:49:34 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp042) with SMTP; 31 Jan 2008 01:49:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1988fBQFVx82aqPFAO5KnxtP/GrcNW3wQ8qoq+d9h
	70+koULBZHTmWK
X-X-Sender: gene099@racer.site
In-Reply-To: <47A11317.2010409@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72083>

Hi,

On Wed, 30 Jan 2008, Brandon Casey wrote:

> This command requires a revision to be specified on the command line, so 
> remove '--default HEAD' from the arguments to git rev-list. They are 
> unnecessary.

But I thought that you wanted "git filter-branch --msg-filter=rot13" to 
work on HEAD by default?

Ciao,
Dscho
