From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/40] Windows: always chmod(, 0666) before unlink().
Date: Thu, 28 Feb 2008 12:09:55 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281208410.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-9-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 13:11:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUhbM-0008Qi-Ma
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 13:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757080AbYB1MK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 07:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756970AbYB1MK1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 07:10:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:60133 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756752AbYB1MK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 07:10:26 -0500
Received: (qmail invoked by alias); 28 Feb 2008 12:10:24 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp031) with SMTP; 28 Feb 2008 13:10:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XHRteT9hXsZOA7h893BdL4wSDqK2Y6uUSxk2ZXq
	ugLlG4ZGClLQk/
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-9-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75390>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> On Windows, a read-only files cannot be deleted. To make sure that
> deletion does not fail because of this, always call chmod() before
> unlink().

May I request that this embarrassing typo be fixed before applying? ("a 
read-only files" -> "read-only files".)

Thanks,
Dscho
