From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-filter-branch: add a new commit-filter
 example
Date: Sun, 24 Feb 2008 11:53:34 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0802241151390.6881@eeepc-johanness>
References: <20080223193058.GE31441@genesis.frugalware.org> <7vejb3319j.fsf@gitster.siamese.dyndns.org> <20080223220433.GG31441@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 11:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTEV9-0004Ll-F9
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 11:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbYBXKxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 05:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbYBXKxj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 05:53:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:52714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751171AbYBXKxi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 05:53:38 -0500
Received: (qmail invoked by alias); 24 Feb 2008 10:53:36 -0000
Received: from R3f77.r.pppool.de (EHLO eeepc-johanness.samsung.router) [89.54.63.119]
  by mail.gmx.net (mp035) with SMTP; 24 Feb 2008 11:53:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wmLYsT6DwyHavrzf69QvCh0xG9SuxT0G5U2e64f
	WZDWZoU5leFzJN
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080223220433.GG31441@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74923>

Hi,

On Sat, 23 Feb 2008, Miklos Vajna wrote:

> +-------------------------------------------------------
> +git filter-branch --commit-filter '
> +	sed -e "/^git-svn-id:/d" | git commit-tree "$@"
> +'
> +-------------------------------------------------------

And there I thought that was the job of --msg-filter ;-)

Ciao,
Dscho
