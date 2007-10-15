From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/3] Quoting paths in tests
Date: Mon, 15 Oct 2007 15:47:29 +0200
Message-ID: <47136F71.1050107@viscovery.net>
References: <4711486B.1050301@op5.se> <11924540291536-git-send-email-maillist@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 15:56:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhQIY-0003UE-0D
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 15:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759722AbXJONrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 09:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759124AbXJONrc
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 09:47:32 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11432 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757551AbXJONrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 09:47:31 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IhQHv-0005Ow-GH; Mon, 15 Oct 2007 15:47:19 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1B79769F; Mon, 15 Oct 2007 15:47:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11924540291536-git-send-email-maillist@steelskies.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60996>

Jonathan del Strother schrieb:
> -	svn import -m 'import for git-svn' . $svnrepo >/dev/null &&
> +	svn import -m 'import for git-svn' . '$svnrepo' >/dev/null &&
>  	cd .. &&
>  	rm -rf import &&
> -	git-svn init $svnrepo"
> +	git-svn init '$svnrepo'"

I don't see the point in changing an incorrect quoting to a different 
incorrect quoting that you fix up in a follow-up patch. It's *two* large 
patches to review instead of just one. I'm stopping the review here.

-- Hannes
