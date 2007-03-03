From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Handle core.symlinks=false case in merge-recursive.
Date: Sat, 3 Mar 2007 21:11:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703032110200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200703032032.47158.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1106613572-1172952718=:22628"
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Mar 03 21:12:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNaaX-0002Po-Vc
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 21:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbXCCUMB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 15:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbXCCUMB
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 15:12:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:40604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750879AbXCCUMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2007 15:12:00 -0500
Received: (qmail invoked by alias); 03 Mar 2007 20:11:58 -0000
X-Provags-ID: V01U2FsdGVkX18/yjY8RSI/kir8SPBajJRsp8h2gknpv6CZg7pTGf
	WglLVGd2MEzMcR
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200703032032.47158.johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41321>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1106613572-1172952718=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 3 Mar 2007, Johannes Sixt wrote:

> If the file system does not support symbolic links 
> (core.symlinks=false), merge-recursive must write the merged symbolic 
> link text into a regular file.

I think regardless of the value of core.symlinks, merging symbolic links 
does not make sense at all.

I'd suggest having two versions of the syml√∂ink/file, <name>√~ours and 
<name>~theirs instead.

Ciao,
Dscho

---1148973799-1106613572-1172952718=:22628--
