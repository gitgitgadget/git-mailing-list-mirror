From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] filter-branch: remove an unnecessary use of 'git
 read-tree'
Date: Tue, 15 Dec 2009 18:19:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912151819010.4985@pacific.mpi-cbg.de>
References: <4B274BDE.8000504@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 18:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKayy-0005JE-Q9
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 18:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbZLOROj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2009 12:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbZLOROj
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Dec 2009 12:14:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:42859 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932554AbZLOROi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2009 12:14:38 -0500
Received: (qmail invoked by alias); 15 Dec 2009 17:14:36 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 15 Dec 2009 18:14:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aJNJoC8kasMnzSuuPqt96zVJohprvXreyl2CbR6
	Ec5E4eO9D3PW8s
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B274BDE.8000504@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135291>

Hi,

On Tue, 15 Dec 2009, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> The intent of this particular call to 'git read-tree' was to fill an
> index. But in fact, it only allocated an empty index. Later in the
> program, the index is filled anyway by calling read-tree with specific
> commits, and considering that elsewhere the index is even removed (i.e.,
> it is not relied upon that the index file exists), this first call of
> read-tree is completely redundant.

Yes, indeed.

Ciao,
Dscho
