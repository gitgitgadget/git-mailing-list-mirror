From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 1/2] Handle core.symlinks=false case in merge-recursive.
Date: Sat, 3 Mar 2007 21:39:12 +0100
Message-ID: <200703032139.12869.johannes.sixt@telecom.at>
References: <200703032032.47158.johannes.sixt@telecom.at> <Pine.LNX.4.63.0703032110200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 21:39:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNb0j-0005if-S0
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 21:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbXCCUjR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 15:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbXCCUjR
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 15:39:17 -0500
Received: from smtp3.noc.eunet-ag.at ([193.154.160.89]:33880 "EHLO
	smtp3.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030321AbXCCUjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 15:39:16 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.noc.eunet-ag.at (Postfix) with ESMTP
	id 75941373F1; Sat,  3 Mar 2007 21:39:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 1FD413B49C;
	Sat,  3 Mar 2007 21:39:13 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0703032110200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41324>

On Saturday 03 March 2007 21:11, Johannes Schindelin wrote:
> I think regardless of the value of core.symlinks, merging symbolic links
> does not make sense at all.

No doubt about that. Currently, the version of the "current" branch remains in 
the working tree. My patch does not change this behavior at all, it just does 
not call symlink(2), but allocates a regular file.

-- Hannes
