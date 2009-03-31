From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Detached HEAD warning (again)
Date: Tue, 31 Mar 2009 12:04:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903311203490.10279@pacific.mpi-cbg.de>
References: <9099EAF5-6B43-4F15-A905-9E21B45B7AE9@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Mar 31 12:04:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Loap3-00058t-IK
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 12:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbZCaKCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 06:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZCaKCR
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 06:02:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:56054 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753770AbZCaKCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 06:02:16 -0400
Received: (qmail invoked by alias); 31 Mar 2009 10:02:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 31 Mar 2009 12:02:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+MWgHfzD+UcvHrFIFVWNBCh07trNL7SSERu3WX4
	NwzNcT7yw5p864
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <9099EAF5-6B43-4F15-A905-9E21B45B7AE9@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115244>

Hi,

On Mon, 30 Mar 2009, Pieter de Bie wrote:

> I strongly remember there being a discussion about this a few weeks ago, 
> but I can't find it. Basically, someone wanted to introduce a warning 
> every time someone commits on a detached HEAD. This was shot down 
> because there already is a big warning when you detach your HEAD (with 
> which I agree).
> 
> However, someone here: http://news.ycombinator.com/item?id=538619 
> pointed to an example here: http://book.git-scm.com/5_submodules.html , 
> which works with submodules:
> 
> 	$ git submodule update --init
> 	# sub/ is created
> 	$ (cd sub && touch a && git add a && git commit -am "Add new file")
> 	[detached HEAD 8641889] Add new file
> 	 0 files changed, 0 insertions(+), 0 deletions(-)
> 	 create mode 100644 a
> 
> 	$ git submodule update
> 	$ ls sub/a
> 	ls: sub/a: No such file or directory

	$ cd sub
	$ git checkout HEAD@{1}

Ciao,
Dscho
