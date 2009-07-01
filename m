From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git bisect; is there a way to pick only from the children of a
 given commit
Date: Wed, 1 Jul 2009 20:59:34 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907012058290.4773@pacific.mpi-cbg.de>
References: <loom.20090701T170535-707@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Robert Stonehouse <rstonehouse@solarflare.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 20:58:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM50R-0002eO-VB
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 20:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbZGAS5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 14:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753091AbZGAS5z
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 14:57:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:44022 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752834AbZGAS5y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 14:57:54 -0400
Received: (qmail invoked by alias); 01 Jul 2009 18:57:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 01 Jul 2009 20:57:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/s2XZ5I/zsibO74ffhEvUGiW1GkF2ncUB/nnqL0v
	LuZEkbbvZiZrlX
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <loom.20090701T170535-707@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122592>

Hi,

On Wed, 1 Jul 2009, Robert Stonehouse wrote:

> featureA (which was a new build target) was broken at HEAD. It had been 
> developed on the featureA branch. After featureA was merged into master, 
> featureB (which had branched from master at the same point as featureA) 
> was merged with master.

Why don't you just mark the merge commit that introduced featureA as bad, 
then?

Ciao,
Dscho
