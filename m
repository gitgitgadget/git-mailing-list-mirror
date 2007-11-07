From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Mark 'git stash [message...]' as deprecated
Date: Wed, 07 Nov 2007 09:00:43 +0100
Message-ID: <473170AB.7030104@viscovery.net>
References: <20071106085134.GD4435@artemis.corp> <1194395205-27905-1-git-send-email-bdowning@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, tsuna@lrde.epita.fr,
	aghilesk@gmail.com, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:01:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpfqR-0005IX-8O
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756447AbXKGIAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 03:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756319AbXKGIAs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:00:48 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35898 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbXKGIAs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 03:00:48 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ipfpg-0004I0-Sl; Wed, 07 Nov 2007 09:00:17 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BF1BD69F; Wed,  7 Nov 2007 09:00:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1194395205-27905-1-git-send-email-bdowning@lavos.net>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63780>

Brian Downing schrieb:
> Complain to STDERR unless 'git stash save' is explicitly used.
> This is in preparation for completely disabling the "default save"
> behavior of the command in the future.
> 
> ...
> -'git-stash' [save] [message...]
> +'git-stash' save [message...]

Can't we have these two?

	git-stash
	git-stash save [message...]

'git stash' without a message as an equivalent of 'git stash save' is still 
very handy.

-- Hannes
