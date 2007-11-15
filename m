From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Bisect reset: remove bisect refs that may have been
 packed.
Date: Thu, 15 Nov 2007 09:27:37 +0100
Message-ID: <473C02F9.4020402@viscovery.net>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org> <7vwssj6hw8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:27:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Isa4s-0003sX-52
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 09:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbXKOI1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 03:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754785AbXKOI1l
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 03:27:41 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:5345 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868AbXKOI1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 03:27:40 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Isa40-0005n6-Kc; Thu, 15 Nov 2007 09:27:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 63E0E6C4; Thu, 15 Nov 2007 09:27:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vwssj6hw8.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65086>

Junio C Hamano schrieb:
> +	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* refs/heads/bisect |
> +	while read ref hash

If you also swap %(refname) and %(objectname), then this is also not prone 
to whitespace in refnames. (Yes, I know, there shouldn't be such, but...)

-- Hannes
