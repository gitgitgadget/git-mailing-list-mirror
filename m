From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: error: hook declined to update refs/heads/master
Date: Mon, 21 Jul 2008 11:54:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807211153340.3305@eeepc-johanness>
References: <80F1AC38-8A10-4184-BBFB-870399DE9A3A@sikatizen.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jonathan Biolaz <jonathan.biolaz@sikatizen.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 11:54:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKs6P-0008Dp-Cb
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 11:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbYGUJxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 05:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbYGUJxp
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 05:53:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:58107 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751664AbYGUJxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 05:53:45 -0400
Received: (qmail invoked by alias); 21 Jul 2008 09:53:43 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp007) with SMTP; 21 Jul 2008 11:53:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vQgZM8k0v3sRpJNBeEwmWm3eZyIWlOxRrZWs5y4
	SkTvkcR5g17Z2W
X-X-Sender: user@eeepc-johanness
In-Reply-To: <80F1AC38-8A10-4184-BBFB-870399DE9A3A@sikatizen.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89329>

Hi,

On Mon, 21 Jul 2008, Jonathan Biolaz wrote:

> $ git push origin master
> 
> Counting objects: 1709, done.
> Compressing objects: 100% (1523/1523), done.
> Writing objects: 100% (1709/1709), 1.95 MiB | 3818 KiB/s, done.
> Total 1709 (delta 535), reused 0 (delta 0)
> *** Project description file hasn't been set

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> error: hooks/update exited with error code 1
> error: hook declined to update refs/heads/master

Apparently, you have a hook installed on the remote side which checks for 
a valid description, and refuses even updating refs before you set the 
description correctly.

Hth,
Dscho
