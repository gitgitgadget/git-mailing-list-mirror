From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bash completion: remove deprecated --prune from git-gc
Date: Sun, 14 Dec 2008 11:38:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812141137350.2014@eeepc-johanness>
References: <200812132008.08543.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 14 11:38:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBoMZ-0002wW-QD
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 11:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbYLNKgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 05:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbYLNKgv
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 05:36:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:50373 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752591AbYLNKgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 05:36:51 -0500
Received: (qmail invoked by alias); 14 Dec 2008 10:36:49 -0000
Received: from ini-firewall.unizh.ch (EHLO eeepc-johanness) [130.60.5.218]
  by mail.gmx.net (mp027) with SMTP; 14 Dec 2008 11:36:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++MTw2VIG+xcSaxUanW/8IMsc52AVxP1jHunTqCh
	VWvBDUBiuJfwCQ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200812132008.08543.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103058>

Hi,

On Sat, 13 Dec 2008, Markus Heidelberg wrote:

> -		__gitcomp "--prune --aggressive"
> +		__gitcomp "--aggressive"

git gc --prune is deprecated?  That's news to me.

How would you suggest, then, to remove the loose objects you always get 
with conflicts in a merge?

Ciao,
Dscho
