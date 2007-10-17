From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] Fixing path quoting in git-rebase
Date: Wed, 17 Oct 2007 12:41:51 +0200
Message-ID: <4715E6EF.1000908@viscovery.net>
References: <B495731E-C854-450B-943B-B96248B8F609@steelskies.com> <11926134961610-git-send-email-maillist@steelskies.com> <11926134961549-git-send-email-maillist@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 12:42:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii6MK-0000Zn-8j
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 12:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759210AbXJQKl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 06:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759067AbXJQKl4
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 06:41:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:65346 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbXJQKlz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 06:41:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ii6LL-0003yF-Ga; Wed, 17 Oct 2007 12:41:39 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6FCEDA33B; Wed, 17 Oct 2007 12:41:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11926134961549-git-send-email-maillist@steelskies.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61364>

Jonathan del Strother schrieb:
> git-rebase used to fail when run from a path with a space in.
> 
> Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
> ---
>  git-rebase.sh |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)

Looks good and works. Thanks.

-- Hannes
