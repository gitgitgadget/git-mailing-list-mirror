From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: git-whatchanged -p anomoly?
Date: Fri, 19 Aug 2005 01:47:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508190146150.8295@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F042C819D@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0508181555370.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 01:47:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5u6J-0007gh-0B
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 01:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVHRXrI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 19:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVHRXrI
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 19:47:08 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3717 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932418AbVHRXrG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 19:47:06 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F28E5137808; Fri, 19 Aug 2005 01:47:05 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D6A72B09AC; Fri, 19 Aug 2005 01:47:05 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B82AEAD3A9; Fri, 19 Aug 2005 01:47:05 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DFFD8137808; Fri, 19 Aug 2005 01:47:04 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508181555370.3412@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 18 Aug 2005, Linus Torvalds wrote:

> Btw, it's a shame that git has all these "git rebase" etc helper scripts, 
> which rebase whole series of patches, but the simple "git re-do" which 
> basically ends up being a
> 
> 	git-diff-tree -p $old | git-apply --index &&
> 		git commit --reedit=$old

How about "git-cherry-pick-script"? Junio?

Ciao,
Dscho
