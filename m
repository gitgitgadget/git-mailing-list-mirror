From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] remote: allow "-t" with fetch mirrors
Date: Thu, 26 May 2011 17:26:14 +0200
Message-ID: <4DDE7116.4070900@viscovery.net>
References: <20110526151100.GA2881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jimmie WESTER <jimmie.wester@stericsson.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 17:26:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPcS6-0007J6-Tj
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439Ab1EZP0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:26:17 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6989 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757774Ab1EZP0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:26:17 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QPcRy-0002jY-Ko; Thu, 26 May 2011 17:26:15 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5E61F1660F;
	Thu, 26 May 2011 17:26:14 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110526151100.GA2881@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174522>

Am 5/26/2011 17:11, schrieb Jeff King:
> +	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
> +		die("specifying branches to track makes no sense with non-fetch mirrors");

Don't proliferate no double negation. How about:

+		die("specifying branches to track makes sense only with fetch mirrors");

?

-- Hannes
