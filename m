From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-fetch: avoid local fetching from alternate (again)
Date: Wed, 07 Nov 2007 09:12:48 +0100
Message-ID: <47317380.4030102@viscovery.net>
References: <20071107024118.GA11043@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 09:13:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipg2M-00084B-NJ
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 09:13:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbXKGIMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 03:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756778AbXKGIMw
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 03:12:52 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36584 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695AbXKGIMw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 03:12:52 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Ipg1N-0004mD-KB; Wed, 07 Nov 2007 09:12:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A4A6069F; Wed,  7 Nov 2007 09:12:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071107024118.GA11043@spearce.org>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63785>

Shawn O. Pearce schrieb:
> +	err = start_command(&revlist);
> +	if (!err)
> +		err |= finish_command(&revlist);

There's a short-hand:

	err = run_command(&revlist);

-- Hannes
