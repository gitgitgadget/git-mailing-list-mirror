From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: --exec-path not always honored
Date: Tue, 17 Mar 2009 11:19:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903171117480.6393@intel-tinevez-2-302>
References: <49BF692B.9020002@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:21:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWPt-0005mp-G2
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbZCQKTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 06:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754055AbZCQKTc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:19:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:38141 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752392AbZCQKTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 06:19:32 -0400
Received: (qmail invoked by alias); 17 Mar 2009 10:19:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 17 Mar 2009 11:19:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ROZUlhNNRFS8wC/KmiHtrGneWhhxwF4qnO6Khdj
	CrJB41j9lvWuM2
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49BF692B.9020002@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113450>

Hi,

On Tue, 17 Mar 2009, Johannes Sixt wrote:

> I noticed this failure if I run git from the build directory:
> 
> $ ./git --exec-path=. gc

I am not sure if "." is what you think it is; I imagine it would be 
$GIT_DIR by the time the PATH variable is adjusted.

Could you try again with

	$ ./git --exec-path="$(pwd)" gc

?

Thanks,
Dscho
