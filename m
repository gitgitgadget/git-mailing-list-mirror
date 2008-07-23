From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Wed, 23 Jul 2008 17:15:44 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231713280.8986@racer>
References: <20080723145518.GA29035@laptop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-853453595-1216829745=:8986"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 18:17:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLh1B-0008BE-Ep
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYGWQPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbYGWQPp
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:15:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:35092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751394AbYGWQPo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:15:44 -0400
Received: (qmail invoked by alias); 23 Jul 2008 16:15:42 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp064) with SMTP; 23 Jul 2008 18:15:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+phxhmZf2p33Q7Jf39zv7iIlVPqDaNOHRildUgql
	ehAzr+ScUwOiM8
X-X-Sender: gene099@racer
In-Reply-To: <20080723145518.GA29035@laptop>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89698>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-853453595-1216829745=:8986
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 23 Jul 2008, Nguyễn Thái Ngọc Duy wrote:

> So in short, sparse prefix will be stored in config, core.sparsecheckout.

Do you really think the prefix should be stored anywhere else than the 
index?

With core.sparseCheckout you have to introduce a _sh*tload_ of config 
loaders.

And with core.sparseCheckout you are at the whim of the user, since 
.git/config is _supposed_ to be user-editable.

>From a logical point of view, I'd say that the sparse prefix has nothing 
to do with the "configuration" of the local repository.

Ciao,
Dscho

--8323329-853453595-1216829745=:8986--
