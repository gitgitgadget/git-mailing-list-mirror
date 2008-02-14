From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] hard-code the empty tree object
Date: Thu, 14 Feb 2008 12:39:01 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141238140.30505@racer.site>
References: <20080214103256.GA17951@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Kate Rhodes <masukomi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 13:39:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPdNE-00032j-3S
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 13:39:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760537AbYBNMi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 07:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759906AbYBNMi5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 07:38:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:49278 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758165AbYBNMi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 07:38:57 -0500
Received: (qmail invoked by alias); 14 Feb 2008 12:38:55 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 14 Feb 2008 13:38:55 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/ZW5MCl2/vXdhqN0/X3GH4wO9vlwLNOvFGmOyzt
	C/CdkfjlvxAWz1
X-X-Sender: gene099@racer.site
In-Reply-To: <20080214103256.GA17951@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73875>

Hi,

On Thu, 14 Feb 2008, Jeff King wrote:

> We also hard-code the special ref '{}' as an alias for the empty tree. 
> Users may refer to the empty tree by its sha1 or by '{}'.

Another idea just hit me: why not use "" (i.e. the empty string)?  It is 
not a valid ref name, and not a valid filename either...

But maybe that would be _too_ cute,
Dscho
