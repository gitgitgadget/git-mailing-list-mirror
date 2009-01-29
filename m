From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git gc" removes ".git/refs/heads/master".
Date: Thu, 29 Jan 2009 20:50:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901292050050.3586@pacific.mpi-cbg.de>
References: <83c97f59a5a5e59f908f3fc125d26adb@lunox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bernd Lommerzheim <bernd@lommerzheim.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 20:51:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LScvO-00028B-BO
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 20:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756153AbZA2TuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 14:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755832AbZA2TuS
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 14:50:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:46737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755041AbZA2TuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 14:50:17 -0500
Received: (qmail invoked by alias); 29 Jan 2009 19:50:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 29 Jan 2009 20:50:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PMihuLpVPvg07yAtaS8+aVCPQFL2WvOEab2Wjnt
	2UfnPjvR+xUEPt
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <83c97f59a5a5e59f908f3fc125d26adb@lunox.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107722>

Hi,

On Thu, 29 Jan 2009, Bernd Lommerzheim wrote:

> maybe I found a bug in git. When I execute "git gc" in my local 
> repository, git removes the file ".git/refs/heads/master". Is this an 
> intended behavior (but why?) or is that a bug?

No, it packs the refs.  You have no business accessing files in .git/ 
directly :-)

Ciao,
Dscho
