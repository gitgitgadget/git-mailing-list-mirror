From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: core.autocrlf considered half-assed
Date: Sat, 6 Mar 2010 00:23:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, torvalds@linux-foundation.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 00:16:30 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nngku-0004Xr-Gb
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 00:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755358Ab0CEXQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Mar 2010 18:16:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:50759 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753336Ab0CEXQX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Mar 2010 18:16:23 -0500
Received: (qmail invoked by alias); 05 Mar 2010 23:16:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 06 Mar 2010 00:16:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xQ0lHKC9xK8G8dNnwHB5hm54Qfyr0/GP2Un2lJv
	bgAjE1APpjh2xK
X-X-Sender: schindelin@pacific.mpi-cbg.de
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.77000000000000002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141601>

Hi,

back then, I was not a fan of the core.autocrlf support. But I have to 
admit that in the meantime, I turned into an outright un-fan of the 
feature. Not because its intent is wrong, but because its implementation 
is lousy.

Just try to "git reset --hard" or "git stash" when there are files with 
DOS line endings and when core.autocrlf is not false.

And then despair.

So again, for the record this time: core.autocrlf=true is handled 
_lousily_.

Ciao,
Dscho
