From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move launch_editor() from builtin-tag.c to editor.c
Date: Fri, 18 Jul 2008 03:14:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807180313200.2906@eeepc-johanness>
References: <1216341378-15444-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 03:15:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJeYl-0007ur-PZ
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 03:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbYGRBOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 21:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753874AbYGRBOA
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 21:14:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:54927 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751582AbYGRBN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 21:13:59 -0400
Received: (qmail invoked by alias); 18 Jul 2008 01:13:57 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp005) with SMTP; 18 Jul 2008 03:13:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//90U9+BX/u6BqtjNiVxFDAGk8zjNt3vaVpKRRtI
	BwUcKDN43PYC+M
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1216341378-15444-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88946>

Hi,

On Fri, 18 Jul 2008, Stephan Beyer wrote:

> launch_editor() is declared in strbuf.h but defined in builtin-tag.c. 
> This patch moves launch_editor() into a new source file editor.c, but 
> keeps the declaration in strbuf.h.

Sorry, but that has been tried before.  Junio pointed out that 
launch_editor() iss too die()-happy, and that the messages are too bound 
to the current callers.

You need to at least provide an add-on patch to fix both issues.

Ciao,
Dscho
