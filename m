From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Allow git-apply to fix up the line counts
Date: Thu, 05 Jun 2008 13:24:09 +0200
Message-ID: <4847CCD9.6000305@viscovery.net>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 13:25:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4Daa-00011l-PA
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 13:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997AbYFELYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 07:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754928AbYFELYM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 07:24:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10200 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbYFELYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 07:24:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K4DZg-0008Ga-F2; Thu, 05 Jun 2008 13:24:08 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3A26F6B7; Thu,  5 Jun 2008 13:24:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0806051115570.21190@racer>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83906>

Johannes Schindelin schrieb:
> +--fixup-line-counts::
> +	Fix up the line counts (e.g. after editing the patch without
> +	adjusting the hunk headers appropriately).

This sort of implies that there is some kind of output that tells the
correct line counts. But that isn't the case (if I read the patch
correctly). So I suggest to name the option --ignore-line-counts.

-- Hannes
