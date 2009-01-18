From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: update memory allocation for http headers
Date: Sun, 18 Jan 2009 15:55:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181554480.3586@pacific.mpi-cbg.de>
References: <be6fef0d0901180516q19327c18oa1d7ccc36ce3a87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 15:57:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZ57-00043L-IZ
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 15:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762055AbZAROzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 09:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761774AbZAROzd
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 09:55:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:52358 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756604AbZAROzd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 09:55:33 -0500
Received: (qmail invoked by alias); 18 Jan 2009 14:55:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 18 Jan 2009 15:55:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+B6dU+ijOBYXqi0rQlRo4RrQxraGPxWU5CK4ktfO
	L14tSArbFJdOU9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <be6fef0d0901180516q19327c18oa1d7ccc36ce3a87@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106205>

Hi,

On Sun, 18 Jan 2009, Ray Chuan wrote:

> In 753bc91 (Remove the requirement opaquelocktoken uri scheme), the
> header strings were with the removal "opaquelocktoken:" (16
> characters).
> 
> Unfortunately, this was without the corresponding change in memory
> allocation. In this patch we update these allocations.

Rather than doing this (which will result in as error-prone code), why 
don't you replace those things by strbufs?

Ciao,
Dscho
