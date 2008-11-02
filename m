From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 1/2] bisect: add "git bisect replace" subcommand
Date: Sun, 2 Nov 2008 05:16:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811020515370.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20081102021910.fef1532e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 05:10:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwUID-0005FZ-1G
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 05:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbYKBEJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 00:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbYKBEJK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 00:09:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:56099 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750853AbYKBEJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 00:09:09 -0400
Received: (qmail invoked by alias); 02 Nov 2008 04:09:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 02 Nov 2008 05:09:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/1D9V4qVL1b+AijMS4hxw4V4GN3m1lPAp97SDHfz
	rVNI7WTjm5WXvA
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081102021910.fef1532e.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99806>

Hi,

On Sun, 2 Nov 2008, Christian Couder wrote:

> This new subcommand should be used when you have a branch or a part of a 
> branch that isn't easily bisectable because at some point, say A, a bug 
> as been introduced. The bug has been fixed latter at another point, say 
> B, but between these points the code is not easily testable because of 
> the bug, so it's not easy to bisect between these points.

Would it not be more intuitive to have support for

	git bisect skip A..B

?

Ciao,
Dscho
