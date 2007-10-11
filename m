From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] fetch: if not fetching from default remote, ignore default
   merge
Date: Thu, 11 Oct 2007 08:39:54 +0200
Message-ID: <470DC53A.4050707@viscovery.net>
References: <Pine.LNX.4.64.0710110146200.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, hjemli@gmail.com, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 08:40:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfriJ-0003Wy-Gl
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 08:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbXJKGj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 02:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbXJKGj6
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 02:39:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:13521 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbXJKGj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 02:39:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ifrhz-0006Rg-5N; Thu, 11 Oct 2007 08:39:47 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A41A9A33B; Thu, 11 Oct 2007 08:39:54 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0710110146200.4174@racer.site>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60580>

Johannes Schindelin schrieb:
> +test_expect_success 'fetch with a non-applying branch.<name>.merge' '
> +	git config branch.master.remote yeti &&
> +	git config branch.master.merge refs/heads/bigfoot &&
> +	git config remote.blub.url one &&
> +	git config remote.blub.fetch 'refs/heads/*:refs/remotes/one/*' &&

Better use double-quotes around the refspecs.

> +	git fetch blub
> +'
> +

-- Hannes
