From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git clone out of memory. alternatives?
Date: Fri, 28 Mar 2008 12:55:47 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803281250230.3802@racer.site>
References: <beb5fde90803271929u40a98915ifd05234476ab92f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeffrey Chang <jeffrey.chang@duke.edu>
X-From: git-owner@vger.kernel.org Fri Mar 28 12:56:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfDCF-0002Ah-Bm
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 12:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYC1Lzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 07:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbYC1Lzu
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 07:55:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:48849 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753226AbYC1Lzu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 07:55:50 -0400
Received: (qmail invoked by alias); 28 Mar 2008 11:55:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 28 Mar 2008 12:55:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/S1vhOvnHSvtPdbMQk8MskM7jubB2nHiit6SXDTd
	acuOKwl1xYG8nq
X-X-Sender: gene099@racer.site
In-Reply-To: <beb5fde90803271929u40a98915ifd05234476ab92f9@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78396>

Hi,

On Thu, 27 Mar 2008, Jeffrey Chang wrote:

> I am working with a large-ish git repository set up as a shared 
> repository.  I am the only user of this repository, and I access it over 
> ssh.
> 
> I am running into a problem where I can no longer clone the repository 
> on a new computer.  I get a message that seems to indicate that the 
> machine with the repository is running out of memory.

AFAICT the config variables pack.* (see config.txt) allow to tune the 
packing, even for cloning.

Hth,
Dscho
