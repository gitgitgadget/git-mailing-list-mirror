From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove unused code in parse_commit_buffer()
Date: Sun, 8 Jun 2008 16:46:32 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806081646200.1783@racer>
References: <1212871117-1509-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 17:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5N8b-00083O-7N
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 17:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbYFHPr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 11:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754999AbYFHPr5
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 11:47:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:36644 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755165AbYFHPr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 11:47:56 -0400
Received: (qmail invoked by alias); 08 Jun 2008 15:47:54 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 08 Jun 2008 17:47:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kb2xJkWikK2yCFZO/goRVw3kWH7IDUp7V7Ew8zC
	IGzto9L0NvQSiX
X-X-Sender: gene099@racer
In-Reply-To: <1212871117-1509-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84284>

Hi,

On Sat, 7 Jun 2008, Miklos Vajna wrote:

> The n_refs variable is no longer really used in this function, so there
> is no reason to keep it.
> 
> It was introduced in 27dedf0c and the code that really used it was
> removed in 7914053.

Nice catch!

Ciao,
Dscho
