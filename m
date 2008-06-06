From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use nonrelative paths instead of absolute paths for
 cloned repositories
Date: Fri, 6 Jun 2008 04:23:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806060422310.21190@racer>
References: <alpine.LNX.1.00.0806052244300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg KH <greg@kroah.com>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 05:25:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4SZt-0005Ca-OI
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 05:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbYFFDY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 23:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbYFFDY3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 23:24:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:35650 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753822AbYFFDY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 23:24:28 -0400
Received: (qmail invoked by alias); 06 Jun 2008 03:24:26 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 06 Jun 2008 05:24:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gebEOUfZgDVaVAvDxEwHHZRIZI0qLeYYweWu5CN
	t+OYzl16JVYbOC
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LNX.1.00.0806052244300.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84015>

Hi,

On Thu, 5 Jun 2008, Daniel Barkalow wrote:

> Particularly for the "alternates" file, if one will be created, we want 
> a path that doesn't depend on the current directory, but we want to 
> retain any symlinks in the path as given and any in the user's view of 
> the current directory when the path was given.

I have to say that I do not follow why the symlinks should be trusted any 
more than the absolute paths.

Ciao,
Dscho
