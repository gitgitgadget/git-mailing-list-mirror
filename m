From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How do I control the automated commit message on a merge?
Date: Tue, 3 Jun 2008 23:51:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806032350170.13507@racer.site.net>
References: <bd2cb52a0806031455r151303achf0424b5320bf2f07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marvin Fraeman <marvin.fraeman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:53:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3fNf-0006qc-Vk
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 00:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbYFCWwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 18:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755842AbYFCWwh
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 18:52:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:44772 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753086AbYFCWwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 18:52:37 -0400
Received: (qmail invoked by alias); 03 Jun 2008 22:52:34 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 04 Jun 2008 00:52:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//cMlEOYr/OAVjM2NopzsCkgR2JVfO4aNCd137CA
	odLyY647yeSFqy
X-X-Sender: gene099@racer.site.net
In-Reply-To: <bd2cb52a0806031455r151303achf0424b5320bf2f07@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83723>

Hi,

On Tue, 3 Jun 2008, Marvin Fraeman wrote:

> when Git does a merge (no conflicts), it auto-generates a commit message 
> like:
> 
>         Merge branch 'master' of  /path/to/other/repo
> 
> How can I change this so my required string gets written at the
> beginning of the commit message.

s/./?/

You might be happy with a post-merge hook amending the commit with a 
completely different message.

Hth,
Dscho
