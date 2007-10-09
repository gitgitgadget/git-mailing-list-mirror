From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rebase -i: use diff plumbing instead of porcelain
Date: Tue, 09 Oct 2007 16:26:49 +0200
Message-ID: <470B8FA9.3090600@viscovery.net>
References: <470B410F.1040506@viscovery.net> <Pine.LNX.4.64.0710091319400.4174@racer.site> <470B7581.3030301@viscovery.net> <Pine.LNX.4.64.0710091353140.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 16:27:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfG32-0005KL-BY
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 16:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbXJIO0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 10:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbXJIO0v
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 10:26:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53282 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbXJIO0v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 10:26:51 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfG2l-00056G-4w; Tue, 09 Oct 2007 16:26:43 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 43BE069F; Tue,  9 Oct 2007 16:26:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0710091353140.4174@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60417>

Johannes Schindelin schrieb:
> When diff drivers are installed, calling "git diff <tree1>..<tree2>"
> calls those drivers.  This borks the patch generation of rebase -i.
> So use "git diff-tree -p" instead, which does not call diff drivers.

Thanks a lot! That works much better.

-- Hannes
